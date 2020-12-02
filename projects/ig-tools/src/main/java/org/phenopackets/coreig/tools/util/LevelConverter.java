package org.phenopackets.coreig.tools.util;

import com.beust.jcommander.IStringConverter;

import ch.qos.logback.classic.Level;

public class LevelConverter implements IStringConverter<Level> {

	@Override
	public Level convert(String value) {
		return Level.toLevel(value);
	}

}
