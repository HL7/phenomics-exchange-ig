# An invalid Observation instance example

This is an example of an invalid Observation instance based on the "StructureDefinition-observation-phenotypic-abnormality.xml" profile in this IG. The instance is a valid Observation instance but it does not conform to the profile by:

* Adding a second severity component when the profile says the max cardinality is 1.
* Adds a clinical modifier that has a value (the "Refractory" term/code) that is not in the ValueSet binding for this component.
  * You'll notice the code is in the HPO CodeSystem but the ValueSet-phenotypic-modifier.xml ValueSet explicitly excludes this code specifically for this example to be considered invalid. This is just for demo purposes. Once this exclusion from the ValueSet is removed, this second clinical modifier entry will no longer be invalid.
* Adds a clinical modifier that has a value that is not in the HPO CodeSystem.
  * This causes two validation errors. First, is that the value is not in the ValueSet. Second, the code is also not in the CodeSystem.
* There is a component that doesn't match any of the "slices" in the profile and the validator makes note of that but it is not an error. It's just some additional component that is not related to what the profile models with its "slicing".


The table below this paragraph is the validation information that is used in the QA report page but can also be included on this example's page by adding the following to this file:

{%raw%}{% include /Observation-phenotypic-abnormality-invalid-1-validation.xhtml %}
{%endraw%}

{% include /Observation-phenotypic-abnormality-invalid-1-validation.xhtml %}

The rest of the content on this page is auto generated.