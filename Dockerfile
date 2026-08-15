FROM tomcat:10.1-jdk17-temurin

RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN mkdir -p web/WEB-INF/lib \
    && cp jakarta.mail-2.0.1.jar web/WEB-INF/lib/ \
    && cp jbcrypt-0.4.jar web/WEB-INF/lib/ \
    && cp mysql-connector-j-9.7.0.jar web/WEB-INF/lib/

RUN ant \
    -Dj2ee.server.home=/usr/local/tomcat \
    -Dfile.reference.jakarta.mail-2.0.1.jar=/app/jakarta.mail-2.0.1.jar \
    -Dfile.reference.jbcrypt-0.4.jar=/app/jbcrypt-0.4.jar \
    -Dfile.reference.mysql-connector-j-9.7.0.jar=/app/mysql-connector-j-9.7.0.jar \
    -Djavac.source=17 \
    -Djavac.target=17 \
    clean war

RUN rm -rf /usr/local/tomcat/webapps/ROOT \
    && cp dist/VehicleRentalSystem.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
