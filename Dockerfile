# ---------- build stage ----------
FROM maven:3.6.3-jdk-8 AS build
WORKDIR /app
COPY . .
ARG APP_MODULE=web
RUN mvn -q -DskipTests -pl ${APP_MODULE} -am clean package

# ---------- run stage ----------
FROM eclipse-temurin:8-jre
WORKDIR /app
ARG APP_MODULE=web
COPY --from=build /app/${APP_MODULE}/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
