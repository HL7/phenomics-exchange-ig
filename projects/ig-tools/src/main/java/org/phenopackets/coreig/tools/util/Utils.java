package org.phenopackets.coreig.tools.util;

import org.hl7.fhir.instance.model.api.IBaseCoding;
import org.hl7.fhir.instance.model.api.IBaseResource;

public class Utils {
	
	public static String getIgPrefix(String igUrl) {
		igUrl = igUrl.substring(0, igUrl.lastIndexOf('/'));
		return igUrl.substring(0, igUrl.lastIndexOf('/'));
	}
	
	public static void tagResourceId(IBaseResource target, IBaseResource source , String system) {
		String id = source.getIdElement().getValue();
		
		for (IBaseCoding coding : target.getMeta().getTag()) {
			if (coding.getSystem().equals(system)) {
				coding.setCode(id);
				return;
			}
		}
		
		IBaseCoding tag = target.getMeta().addTag();
		tag.setSystem(system);
		tag.setCode(id);
	}

}
