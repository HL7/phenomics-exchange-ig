package org.phenopackets.coreig.tools.command;

import java.util.concurrent.Callable;

import com.beust.jcommander.Parameter;

public class HelloCommand  implements Callable<Void>{
	
	@Parameter(names = {"-m", "--message"}, description = "Test hello message." )
	private String hello = "Hello world";
	
	private final MainCommand main;

	public HelloCommand(MainCommand main) {
		this.main = main;
	}

	@Override
	public Void call() throws Exception {
		System.out.println(hello);
		return null;
	}


}
