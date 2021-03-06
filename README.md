# Scan your code with SonarQube

Using this GitHub Action, scan your code with [SonarQube](https://www.sonarqube.org/) to detects bugs, vulnerabilities and code smells in more than 20 programming languages!

<img src="./images/SonarQube-72px.png">

SonarQube is the leading product for Continuous Code Quality & Code Security. It supports all major programming languages, including Java, JavaScript, TypeScript, C#, C/C++ and many more.

## Requirements

The repository to analyze is set up on SonarQube.

## Usage

Project metadata, including the location to the sources to be analyzed, must be declared in the file `sonar-project.properties` in the base directory:

```properties
sonar.projectKey=<replace with the key generated when setting up the project on SonarQube>

# relative paths to source directories. More details and properties are described
# in https://docs.sonarqube.org/latest/project-administration/narrowing-the-focus/ 
sonar.sources=.
```

The workflow, usually declared in `.github/workflows/build.yml`, looks like:

```yaml
on:
  # Trigger analysis when pushing in master or pull requests, and when creating
  # a pull request. 
  push:
    branches:
      - master
  pull_request:
      types: [opened, synchronize, reopened]
name: Main Workflow
jobs:
  sonarcloud:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
      with:
        # Disabling shallow clone is recommended for improving relevancy of reporting
        fetch-depth: 0
    - name: SonarQube Scan
      uses: sonarsource/sonarqube-scan-action@master
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
```

You can change the analysis base directory by using the optional input `projectBaseDir` like this:

```yaml
uses: sonarsource/sonarqube-scan-action@master
with:
  projectBaseDir: my-custom-directory
```

In case you need to add additional analysis parameters, you can use the `args` option:

```yaml
- name: Analyze with SonarQube
  uses: sonarsource/sonarqube-scan-action@master
  with:
    projectBaseDir: my-custom-directory
    args: >
      -Dsonar.projectKey=my-projectkey
      -Dsonar.python.coverage.reportPaths=coverage.xml
      -Dsonar.sources=lib/
      -Dsonar.test.exclusions=tests/**
      -Dsonar.tests=tests/
      -Dsonar.verbose=true
```

More information about possible analysis parameters can be found in [the documentation](https://docs.sonarqube.org/latest/analysis/analysis-parameters/).

### Secrets

- `SONAR_TOKEN` ??? **Required** this is the token used to authenticate access to SonarQube. You can read more about security tokens [here](https://docs.sonarqube.org/latest/user-guide/user-token/). You should set the `SONAR_TOKEN` environment variable in the "Secrets" settings page of your repository.
- `SONAR_HOST_URL` ??? **Required** this tells the scanner where SonarQube is hosted. You can set the `SONAR_HOST_URL` environment variable in the "Secrets" settings page of your repository.
- *`GITHUB_TOKEN` ??? Provided by Github (see [Authenticating with the GITHUB_TOKEN](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/authenticating-with-the-github_token)).*

## Example of pull request analysis

<img src="./images/SonarQube-analysis-in-Checks.png">

## Do not use this GitHub action if you are in the following situations

* Your code is built with Maven. Read the documentation about our [Scanner for Maven](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-maven/).
* Your code is built with Gradle. Read the documentation about our [Scanner for Gradle](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-gradle/).
* You want to analyze a .NET solution. Read the documentation about our [Scanner for .NET](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-msbuild/).
* You want to analyze C/C++ code. Read the documentation on [analyzing C/C++ code](https://docs.sonarqube.org/latest/analysis/languages/cfamily/).

## Have question or feedback?

To provide feedback (requesting a feature or reporting a bug) please post on the [SonarSource Community Forum](https://community.sonarsource.com/) with the tag `sonarqube-team`.

## License

The Dockerfile and associated scripts and documentation in this project are released under the LGPLv3 License.

Container images built with this project include third party materials.
