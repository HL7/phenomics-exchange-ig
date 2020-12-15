package org.phenopackets.coreig.tools.command;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.hl7.fhir.r4.model.CodeSystem;
import org.hl7.fhir.r4.model.DomainResource;
import org.hl7.fhir.r4.model.ImplementationGuide;
import org.hl7.fhir.r4.model.MetadataResource;
import org.hl7.fhir.r4.model.Resource;
import org.hl7.fhir.r4.model.StructureDefinition;
import org.phenopackets.coreig.tools.command.cl.ClinicalUsecase;
import org.phenopackets.coreig.tools.command.cl.ClinicalUsecaseClear;
import org.phenopackets.coreig.tools.command.kf.KFClearData;
import org.phenopackets.coreig.tools.command.kf.KFLoadData;
import org.phenopackets.coreig.tools.util.LevelConverter;
import org.phenopackets.coreig.tools.util.RLevelConverter;
import org.phenopackets.coreig.tools.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;
import com.beust.jcommander.converters.PathConverter;

import ca.uhn.fhir.context.ConfigurationException;
import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.parser.DataFormatException;
import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.client.interceptor.CapturingInterceptor;
import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.encoder.PatternLayoutEncoder;
import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.FileAppender;

public class MainCommand {

	@Parameter(names = { "--ig-out" }, description = "The location of the IG output directory. "
			+ "If relative, it will be resolved against current directory.", converter = PathConverter.class)
	private Path igOutPath = null;

	@Parameter(names = { "--server" }, description = "The server URL.")
	private String serverUrl = null;

	public String getServerUrl() {
		return serverUrl;
	}

	@Parameter(names = {
			"--rlevel" }, description = "The reporting level. OFF, ERROR, WARN, INFO, or DEBUG. Default is INFO. "
					+ "Reporting is different than logging.", converter = RLevelConverter.class)
	private int rlevel = 3;

	@Parameter(names = {
			"--llevel" }, description = "The logging level. Default is WARN", converter = LevelConverter.class)
	private Level llevel = Level.WARN;

	@Parameter(names = "--rpath", description = "Path to the report file. Defaults to console.", converter = PathConverter.class)
	private Path rpath = null;

	@Parameter(names = "--lpath", description = "Path to logging file. Defaults to console.", converter = PathConverter.class)
	private Path lpath = null;

	@Parameter(names = "--rquiet", description = "If set, no console reporting output.")
	private boolean rquiet = false;

	@Parameter(names = "--lquiet", description = "If set, no console logging output.")
	private boolean lquiet = false;

	/////////////////////

	public static final String ROFF = "OFF";
	public static final String RERROR = "ERROR";
	public static final String RWARN = "WARN";
	public static final String RINFO = "INFO";
	public static final String RDEBUG = "DEBUG";

	private FhirContext ctx;

	private IParser xmlParser;

	private IParser jsonParser;

	private IGenericClient client = null;

	private OutputStreamWriter reporter = null;

	private int errors = 0;
	private int warnings = 0;
	private int infos = 0;
	private int debugs = 0;

	private CapturingInterceptor capturing;

	private File stepOutput;

	private Callable<Void> commandObject;

	private String parsedCommand;
	private Date runDate = new Date();

	public CapturingInterceptor getCapturing() {
		return capturing;
	}

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

	/**
	 * @param fileName is relative to the IG output directory.
	 * @return
	 */
	public Resource loadResource(String fileName) {
		try {
			return (Resource) xmlParser.parseResource(new FileInputStream(igOutPath.resolve(fileName).toFile()));
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

	public void header(String message, Logger l) {
		if (rpath != null || !rquiet) {
			// basically, if quiet and the reporter is console, don't print.
			try {
				reporter.write(message + "\n");

			} catch (IOException e) {
				rethrow(e);
			}
		}

		// log as error to make sure it shows at all levels
		l.error("RPRT HEADER: " + message);

	}

	public void error(String message, boolean newline, Logger l) {
		++errors;
		report(1, message, newline, l);

	}

	public void warn(String message, boolean newline, Logger l) {
		++warnings;
		report(2, message, newline, l);
	}

	public void info(String message, boolean newline, Logger l) {
		++infos;
		report(3, message, newline, l);
	}

	public void debug(String message, boolean newline, Logger l) {
		++debugs;
		report(4, message, newline, l);
	}

	private void report(int level, String message, boolean newLine, Logger l) {
		if (rlevel >= level && reporter != null) {
			try {
				reporter.write(message);
				if (newLine)
					reporter.append('\n');
			} catch (IOException e) {
				rethrow(e);
			}
		}
		log(level, "RPRT: " + message, l);
	}

	private void log(int level, String message, Logger l) {
		if (reporter != null) {
			// just to make sure output is flushed to show in order
			try {
				reporter.flush();
			} catch (IOException e) {
				rethrow(e);
			}
		}
		switch (level) {
		case 1:
			l.error(message);
			break;
		case 2:
			l.warn(message);
			break;
		case 3:
			l.info(message);
			break;
		case 4:
			l.debug(message);
			break;
		}

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

	private final static MainCommand main = new MainCommand();
	private final static JCommander commander = new JCommander(main);

	private final static LoadConformanceCommand load = new LoadConformanceCommand(main);
	private final static KFLoadData kfload = new KFLoadData(main);
	private final static KFClearData kfclear = new KFClearData(main);

	// clinical us
	private final static ClinicalUsecase CLINICAL_USECASE = new ClinicalUsecase(main);
	private final static ClinicalUsecaseClear CLINICAL_USECASE_CLEAR = new ClinicalUsecaseClear(main);

	private static Logger mainLogger = LoggerFactory.getLogger(MainCommand.class);

	public static void main(String[] args) throws Exception {
		addCommands();
		commander.parse(args);
		main.run();

	}

	private void run() throws Exception {

		setupParams();
		setupLogger();
		setupReporter();
		setupFhirClient();

		setupCommand();

		setupStepOutput();

		main.info("", true, mainLogger);
		main.info("Running command: " + commandObject.getClass().getName() + " on: " + new Date().toString(), true,
				mainLogger);
		main.info("===================================", true, mainLogger);

		Exception exception = null;
		try {
			commandObject.call();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			exception = e;
		}

		if (exception != null) {
			error(exception.getStackTrace().toString(), true, mainLogger);
		}

		if (exception != null) {
			Utils.saveToStepFile(main, mainLogger, "exitException");
		}
		
		if (reporter != null) {
			reporter.flush();
			reporter.close();
		}

		if (exception != null) {
			throw exception;
		}

	}

	private void setupStepOutput() {
		stepOutput = Paths.get("stepOutput/" + Utils.dateFormat.format((runDate)) + "_" + parsedCommand)
				.toAbsolutePath().normalize().toFile();
		if (!stepOutput.exists()) {
			stepOutput.mkdirs();
		} else if (!stepOutput.isDirectory()) {
			throw new IllegalStateException("Step output directory path is not a directory: " + stepOutput.toString());
		}
	}

	private void setupCommand() throws Exception {
		parsedCommand = commander.getParsedCommand();
		if (parsedCommand == null) {
			commander.usage();
		} else {

			commandObject = null;
			switch (parsedCommand) {
			case "load":
				commandObject = load;
				break;
			case "kfload":
				commandObject = kfload;
				break;
			case "kfclear":
				commandObject = kfclear;
				break;
			case "clinical-usecase":
				commandObject = CLINICAL_USECASE;
				break;
			case "clinical-usecase-clear":
				commandObject = CLINICAL_USECASE_CLEAR;
				break;
			default:
				commander.usage();
				return;
			}

		}

	}

	private void setupFhirClient() {
		ctx = FhirContext.forR4();
		xmlParser = ctx.newXmlParser();
		jsonParser = ctx.newJsonParser().setPrettyPrint(true);
		if (serverUrl != null) {
			client = ctx.newRestfulGenericClient(serverUrl);
			this.capturing = new CapturingInterceptor();
			client.registerInterceptor(capturing);
		}

	}

	private void setupParams() {
		if (igOutPath != null)
			igOutPath = igOutPath.toAbsolutePath().normalize();

	}

	public FhirContext getFhirContext() {
		return ctx;
	}

	private void setupLogger() {
		// logger
		LoggerContext context = (LoggerContext) LoggerFactory.getILoggerFactory();
		ch.qos.logback.classic.Logger rootLogger = context.getLogger(Logger.ROOT_LOGGER_NAME);
		context.getLogger(Logger.ROOT_LOGGER_NAME).setLevel(llevel);
		if (lquiet) {
			rootLogger.detachAppender("STDOUT");
		}
		if (lpath != null) {
			lpath = lpath.toAbsolutePath().normalize();
			PatternLayoutEncoder ple = new PatternLayoutEncoder();
			ple.setPattern("%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n");
			ple.setContext(context);
			ple.start();
			FileAppender<ILoggingEvent> fileAppender = new FileAppender<ILoggingEvent>();
			fileAppender.setFile(lpath.toString());
			fileAppender.setEncoder(ple);
			fileAppender.setContext(context);
			fileAppender.start();
			rootLogger.addAppender(fileAppender);
		}
	}

	private void setupReporter() throws FileNotFoundException {
		// reporter
		if (rpath != null) {
			rpath = rpath.toAbsolutePath().normalize();
			try {
				reporter = new FileWriter(rpath.toFile(), true);
			} catch (IOException e) {
				rethrow(e);
			}
		} else {
			if (!rquiet)
				reporter = new OutputStreamWriter(System.out);
		}
	}

	private static void addCommands() {
		commander.addCommand("load", load);
		commander.addCommand("kfload", kfload);
		commander.addCommand("kfclear", kfclear);
		commander.addCommand("clinical-usecase", CLINICAL_USECASE);
		commander.addCommand("clinical-usecase-clear", CLINICAL_USECASE_CLEAR);

	}

	public File getStepOutput() {
		return stepOutput;
	}
}
