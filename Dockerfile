# Use a base image with Java and Maven installed
FROM maven:3.8.1-openjdk-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .

# Download the project dependencies
RUN mvn dependency:go-offline -B

# Copy the source code
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Create a new image with only the JAR file
FROM openjdk:17.0.1-jdk-slim
#
## Set the working directory inside the container
WORKDIR /app
#
## Copy the built JAR file from the previous stage
COPY --from=build /app/target/*.jar app.jar
#
## Expose the application port (change it if needed)
EXPOSE 8080
#
## Set the entry point command to run the application
CMD ["java", "-jar", "app.jar"]
