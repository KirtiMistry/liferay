FROM tomcat:7.0.70

MAINTAINER Oscar Zapater <oscar.zapater@gmail.com>

ENV LIFERAY_WAR=liferay-portal-6.2-ce-ga6-20160112152609836
ENV LIFERAY_LIB=liferay-portal-src-6.2-ce-ga6/lib
ENV LIFERAY_LIB_DEP=liferay-portal-dependencies-6.2-ce-ga6
ENV TOMCAT_HOME=/usr/local/tomcat

WORKDIR ${TOMCAT_HOME}/

# Dependencies
ADD ${LIFERAY_LIB_DEP}/* ${TOMCAT_HOME}/lib/ext/

# Libs
ADD ${LIFERAY_LIB}/development/activation.jar lib/ext/
ADD ${LIFERAY_LIB}/development/jms.jar lib/ext/
ADD ${LIFERAY_LIB}/development/jta.jar lib/ext/
ADD ${LIFERAY_LIB}/development/jutf7.jar lib/ext/
ADD ${LIFERAY_LIB}/development/mail.jar lib/ext/
ADD ${LIFERAY_LIB}/development/persistence.jar lib/ext/
ADD ${LIFERAY_LIB}/portal/ccpp.jar lib/ext/

# add ROOT.xml
RUN mkdir -p conf/Catalina/localhost
ADD ROOT.xml conf/Catalina/localhost/ROOT.xml

#Add server.xml and catalina.properties
ADD conf/server.xml conf/server.xml
ADD conf/catalina.properties conf/catalina.properties
ADD conf/context.xml conf/context.xml

# cleanup default tomcat
RUN (rm -r ${TOMCAT_HOME}/webapps/* && \
	mkdir -p ${TOMCAT_HOME}/webapps/ROOT)


ADD ${LIFERAY_WAR}.war ${TOMCAT_HOME}/webapps/ROOT/
RUN unzip ${TOMCAT_HOME}/webapps/ROOT/${LIFERAY_WAR}.war -d ${TOMCAT_HOME}/webapps/ROOT
RUN rm ${TOMCAT_HOME}/webapps/ROOT/${LIFERAY_WAR}.war

# Add properties of configuration	
ADD properties/portal-ext.properties ${TOMCAT_HOME}/portal-ext.properties

# Add configuration cache custom
ADD custom_cache/* ${TOMCAT_HOME}/webapps/ROOT/WEB-INF/classes/

EXPOSE 8080