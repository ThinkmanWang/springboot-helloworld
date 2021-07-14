#FROM maven:3.6.3-openjdk-8 as build-stage
FROM registry.cn-hangzhou.aliyuncs.com/acs/maven:3-jdk-8 as build-stage
WORKDIR /app
COPY . .

RUN mvn clean install
RUN ls /app

# 基础镜像
FROM openjdk:8
WORKDIR /app
COPY --from=build-stage /app/target/helloworld-0.0.1-SNAPSHOT.jar /app/target/helloworld-0.0.1-SNAPSHOT.jar
EXPOSE 8080
CMD ["java", "-jar", "/app/target/helloworld-0.0.1-SNAPSHOT.jar"]


#FROM openjdk:8
#
#ENV MAVEN_VERSION 3.2.5
#
#RUN curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
#  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
#  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
#
#ENV MAVEN_HOME /usr/share/maven
#
#COPY . /data/springboot-helloworld
#WORKDIR /data/springboot-helloworld
#
#RUN ["mvn", "clean", "install"]
#
#EXPOSE 8080
#
#CMD ["java", "-jar", "target/helloworld-0.0.1-SNAPSHOT.jar"]
