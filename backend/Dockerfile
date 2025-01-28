FROM eclipse-temurin:17-jdk as build
WORKDIR /backend

COPY /backend/mvnw .
COPY /backend/.mvn .mvn
COPY /backend/pom.xml .
COPY /backend/src src

RUN sed -i 's/\r$//' mvnw
RUN ls
RUN ./mvnw install -DskipTests


FROM eclipse-temurin:17-jdk
# VOLUME /tmp
ARG JAR_FILE=/backend/target/*.jar

# Expose the port that the Spring Boot application is listening on
EXPOSE 8080

# Copy the Spring Boot application JAR file into the Docker image
COPY --from=build ${JAR_FILE} /backend/smartbeehive-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/backend/smartbeehive-0.0.1-SNAPSHOT.jar"]
