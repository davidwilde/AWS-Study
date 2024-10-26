## Create a bucket

aws s3 mb s3://encryption-fun-dw-696o

## Create a file

echo "Hello world" > hello.txt
aws s3 cp hello.txt s3://encryption-fun-dw-696o 

## Put object with encryption of KMS

aws s3api put-object \
--bucket encryption-fun-dw-696o \
--key hello.txt \
--body hello.txt \
--server-side-encryption aws:kms
--sskms-key-id 