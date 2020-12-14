package org.phenopackets.coreig.tools.util;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.hl7.fhir.instance.model.api.IBaseCoding;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.CanonicalType;
import org.hl7.fhir.r4.model.CodeableConcept;
import org.hl7.fhir.r4.model.DomainResource;
import org.hl7.fhir.r4.model.Extension;
import org.hl7.fhir.r4.model.OperationOutcome;
import org.hl7.fhir.r4.model.OperationOutcome.IssueSeverity;
import org.hl7.fhir.r4.model.OperationOutcome.OperationOutcomeIssueComponent;
import org.hl7.fhir.r4.model.Parameters;
import org.hl7.fhir.r4.model.Resource;
import org.phenopackets.coreig.tools.command.MainCommand;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.client.apache.ApacheHttpRequest;
import ca.uhn.fhir.rest.client.apache.ApacheHttpResponse;
import ca.uhn.fhir.rest.server.exceptions.PreconditionFailedException;

public class Utils {

	private static Logger logger = LoggerFactory.getLogger(Utils.class);
	private static ObjectMapper objectMapper = null;
	public static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss.SSS");

	static {
		objectMapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
	}

	public static String ID_TAG_IRI = "http://github.com/phenopackets/core-ig/ig-tools/id-tag";
	public static String TAG_URI = "http://github.com/phenopackets/core-ig/ig-tools/tag";
	public static String TAG_GENERATED = "generated";
	public static String VALIDATION_EXT_URI = "http://github.com/phenopackets/core-ig/ig-tools/validation-error-count";

	public static String getIgPrefix(String igUrl) {
		igUrl = igUrl.substring(0, igUrl.lastIndexOf('/'));
		return igUrl.substring(0, igUrl.lastIndexOf('/'));
	}

	public static void tagResourceId(IBaseResource target, IBaseResource source) {
		String id = source.getIdElement().getValue();

		for (IBaseCoding coding : target.getMeta().getTag()) {
			if (coding.getSystem().equals(ID_TAG_IRI)) {
				coding.setCode(id);
				return;
			}
		}
		IBaseCoding tag = target.getMeta().addTag();
		tag.setSystem(ID_TAG_IRI);
		tag.setCode(id);
	}

	public static boolean addMetaProfile(Resource resource, String profile) {
		if (!resource.getMeta().hasProfile(profile)) {
			resource.getMeta().addProfile(profile);
			return true;
		}
		return false;
	}

	public static boolean removeMetaProfile(Resource resource, String profile) {
		List<CanonicalType> profiles = resource.getMeta().getProfile().stream()
				.filter(p -> p.getValue().equals(profile)).collect(Collectors.toList());
		resource.getMeta().getProfile().removeAll(profiles);
		return profiles.size() > 0;
	}

//	public static int getErrorCount(MethodOutcome methodOutcome) {
//		OperationOutcome outcome = (OperationOutcome) methodOutcome.getOperationOutcome();
//		if (outcome != null) {
//			return (int) outcome.getIssue().stream().filter(issue -> issue.getSeverity().equals(IssueSeverity.ERROR))
//					.count();
//		}
//		return 0;
//	}

	public static void validate(MainCommand main, DomainResource resource, String profile, Logger l) {
		int maxErrors = 0;
		Extension validationExt = resource.getExtensionByUrl(Utils.VALIDATION_EXT_URI);
		if (validationExt != null) {
			maxErrors = Integer.valueOf(validationExt.getValue().primitiveValue());
		}
		main.info("Validating with profile: " + profile + ", and max errors: " + maxErrors, true, l);
		Parameters params = new Parameters();
		if (profile != null) {
			params.addParameter("profile", profile);
		}
		MethodOutcome methodOutcome = null;
		OperationOutcome operationOutcome = null;
		try {
			methodOutcome = main.getClient().operation().onInstance(resource.getId()).named("$validate")
					.withParameters(params).returnMethodOutcome().execute();
			if (methodOutcome.getResource() instanceof OperationOutcome) {
				operationOutcome = (OperationOutcome) methodOutcome.getResource();
			} else {
				operationOutcome = (OperationOutcome) methodOutcome.getOperationOutcome();
			}
		} catch (PreconditionFailedException e) {
			// TODO Auto-generated catch block
			operationOutcome = (OperationOutcome) e.getOperationOutcome();
		}

		int actualErrors = checkOutcome(main, operationOutcome, l);

		if (actualErrors > maxErrors) {
			main.error("VALIDATION ERROR COUNT OF: " + actualErrors + " exceeded max allowed validation error count of:"
					+ maxErrors, true, l);
		}
		if (actualErrors < maxErrors) {
			main.warn("VALIDATION ERROR COUNT OF: " + actualErrors + " less than max allowed validation error count of:"
					+ maxErrors, true, l);
		}
	}

	public static boolean hasCategory(List<CodeableConcept> concepts, String category) {
		for (CodeableConcept concept : concepts) {
			if (concept.hasCoding("http://github.com/phenopackets/core-ig/CodeSystem/categories", category)) {
				return true;
			}
		}
		return false;
	}

	public static int checkOutcome(MainCommand main, OperationOutcome outcome, Logger l) {

		Map<IssueSeverity, List<String>> issues = new HashMap<>();
		issues.put(IssueSeverity.FATAL, new ArrayList<>());
		issues.put(IssueSeverity.ERROR, new ArrayList<>());
		issues.put(IssueSeverity.WARNING, new ArrayList<>());
		issues.put(IssueSeverity.INFORMATION, new ArrayList<>());
		issues.put(null, new ArrayList<>());
		if (outcome != null) {
			for (OperationOutcomeIssueComponent issue : outcome.getIssue()) {
				StringBuilder sb = new StringBuilder();
				IssueSeverity severity = issue.getSeverity();

				sb.append("Severity:" + severity);
				sb.append(", Code:" + issue.getCode());
				sb.append(", Details:" + issue.getDetails().getText());
				sb.append(", Location:" + issue.getLocation());
				sb.append(", Diagnositc:" + issue.getDiagnostics());

				issues.get(severity).add(sb.toString());

			}
		}

		// a one line output summary
		StringBuilder sb = new StringBuilder("Outcome summary: ");
		sb.append(issues.get(IssueSeverity.FATAL).size() + " fatals,");
		sb.append(issues.get(IssueSeverity.ERROR).size() + " errors,");
		sb.append(issues.get(IssueSeverity.WARNING).size() + " warnings,");
		sb.append(issues.get(IssueSeverity.INFORMATION).size() + " infos");
		main.header(sb.toString(), l);

		// for each severity
		for (String severity : issues.get(IssueSeverity.FATAL)) {
			main.error("Outcome: " + severity, true, l);
		}
		for (String severity : issues.get(IssueSeverity.ERROR)) {
			main.error("Outcome: " + severity, true, l);
		}
		for (String severity : issues.get(IssueSeverity.WARNING)) {
			main.warn("Outcome: " + severity, true, l);
		}
		for (String severity : issues.get(IssueSeverity.INFORMATION)) {
			main.info("Outcome: " + severity, true, l);
		}

		return issues.get(IssueSeverity.FATAL).size() + issues.get(IssueSeverity.ERROR).size();
	}

	/**
	 * Strings the arguments, comma separated. Nulls are ignored.
	 * 
	 * @param toPrint
	 * @return
	 */
	public static String commaSeperate(Object... toPrint) {
		StringBuilder sb = new StringBuilder("");
		Iterator<Object> iterator = Arrays.stream(toPrint).iterator();
		boolean addComma = false;
		while (iterator.hasNext()) {
			String object = iterator.next().toString();
			if (object != null && !object.toString().isEmpty()) {
				if (addComma) {
					sb.append(", ");
				}
				sb.append(object.toString());
				addComma = true;
			}
		}

		return sb.toString();
	}

	public static String logRequest(MainCommand main, Logger l) {
		String request = getRequest(main, l);
		main.debug(request, true, l);
		return request;
	}

	public static String getRequest(MainCommand main, Logger l) {
		StringBuilder sb = new StringBuilder();
		sb.append(getRequestMethod(main) + "\n");
		sb.append(getRequestHeaders(main) + "\n");
		sb.append(getRequestBody(main) + "\n");
		return sb.toString();
	}

	public static String getRequestMethod(MainCommand main) {
		ApacheHttpRequest request = (ApacheHttpRequest) main.getCapturing().getLastRequest();
		StringBuilder sb = new StringBuilder();
		sb.append(request.getHttpVerbName() + " ");
		try {
			sb.append(URLDecoder.decode(request.getUri(), StandardCharsets.UTF_8.toString()));
		} catch (UnsupportedEncodingException e) {
			main.rethrow(e);
		}
		sb.append(" " + request.getApacheRequest().getProtocolVersion());
		return sb.toString();
	}

	public static String getRequestHeaders(MainCommand main) {
		ApacheHttpRequest request = (ApacheHttpRequest) main.getCapturing().getLastRequest();
		StringBuilder sb = new StringBuilder();
		for (String header : request.getAllHeaders().keySet()) {
			sb.append(header + ": " + request.getAllHeaders().get(header) + "\n");
		}
		return sb.toString();
	}

	public static String getRequestBody(MainCommand main) {
		ApacheHttpRequest request = (ApacheHttpRequest) main.getCapturing().getLastRequest();
		StringBuilder sb = new StringBuilder();
		String bodyFromStream = null;
		try {
			bodyFromStream = request.getRequestBodyFromStream();
			if (bodyFromStream == null) {
				sb.append("NO BODY AVAILABLE");
			} else {
				Object json = objectMapper.readValue(bodyFromStream, Object.class);
				bodyFromStream = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(json);
				sb.append(bodyFromStream);
			}
		} catch (IOException e) {
			main.rethrow(e);
			;
		}
		sb.append("\n");
		return sb.toString();
	}

	public static String logResponse(MainCommand main, Logger l) {
		String request = getResponse(main, l);
		main.debug(request, true, l);
		return request;
	}

	public static String getResponse(MainCommand main, Logger l) {
		StringBuilder sb = new StringBuilder();
		sb.append(getResponseStatus(main) + "\n");
		sb.append(getResponseHeaders(main) + "\n");
		sb.append(getResponseBody(main) + "\n");
		return sb.toString();
	}

	public static String getResponseStatus(MainCommand main) {
		ApacheHttpResponse response = (ApacheHttpResponse) main.getCapturing().getLastResponse();
		return response.getResponse().getStatusLine().toString();
	}

	public static String getResponseHeaders(MainCommand main) {
		ApacheHttpResponse response = (ApacheHttpResponse) main.getCapturing().getLastResponse();
		StringBuilder sb = new StringBuilder();
		for (String header : response.getAllHeaders().keySet()) {
			sb.append(header + ": " + response.getAllHeaders().get(header) + "\n");
		}
		return sb.toString();
	}

	public static String getResponseBody(MainCommand main) {
		ApacheHttpResponse response = (ApacheHttpResponse) main.getCapturing().getLastResponse();
		StringBuilder sb = new StringBuilder();
		try {
			sb.append(readReader(main, response.createReader()));
		} catch (IOException e) {
			main.rethrow(e);
		}

		return sb.toString();
	}

//	public static File saveToStepFile(MainCommand main, Logger l, String content, String fileName) {
//		File file = new File(main.getStepOutput(), (dateFormat.format(new Date()) + "_" + fileName));
//		try {
//			try (FileWriter writer = new FileWriter(file)) {
//				writer.write(content);
//			}
//		} catch (IOException e) {
//			main.rethrow(e);
//		}
//		return file;
//	}

	public static String saveToStepFile(MainCommand main, Logger l, String stepName) {

		String requestString = Utils.logRequest(main, l);

		String responseString = Utils.logResponse(main, l);

		String content = requestString + responseString;

		String fileName = dateFormat.format(new Date()) + "_" + stepName+".txt";
		File file = new File(main.getStepOutput(), fileName);
		try {
			try (FileWriter writer = new FileWriter(file)) {
				writer.write(content);
				main.info("Step file: " + fileName, true, l);
			}
		} catch (IOException e) {
			main.rethrow(e);
		}

		return content;
	}

	private static String readReader(MainCommand main, Reader reader) {

		char[] buffer = new char[4096];
		StringBuilder builder = new StringBuilder();
		int numChars;
		try {
			while ((numChars = reader.read(buffer)) >= 0) {
				builder.append(buffer, 0, numChars);
			}
		} catch (IOException e) {
			main.rethrow(e);
		}
		return builder.toString();
	}

}
