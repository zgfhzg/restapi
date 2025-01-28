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
ENV DB_URL=localhost
ENV DATABASE_PORT=5432
ENV DATABASE_NAME=postgres
ENV DATABASE_USERNAME=postgres
ENV DATABASE_PASSWORD=password
COPY --from=builder /restapi/build/libs/${ARTIFACT_ID}-${ARTIFACT_VERSION}-SNAPSHOT.jar ./app.jar

ENTRYPOINT ["java", "-DDATABASE_URL=${DB_URL}", "-jar", "/restapi/app.jar"]