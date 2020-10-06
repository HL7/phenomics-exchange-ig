This is a copy of https://github.com/hapifhir/hapi-fhir-jpaserver-starter

At revision:5c4a51601f1d113247cb39b918bead878603fd0f

Used to run a local JPA FHIR server for demo purposes.

See the README.md for instructions.

How to run the FHIR server in this project

- Clone the repo
- cd to the directory this file is located in
- run: mvn jetty:run  to start the server. It binds to port 8080.  The web interface is at / and the FHIR endpoint is at /fhir
- CTRL-C ,or something like that on Mac, to kill the server
- To start the server with a clean empty database, or if the database gets corrupted or locked due to a crash, run mvn clean jetty:run
- If you would like the server to apply validation, you need to run  mvn -Dspring.config.location=classpath:/application-validate.yaml jetty:run

Without validation the server will accept any instance even if it's not valid according to the spec.
