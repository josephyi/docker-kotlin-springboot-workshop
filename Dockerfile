# This is an intentionally naive Dockerfile.
# Use it as practice for improvements!

FROM eclipse-temurin

ARG SOME_BUILD_SECRET="password_token_api_key"

WORKDIR /app
COPY . .
RUN ./gradlew --no-daemon bootJar \
    -PSOME_BUILD_SECRET=${SOME_BUILD_SECRET}

CMD ["java", "-jar", "/app/build/libs/app.jar"]
ENTRYPOINT ["./docker_entrypoint.sh"]
