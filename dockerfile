# Use a Java base image
# FROM openjdk:17-oracle
FROM maven:3-eclipse-temurin-17

# https://medium.com/@skywalkerhunter/aws-docker-deploy-spring-boot-fe05a00191d9
# added on 31st Oct
LABEL maintainer="Darryl Ng <darryl1975@hotmail.com>"
LABEL description="Dockerfile for deploying to Beanstalk needs dockerrun.aws.json"

# added on 31st Oct
#RUN rm -rf /usr/local/tomcat/webapps/*

# Set the working directory to /app
WORKDIR /app

COPY src src
COPY pom.xml .
COPY mvnw .
COPY mvnw.cmd .
COPY .mvn .mvn

# Copy the Spring Boot application JAR file into the Docker image
# COPY target/cicd-demo-0.0.1-SNAPSHOT.jar /app/cicd-demo-0.0.1-SNAPSHOT.jar

# Build the application
RUN mvn package -Dmaven.test.skip=true

# added on 31st Oct
#COPY target/cicd-demo-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/cicd-demo-0.0.1-SNAPSHOT.war

# Set environment variables
#ENV SERVER_PORT=5000
# ENV LOGGING_LEVEL=INFO

# Expose the port that the Spring Boot application is listening on
EXPOSE 8080

# Run the Spring Boot application when the container starts
# CMD ["java", "-jar", "cicd-demo-0.0.1-SNAPSHOT.jar"]
ENTRYPOINT ["java", "-jar", "target/cicd-demo-0.0.1-SNAPSHOT.jar"]

# added on 31st Oct
# ENTRYPOINT [ "sh", "-c", "java -Dspring.profiles.active=prod -jar /usr/local/tomcat/webapps/cicd-demo-0.0.1-SNAPSHOT.war" ]