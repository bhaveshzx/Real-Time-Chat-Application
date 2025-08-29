# Use a Maven image to build the project
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn -DskipTests package

# Use a lightweight JDK to run the jar
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Render sets PORT automatically, so expose it
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
