# Use the latest Ubuntu image as the base
FROM ubuntu:latest

# Set environment variables
ENV JAVA_VERSION=21
ENV MAVEN_VERSION=3.9.4
ENV MAVEN_HOME=/usr/local/maven
ENV PATH=$MAVEN_HOME/bin:$PATH

# Install necessary packages and dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    git \
    openjdk-21-jdk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Install git and other necessary build tools
RUN apt-get update && apt-get install -y git build-essential

# Install Maven
RUN curl -o /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    -L https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && tar -xzvf /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /usr/local \
    && mv /usr/local/apache-maven-${MAVEN_VERSION} $MAVEN_HOME \
    && rm /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz

# Set the working directory
WORKDIR /app

# Clone the Git repository
RUN git clone https://github.com/ragjyo/Shellscript-canada.git .

# Change to the cloned directory
WORKDIR /app/java-sample

# Build the Maven project
RUN mvn clean install

# Set up Artifactory deployment credentials
#ENV ARTIFACTORY_URL=https://your-artifactory-url/artifactory
#ENV ARTIFACTORY_REPO=your-repo
#ENV ARTIFACTORY_USER=your-username
#ENV ARTIFACTORY_PASSWORD=your-password

# Deploy to Artifactory
#RUN mvn deploy -DaltDeploymentRepository=artifactory::default::${ARTIFACTORY_URL}/${ARTIFACTORY_REPO} \
#    -Dusername=${ARTIFACTORY_USER} -Dpassword=${ARTIFACTORY_PASSWORD}

# Expose any necessary ports (e.g., for debugging or application)
EXPOSE 8080

# Default command to run (optional)
CMD ["bash"]
