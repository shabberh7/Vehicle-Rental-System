FROM tomcat:10.1-jdk17-temurin

RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN mkdir -p lib \
    && cp jakarta.mail-2.0.1.jar lib/ \
    && cp jbcrypt-0.4.jar lib/ \
    && cp mysql-connector-j-9.7.0.jar lib/

RUN ant clean war

RUN rm -rf /usr/local/tomcat/webapps/ROOT \
    && cp dist/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
