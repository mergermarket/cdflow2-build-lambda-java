# cdflow2-build-lambda-java

cdflow2 build plugin for building lambda functions written in Java with Gradle.

## Requirements/Assumptions

* `build.gradle` file in the project root
* Gradle configuration with a `buildZip` task which builds a zip file containing the lambda code called `executable.zip`
    * Example: 
        ```groovy
        task buildZip(type: Zip) {
            from compileJava
            from processResources
            into('lib') {
                from configurations.runtimeClasspath
            }
            archiveFileName.set('executable.zip')
        }
        ```
## Usage

Include the following section in cdflow.yaml:
```
builds:
  lambda:
    image: mergermarket/cdflow2-build-lambda-java:0.0.15
```

When `cdflow2 release` runs it will run this build container which will build the lambda zip file with Gradle and upload it to S3 to `$LAMBDA_BUCKET/$LAMBDA_PATH` (as supplied by the release container) ready for deployment with `cdflow2 deploy`.
