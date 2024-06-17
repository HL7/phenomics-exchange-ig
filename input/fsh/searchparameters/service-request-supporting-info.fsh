Instance: service-request-supporting-info
InstanceOf: SearchParameter
Usage: #definition
* insert SP_Publisher
* insert Version
* url = "http://github.com/phenopackets/core-ig/SearchParameter/service-request-supporting-info"
* name = "ServiceRequestSupportingInfo"
* status = #active
* description = "Search ServiceRequest by supporting resource parameters"
* code = #supporting-info
* base = #ServiceRequest
* type = #reference
* expression = "ServiceRequest.supportingInfo"
* target = #Bundle
* comparator = #eq
