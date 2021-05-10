FROM sonarsource/sonar-scanner-cli:4.6

LABEL version="1.0.0" \
      repository="https://github.com/sonarsource/sonarqube-scan-action" \
      homepage="https://github.com/sonarsource/sonarqube-scan-action" \
      maintainer="SonarSource" \
      com.github.actions.name="SonarQube Scan" \
      com.github.actions.description="Scan your code with SonarQube to detect bugs, vulnerabilities and code smells in more than 25 programming languages." \
      com.github.actions.icon="check" \
      com.github.actions.color="green"

# set up local envs in order to allow for special chars (non-asci) in filenames
ENV LC_ALL="C.UTF-8"

# https://help.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#user
USER root

# Prepare entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
