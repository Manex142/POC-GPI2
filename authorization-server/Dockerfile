FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
RUN apk add --no-cache curl
COPY --from=build /app/target/*.jar app.jar
EXPOSE 9000
HEALTHCHECK --interval=30s --timeout=10s --start-period=90s --retries=5 CMD curl -f http://localhost:9000/.well-known/openid-configuration || exit 1
ENTRYPOINT ["java", "-jar", "app.jar"]
