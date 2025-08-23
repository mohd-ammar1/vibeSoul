# Apache Tomcat 11 Setup Guide for vibeSoul

## 1. Extract and Setup Tomcat 11

1. Extract the Tomcat 11 ZIP file to a location of your choice (e.g., `C:\tomcat11`)
2. Set environment variables:
   - `CATALINA_HOME`: Path to your Tomcat directory (e.g., `C:\tomcat11`)
   - Add `%CATALINA_HOME%\bin` to your PATH

## 2. Configure Tomcat for Development

### Update `conf/server.xml` (optional for hot reloading)
Add this context to your `conf/server.xml`:
```xml
<Context docBase="C:\path\to\your\vibeSoul\target\vibeSoul" 
         path="/" 
         reloadable="true"
         crossContext="true">
</Context>
```

### Update `conf/context.xml` for global hot reloading
Add this to the `<Context>` element:
```xml
<Context reloadable="true">
    <JspServlet>
        <init-param>
            <param-name>development</param-name>
            <param-value>true</param-value>
        </init-param>
        <init-param>
            <param-name>checkInterval</param-name>
            <param-value>1</param-value>
        </init-param>
    </JspServlet>
</Context>
```

## 3. Update Maven Configuration

Update your `pom.xml` with the correct Tomcat plugin:

```xml
<plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.2</version>
    <configuration>
        <url>http://localhost:8080/manager/text</url>
        <server>tomcat</server>
        <path>/</path>
        <update>true</update>
        <contextReloadable>true</contextReloadable>
    </configuration>
</plugin>
```

## 4. Setup Tomcat Users for Maven Deployment

Edit `conf/tomcat-users.xml`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users>
    <role rolename="manager-gui"/>
    <role rolename="manager-script"/>
    <role rolename="manager-jmx"/>
    <role rolename="manager-status"/>
    <user username="admin" password="admin" roles="manager-gui,manager-script,manager-jmx,manager-status"/>
</tomcat-users>
```

## 5. Setup Maven Settings

Add this to your `~/.m2/settings.xml`:
```xml
<settings>
    <servers>
        <server>
            <id>tomcat</id>
            <username>admin</username>
            <password>admin</password>
        </server>
    </servers>
</settings>
```

## 6. Deployment Methods

### Method A: Manual WAR Deployment
1. Build your project: `mvn clean package`
2. Copy `target/vibeSoul.war` to `%CATALINA_HOME%/webapps/`
3. Start Tomcat: `%CATALINA_HOME%/bin/startup.bat`

### Method B: Maven Tomcat Plugin Deployment
```bash
mvn tomcat7:deploy
# or for redeployment
mvn tomcat7:redeploy
```

### Method C: Exploded Directory Deployment (Best for Development)
1. Build project: `mvn clean package`
2. Extract WAR file to `webapps/vibeSoul/` directory
3. Configure context in `conf/server.xml` as shown above

## 7. Running Tomcat

### Start Tomcat:
```bash
%CATALINA_HOME%/bin/startup.bat
```

### Stop Tomcat:
```bash
%CATALINA_HOME%/bin/shutdown.bat
```

## 8. Hot Reload Configuration

Your existing `src/main/webapp/META-INF/context.xml` is already configured for hot reloading. For best results:

1. Use exploded directory deployment
2. Ensure `reloadable="true"` in context configuration
3. JSP changes should reload automatically
4. Java class changes require context reload (automatic with reloadable=true)

## 9. Access Your Application

- Application: http://localhost:8080/
- Tomcat Manager: http://localhost:8080/manager/html
- Username: admin
- Password: admin

## 10. Troubleshooting

### Common Issues:
1. **Port 8080 already in use**: Change port in `conf/server.xml`
2. **Permission denied**: Run Tomcat as administrator
3. **Hot reload not working**: 
   - Ensure `reloadable="true"`
   - Check Tomcat logs in `logs/catalina.out`
   - Verify context configuration

### Logs Location:
- `%CATALINA_HOME%/logs/catalina.out` - Main log file
- `%CATALINA_HOME%/logs/localhost.log` - Application logs

## 11. Development Workflow

1. Start Tomcat: `startup.bat`
2. Make changes to JSP files
3. Changes auto-reload (check Tomcat logs)
4. For Java changes: `mvn clean package` and redeploy
5. Monitor logs for any errors

## 12. Security Notes

- Change default passwords in production
- Remove manager app in production if not needed
- Consider SSL configuration for production

This setup provides similar hot reload functionality to Smart Tomcat but using standard Apache Tomcat 11.
