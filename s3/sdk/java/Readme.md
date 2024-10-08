# Create a new Maven Project

```sh
mvn -B archetype:generate \
 -DarchetypeGroupId=software.amazon.awssdk \
 -DarchetypeArtifactId=archetype-lambda -Dservice=s3 -Dregion=EU_WEST_2 \
 -DarchetypeVersion=2.21.29 \
 -DgroupId=com.example.myapp \
 -DartifactId=myapp
```