# Notes

S3 buckets are infrastructure and they hold S3 objects

## Naming Rules

- similar to valid URL rules
- used to form URL links

https://myexamplebucket.s3.amazon

- 3-63 characters long
- only lowercase letters, numbers, dots and hyphens arel allowed
- no adjacent periods are allowed.
- Can't be formatted as IP adderss
- Can't sstart with xn--, sthree-s, sthree-configurator
- Can't end with -s3alias, --ol-s3
- must be unique across all AWS accounts in all AWS regions within a partition
- name can't be reused in the same partition until the original bucket is deleted
- Buckets used with S3 transfer accelaration can't have dots in their names

www.exampro.co/ssa-c03


## Restrictions and limitations

- by default 100 buckets
- service request for more
- need to empty bucket before deleting
- no max bucket size
- no limit to number of objects in a bucket
- files can be between 0 5TB <- usually in exam
- files larger than 100MB should use multi-part upload
- S3 for AWS outposts has limits
- Get, Put, List and Delete op.erations are designed for high availability
- Create, Delete or configuration operations should be run less often

## Bucket Types

### General purpose buckets
- Organised data in a flat hierachy
- recommended for most use cases
- used with all storage calsses except can't be used with S3 Express One Zone storage class
- No prefix limits
- general limit of 100 general buckets per account 

### Directory buckets
- organises data folder hieracy
- only used with S3 express one zone storage class
- recommended when you need single digit millisecond performance on PUT and GET
- no prefix limits for directory buckets* 
- default limit of 10 director buckets per account


## Bucket Folders

When you create a folder in S3 console, Amazon S3 creates a zero byte S3 objeect with a name that ends in a forward slash

    myfolder/

- just S3 objects
- don't include metadata, permissions

    aws s3api list-objects --bucket testbucket-ab123

    {
        "Contents": [
            {
                "Key": "myfolder/",
                "Size": 0,
                ...
            },
            {
                "Key: "myfolder/myfile.jpg"
                ...
            }
        ]
    }

## S3 Objects

resources that **represent data** and __is not infrastructure__ 

- Etags - a way to detect when the contents of an object has changed without download the contents
- Checksums - ensures the integrity of a files being uploaded or downloaded
- object prefixes - simulates file-system folders in a flat hierarchy
- object metadata - attach data alongside the content, to describe the contents of the data
- object tags - benefits resources tagging but at the object level
- object locking - makes data files immutable
- object versioning - 

### Etags

An entityt tag is a repsonse header that represent a resource that has changed without the need to download
Etags are useful if you want programmaticaclly detect changed objects


Versioning


Encryption


Website hosting