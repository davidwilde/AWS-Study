## Create a new s3 bucket

```md
aws s3 mb s3://checksums-examples-dw-9847
```


## CReate a file that we will do a checksum on

```
echo "Hello David" > myfile.txt
```

# Get a checsum of a file for md5
```md
md5sum myfile.txt
```

## Upload our file and look at its etag

```
aws s3 cp myfile.txt s3://checksums-examples
```