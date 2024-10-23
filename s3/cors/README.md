## Create a bucket

```sh
aws s3 mb s3://cors-fun-dw-691274
```

## Change block public access

```sh
aws s3api put-public-access-block \
--bucket cors-fun-dw-691274 \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy

```sh
aws s3api put-bucket-policy --bucket cors-fun-dw-691274 --policy file://policy.json
```

## Turn on static website hosting

```sh
aws s3api put-bucket-website --bucket cors-fun-dw-691274  --website-configuration file://website.json
```

## Upload our index.html file and include a resource  that would be cross-origin

```sh
aws s3 cp index.html s3://cors-fun-dw-691274
```

## Get the website endpoint for S3
```sh
http://cors-fun-dw-691274.s3.website-eu-west-2.amazonaws.com
```



## Apply a CORS policy
```sh
aws s3api put-bucket-cors --bucket MyBucket --cors-configuration file://cors.json
```


