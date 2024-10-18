#
# Build stage
#
FROM maven:3.8.8-jdk-17 AS build
COPY . .
RUN mvn clean package -Pprod -DskipTests

#
# Package stage
#
FROM openjdk:17-jdk-slim
COPY --from=build /web/target/web-0.0.1-SNAPSHOT.jar web.jar
# ENV PORT=8080
EXPOSE 8080
CMD ["java", "-jar", "web.jar"]
