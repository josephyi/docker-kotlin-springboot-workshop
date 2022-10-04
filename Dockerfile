# This is an intentionally naive Dockerfile.
# Use it as practice for improvements!

FROM eclipse-temurin:17.0.4.1_1-jdk

WORKDIR /app
COPY . .
RUN ./gradlew --no-daemon bootJar

CMD ["java", "-jar", "/app/build/libs/app.jar"]
ENTRYPOINT ["./docker_entrypoint.sh"]
