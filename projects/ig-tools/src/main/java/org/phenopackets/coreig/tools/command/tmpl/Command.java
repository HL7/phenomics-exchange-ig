package org.phenopackets.coreig.tools.command.tmpl;

import java.util.concurrent.Callable;

import org.phenopackets.coreig.tools.command.MainCommand;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Command implements Callable<Void> {

	private static Logger logger = LoggerFactory.getLogger(Command.class);

	private MainCommand main;

	public Command(MainCommand main) {
		this.main = main;
	}

	@Override
	public Void call() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
