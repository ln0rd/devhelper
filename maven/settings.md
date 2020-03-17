Talvez em algum momento {sujeito} precise definir um usuário e apontar para alguns repositorios para que o maven identifique algumas libs, você deve criar a pasta

```~/.m2/```

e colocar o properties lá

exemplo de um properties

```
<?xml version="1.0" encoding="UTF-8"?>
<settings xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd" xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <servers>
        <server>
            <username>admin</username>
            <password>SENHA AQUI</password>
            <id>central</id>
        </server>
        <server>
            <username>admin</username>
            <password>SENHA AQUI</password>
            <id>snapshots</id>
        </server>
    </servers>
    <profiles>
        <profile>
            <repositories>
                <repository>
                    <snapshots>
                        <enabled>false</enabled>
                    </snapshots>
                    <id>central</id>
                    <name>libs-release</name>
                    <url>URL AQUI</url>
                </repository>
                <repository>
                    <snapshots />
                    <id>snapshots</id>
                    <name>libs-snapshot</name>
                    <url>URL AQUI</url>
                </repository>
            </repositories>
            <pluginRepositories>
                <pluginRepository>
                    <snapshots>
                        <enabled>false</enabled>
                    </snapshots>
                    <id>central</id>
                    <name>plugins-release</name>
                    <url>URL AQUIL</url>
                </pluginRepository>
                <pluginRepository>
                    <snapshots />
                    <id>snapshots</id>
                    <name>plugins-snapshot</name>
                    <url>URL AQUI</url>
                </pluginRepository>
            </pluginRepositories>
            <id>artifactory</id>
        </profile>
    </profiles>
    <activeProfiles>
        <activeProfile>artifactory</activeProfile>
    </activeProfiles>
</settings>