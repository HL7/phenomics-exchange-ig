package org.phenopackets.coreig.tools.command;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.hl7.fhir.r4.model.CodeSystem;
import org.hl7.fhir.r4.model.ImplementationGuide;
import org.hl7.fhir.r4.model.MetadataResource;
import org.hl7.fhir.r4.model.StructureDefinition;

import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;
import com.beust.jcommander.converters.PathConverter;

import ca.uhn.fhir.context.ConfigurationException;
import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.parser.DataFormatException;
import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.client.api.IGenericClient;

public class MainCommand {

	public final static MainCommand main = new MainCommand();
	public final static JCommander commander = new JCommander(main);

	public final static HelloCommand hello = new HelloCommand(main);
	public final static LoadConformanceCommand load = new LoadConformanceCommand(main);

	public static void main(String[] args) throws Exception {
		addCommands();
		commander.parse(args);
		main.run();
	}

	private static void addCommands() {
		commander.addCommand("hello", hello);
		commander.addCommand("load", load);

	}

	@Parameter(names = {
			"--ig-out" }, description = "The location of the output directory. If relative, it will be resolved against current directory.", converter = PathConverter.class)
	private Path igOutPath = null;

	@Parameter(names = { "--server" }, description = "The server URL.")
	private String serverUrl = null;

	private FhirContext ctx = FhirContext.forR4();

	private IParser xmlParser = ctx.newXmlParser();

	private IParser jsonParser = ctx.newJsonParser().setPrettyPrint(true);

	IGenericClient client = null;

	public IGenericClient getClient() {
		return client;
	}

	public CodeSystem getCodeSystem(String id) {
		Path csPath = igOutPath.resolve("CodeSystem-" + id + ".xml");
		CodeSystem cs = null;
		try {
			cs = xmlParser.parseResource(CodeSystem.class, new FileInputStream(csPath.toFile()));
		} catch (DataFormatException | FileNotFoundException e) {
			rethrow(e);
		}

		return cs;
	}

	public Collection<CodeSystem> getCodeSystems() {
		List<Path> paths = null;
		try {
			paths = getPaths(igOutPath, "CodeSystem-*.xml");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		List<CodeSystem> systems = new ArrayList<>();
		for (Path pah : paths) {
			try {
				systems.add(xmlParser.parseResource(CodeSystem.class, new FileInputStream(pah.toFile())));
			} catch (DataFormatException | FileNotFoundException e) {
				rethrow(e);
			}
		}
		return systems;
	}

	public Collection<StructureDefinition> getDefinitions() {
		return null;
	}

	@SuppressWarnings("unchecked")
	public <T extends MetadataResource> T loadMetadata(String fileName) {
		try {
			return (T) xmlParser.parseResource(new FileInputStream(igOutPath.resolve(fileName).toFile()));
		} catch (ConfigurationException | DataFormatException | FileNotFoundException e) {
			rethrow(e);
		}
		return null;
	}

	public ImplementationGuide getIg() {
		List<Path> paths = null;
		try {
			paths = getPaths(igOutPath, "ImplementationGuide-*.xml");
		} catch (IOException e) {
			rethrow(e);
		}

		if (paths.size() != 1) {
			throw new IllegalArgumentException("Could not fine one ImplementationGuide-*.xml file at: " + igOutPath);
		}

		try {
			return xmlParser.parseResource(ImplementationGuide.class, new FileInputStream(paths.get(0).toFile()));
		} catch (DataFormatException | IOException e) {
			rethrow(e);
		}
		return null;
	}

	public IParser getJsonParser() {
		return jsonParser;
	}

	public IParser getXmlParser() {
		return xmlParser;
	}

	public void rethrow(Throwable t) throws RuntimeException {
		throw new RuntimeException(t);
	}

	public void error(String message) {

	}

	public void info(String message) {

	}

	public void debug(String meassage) {

	}

	private List<Path> getPaths(Path dir, String match) throws IOException {
		try (DirectoryStream<Path> stream = Files.newDirectoryStream(dir, match)) {
//			Iterator<Path> iterator = stream.iterator();
//			while (iterator.hasNext()) {
//				Path next = iterator.next();
//				System.out.println(next);
//			}
			return StreamSupport.stream(stream.spliterator(), false).collect(Collectors.toList());

		}
	}

	private void run() throws Exception {
		if (igOutPath != null)
			igOutPath = igOutPath.toAbsolutePath().normalize();

		if (serverUrl != null)
			client = ctx.newRestfulGenericClient(serverUrl);

		String command = commander.getParsedCommand();
		if (command == null) {
			commander.usage();
		} else {
			switch (command) {
			case "hello":
				hello.call();
				break;
			case "load":
				load.call();
				break;
			default:
				commander.usage();
			}
		}

	}

}
