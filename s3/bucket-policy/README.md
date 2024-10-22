## Create a bucket

aws s3 mb s3://bucket-policy-example-dw-6103

## Create bucket policy

aws s3api put-bucket-policy --bucket bucket-policy-example-dw-6103

# In the other account access the bucket

touch bootcamp.txt
aws s3 cp bootcamp.txt s3://bucket-policy-example-dw-6103
aws ls s3://bucket-policy-example-dw-6103

## Cleanup

aws s3 rm s3://bucket-policy-example-dw-6103/bootcamp.txt
aws s3 rb s3://bucket-policy-example-dw-6103



