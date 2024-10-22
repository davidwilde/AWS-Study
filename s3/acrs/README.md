## Create a bucket

```sh
aws s3api create-bucket --bucket acl-example-dw-3759 --region us-west --create-bucket-configuration LocationConstraint=eu-west-2
```

Create 2 accounts with the same credit card.

## Turn off Block Public Access for ACLs

```sh
aws s3api put-public-access-block \
--bucket acl-example-dw-3759 \
--public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=true,RestrictPublicBuckets=true" 
```

```sh
aws s3api get-public-access-block \
--bucket acl-example-dw-3759
```


```sh
aws s3api put-bucket-ownership-controls \
--bucket acl-example-dw-3759 \
--ownership-controls="Rules=[{ObjectOwnership=BucketOwnerPreferred}]
```


## Access Bucket from other account

## Cleanup

