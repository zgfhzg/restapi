## gradle builder
FROM gradle:8.9.0-jdk21-alpine as builder
WORKDIR /restapi
COPY . .
RUN gradle build -x test

## java runtime
FROM ghcr.io/graalvm/jdk-community:21

LABEL application="restapi"
LABEL version="1.0"
LABEL authors="HS"

ARG ARTIFACT_ID=restapi
ARG ARTIFACT_VERSION=0.0.1

EXPOSE 8083

WORKDIR /restapi
COPY --from=builder /restapi/build/libs/${ARTIFACT_ID}-${ARTIFACT_VERSION}-SNAPSHOT.jar ./app.jar

ENTRYPOINT ["java", "-DDATABASE_URL=${DB_URL}", "-DDATABASE_PORT=${DB_PORT}", "-DDATABASE_NAME=${DB_NAME}", "-DDATABASE_USERNAME=${DB_USERNAME}", "-DDATABASE_PASSWORD=${DB_PASSWORD}", "-DEUREKA_URI=${EUREKA_URI}", "-jar", "/restapi/app.jar"]