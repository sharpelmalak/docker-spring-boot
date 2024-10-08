# Stage 1: Build the Spring Boot application
FROM maven:3.9.4-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

## Stage 2: Run the Spring Boot application
FROM eclipse-temurin:21-jdk-alpine
VOLUME /tmp
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]


#FROM openjdk:17-jdk-alpine
#VOLUME /tmp
#COPY target/backend-app.jar app.jar
#ENTRYPOINT ["java", "-jar", "/app.jar"]

