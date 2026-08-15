FROM tomcat:10.1-jdk25-temurin-noble

WORKDIR /app
COPY . .

RUN mkdir -p web/WEB-INF/classes web/WEB-INF/lib

RUN cp jakarta.mail-2.0.1.jar web/WEB-INF/lib/ \
    && cp jbcrypt-0.4.jar web/WEB-INF/lib/ \
    && cp mysql-connector-j-9.7.0.jar web/WEB-INF/lib/

RUN find src/java -name "*.java" > sources.txt \
    && javac \
       -encoding UTF-8 \
       -cp "/usr/local/tomcat/lib/*:/app/jakarta.mail-2.0.1.jar:/app/jbcrypt-0.4.jar:/app/mysql-connector-j-9.7.0.jar" \
       -d web/WEB-INF/classes \
       @sources.txt

RUN rm -rf /usr/local/tomcat/webapps/ROOT \
    && mkdir -p /usr/local/tomcat/webapps/ROOT \
    && cp -r web/* /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080

CMD ["catalina.sh", "run"]
