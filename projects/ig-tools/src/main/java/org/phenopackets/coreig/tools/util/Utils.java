package org.phenopackets.coreig.tools.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.hl7.fhir.instance.model.api.IBaseCoding;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.CanonicalType;
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

import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.server.exceptions.PreconditionFailedException;

public class Utils {

	private static Logger logger = LoggerFactory.getLogger(Utils.class);

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
			main.error("Validation error count of: " + actualErrors + " exceeded max allowed validation error count of:"
					+ maxErrors, true, l);
		}
		if (actualErrors < maxErrors) {
			main.warn("Validation error count of: " + actualErrors + " less than max allowed validation error count of:"
					+ maxErrors, true, l);
		}
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

}
