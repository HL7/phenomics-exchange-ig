package org.phenopackets.coreig;

import java.util.List;

import org.hl7.fhir.common.hapi.validation.support.CachingValidationSupport;
import org.hl7.fhir.common.hapi.validation.support.InMemoryTerminologyServerValidationSupport;
import org.hl7.fhir.common.hapi.validation.support.PrePopulatedValidationSupport;
import org.hl7.fhir.common.hapi.validation.support.RemoteTerminologyServiceValidationSupport;
import org.hl7.fhir.common.hapi.validation.support.SnapshotGeneratingValidationSupport;
import org.hl7.fhir.common.hapi.validation.support.ValidationSupportChain;
import org.hl7.fhir.common.hapi.validation.validator.FhirInstanceValidator;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.StructureDefinition;
import org.hl7.fhir.r4.model.ValueSet;
import org.phenopackets.coreig.examples.PPDefs;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.context.support.ConceptValidationOptions;
import ca.uhn.fhir.context.support.DefaultProfileValidationSupport;
import ca.uhn.fhir.context.support.IValidationSupport;
import ca.uhn.fhir.context.support.ValidationSupportContext;
import ca.uhn.fhir.context.support.ValueSetExpansionOptions;
import ca.uhn.fhir.validation.FhirValidator;

public class PPValidator implements IValidationSupport {

	public List<IBaseResource> fetchAllConformanceResources() {
		return cacheSupport.fetchAllConformanceResources();
	}

	public <T extends IBaseResource> List<T> fetchAllStructureDefinitions() {
		return cacheSupport.fetchAllStructureDefinitions();
	}

	public <T extends IBaseResource> T fetchResource(Class<T> theClass, String theUri) {
		return cacheSupport.fetchResource(theClass, theUri);
	}

	public boolean isValueSetSupported(ValidationSupportContext theValidationSupportContext, String theValueSetUrl) {
		return cacheSupport.isValueSetSupported(theValidationSupportContext, theValueSetUrl);
	}

	public boolean isCodeSystemSupported(ValidationSupportContext theValidationSupportContext, String theSystem) {
		return cacheSupport.isCodeSystemSupported(theValidationSupportContext, theSystem);
	}

	public ValueSetExpansionOutcome expandValueSet(ValidationSupportContext theValidationSupportContext,
			ValueSetExpansionOptions theExpansionOptions, IBaseResource theValueSetToExpand) {
		return cacheSupport.expandValueSet(theValidationSupportContext, theExpansionOptions, theValueSetToExpand);
	}

	public CodeValidationResult validateCode(ValidationSupportContext theValidationSupportContext,
			ConceptValidationOptions theOptions, String theCodeSystem, String theCode, String theDisplay,
			String theValueSetUrl) {
		return cacheSupport.validateCode(theValidationSupportContext, theOptions, theCodeSystem, theCode, theDisplay,
				theValueSetUrl);
	}

	public IBaseResource fetchCodeSystem(String theSystem) {
		return cacheSupport.fetchCodeSystem(theSystem);
	}

	public IBaseResource fetchValueSet(String theUri) {
		return cacheSupport.fetchValueSet(theUri);
	}

	public IBaseResource fetchStructureDefinition(String theUrl) {
		return cacheSupport.fetchStructureDefinition(theUrl);
	}

	public LookupCodeResult lookupCode(ValidationSupportContext theValidationSupportContext, String theSystem,
			String theCode) {
		return cacheSupport.lookupCode(theValidationSupportContext, theSystem, theCode);
	}

	public CodeValidationResult validateCodeInValueSet(ValidationSupportContext theValidationSupportContext,
			ConceptValidationOptions theValidationOptions, String theCodeSystem, String theCode, String theDisplay,
			IBaseResource theValueSet) {
		return cacheSupport.validateCodeInValueSet(theValidationSupportContext, theValidationOptions, theCodeSystem,
				theCode, theDisplay, theValueSet);
	}

	public void addCodeSystem(IBaseResource theCodeSystem) {
		populatedSupport.addCodeSystem(theCodeSystem);
	}

	public void addStructureDefinition(IBaseResource theStructureDefinition) {
		populatedSupport.addStructureDefinition(theStructureDefinition);
	}

	public void addValueSet(ValueSet theValueSet) {
		populatedSupport.addValueSet(theValueSet);
	}

	public IBaseResource generateSnapshot(ValidationSupportContext theValidationSupportContext, IBaseResource theInput,
			String theUrl, String theWebUrl, String theProfileName) {
		return cacheSupport.generateSnapshot(theValidationSupportContext, theInput, theUrl, theWebUrl, theProfileName);
	}

	private CachingValidationSupport cacheSupport;

	private ValidationSupportChain chainSupport;

	private FhirContext context;

	private DefaultProfileValidationSupport defaultSupport;

	private PrePopulatedValidationSupport populatedSupport;

	private RemoteTerminologyServiceValidationSupport terminologySupport;

	private FhirInstanceValidator validatorModule;

	private SnapshotGeneratingValidationSupport snapshotSupport;

	private FhirValidator validator;

	public SnapshotGeneratingValidationSupport getSnapshotSupport() {
		return snapshotSupport;
	}

	public FhirValidator getValidator() {
		return validator;
	}

	public FhirInstanceValidator getValidatorModule() {
		return validatorModule;
	}

	public PPValidator(FhirContext context) {
		this.context = context;
		this.chainSupport = new ValidationSupportChain();

		this.defaultSupport = new DefaultProfileValidationSupport(context);
		this.populatedSupport = new PrePopulatedValidationSupport(context);
		this.terminologySupport = new RemoteTerminologyServiceValidationSupport(context);
		terminologySupport.setBaseUrl("http://tx.fhir.org/r4");
		this.snapshotSupport = new SnapshotGeneratingValidationSupport(context);
		
		chainSupport.addValidationSupport(defaultSupport);
		chainSupport.addValidationSupport(populatedSupport);
		chainSupport.addValidationSupport(terminologySupport);
		chainSupport.addValidationSupport(snapshotSupport);

		
		this.cacheSupport = new CachingValidationSupport(chainSupport);
		validatorModule = new FhirInstanceValidator(this);
		validator = new FhirValidator(context);
		validator.registerValidatorModule(validatorModule);
	}

	public CachingValidationSupport getCacheSupport() {
		return cacheSupport;
	}
	public ValidationSupportChain getChainSupport() {
		return chainSupport;
	}
	public FhirContext getContext() {
		return context;
	}
	public DefaultProfileValidationSupport getDefaultSupport() {
		return defaultSupport;
	}
	@Override
	public FhirContext getFhirContext() {

		return context;
	}

	public PrePopulatedValidationSupport getPopulatedSupport() {
		return populatedSupport;
	}

	public RemoteTerminologyServiceValidationSupport getTerminologySupport() {
		return terminologySupport;
	}
	
	public StructureDefinition loadStructureDefinition(String classpathPath) {
		StructureDefinition sd = PPDefs.getStructureDefinition(classpathPath);
		populatedSupport.addStructureDefinition(sd);
	
		return sd;
	}

}
