FROM tomcat:9.0-jdk8-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY src/main/webapp /usr/local/tomcat/webapps/ROOT
COPY build/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes
COPY src/main/java/META-INF/persistence.xml /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/META-INF/persistence.xml

EXPOSE 8080

CMD ["sh", "-c", "if [ -n \"$PORT\" ]; then sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT}\\\"/\" /usr/local/tomcat/conf/server.xml; fi; catalina.sh run"]