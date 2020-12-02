package org.phenopackets.coreig.tools.util;

import org.phenopackets.coreig.tools.command.MainCommand;

import com.beust.jcommander.IStringConverter;

public class RLevelConverter implements IStringConverter<Integer> {

	@Override
	public Integer convert(String value) {
		int level = 3;
		switch(value.toUpperCase()) {
		case MainCommand.ROFF:
			level = 0;
			break;
		case MainCommand.RERROR:
			level =1;
			break;
		case MainCommand.RWARN:
			level = 2;
			break;
		case MainCommand.RINFO:
			level = 3;
			break;
		case MainCommand.RDEBUG:
			level = 4;
			break;
		}
		return level;
	}

}
