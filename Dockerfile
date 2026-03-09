FROM maven:3.9.9-eclipse-temurin-8 AS deps

WORKDIR /app
COPY pom.xml /app/pom.xml
COPY src/main/java /app/src/main/java
RUN mvn -q -DskipTests compile dependency:copy-dependencies -DoutputDirectory=/deps

FROM tomcat:9.0-jdk8-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY src/main/webapp /usr/local/tomcat/webapps/ROOT
COPY --from=deps /app/target/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes
COPY src/main/java/META-INF/persistence.xml /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/META-INF/persistence.xml
COPY --from=deps /deps/*.jar /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

EXPOSE 8080

CMD ["sh", "-c", "if [ -n \"$PORT\" ]; then sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT}\\\"/\" /usr/local/tomcat/conf/server.xml; fi; catalina.sh run"]