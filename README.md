# docker-kotlin-springboot-workshop

Explore and experiment with Docker and Github Actions for
a Kotlin based Spring Boot app.

## Tools

* Install [Dive](https://github.com/wagoodman/dive) to inspect Docker image layers.
* Install [Trivy](https://github.com/aquasecurity/trivy) to scan image for vulnerabilities.

## Examples

### Dockerfile
The default [Dockerfile](Dockerfile) is simple, and does not make use of many
accepted practices. Run the commands and think of ways it can be improved.

```sh
# Build Image
docker build -t workshop .

# View Build History
docker history workshop:latest

# Run Image
docker run -it --rm workshop

# Build Image With A Fake Secret
docker build \
--build-arg SOME_BUILD_SECRET="apikeypasswordtoken" \
-t workshop \
.

# View Build History With The "Secret"
docker history workshop:latest

# Inspect Image Layers
dive workshop

# Scan Image
trivy image workshop
```

### Dockerfile.optimized
[Dockerfile.optimized](Dockerfile.optimized) demonstrates accepted practices to improving the cacheability, size, and security of the Docker image.
```
# Build Image (default is `production` stage)
docker build \
-t workshop-optimized \
-f Dockerfile.optimized \
.

# Inspect Image Layers
dive workshop

# Scan Image
trive image workshop

# Build Specific Stage
export SOME_BUILD_SECRET="notinhistorybecausesecret"
docker build \
--target builder \
--secret id=SOME_BUILD_SECRET \
-t workshop-optimized \
-f Dockerfile.optimized \
.

# Observe Build Commands
docker history \
--format "{{.CreatedBy}}" \
--no-trunc workshop-optimized

# Build Production Image
export SOME_BUILD_SECRET="notinhistorybecausemultistage"
docker build \
--secret id=SOME_BUILD_SECRET \
-t workshop-optimized \
-f Dockerfile.optimized \
.

# Observe Build Commands
docker history \
--format "{{.CreatedBy}}" \
--no-trunc workshop-optimized
```
