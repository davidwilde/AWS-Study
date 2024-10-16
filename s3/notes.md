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


### Checksums 

A checksum is used to check the sum (amount) of data to ensure the data integrity of a file.
If daat is downloaded and if in-transit data is loss or mangled the checksum will determine this is something wrong with the file.

Amazon S3 offers the folliwng checksum algorithms:

 - CRC32
 - CRC32C
 - SHA1
 - SHA256


## Metadata

provides information about other data but not the contents itself

useful for
 - categorising and organising data
 - providing contents about data

you can attach metadata to S3 objects at anything

there are
- system defined
- user defined

System defined metadata is data that only amazon can control. 

E.g. 
- content type
- cache control
- content disposition
- content encoding
- content-language
- Expires
- X-amz-website-redirection-location

User defined is set by the user. It must start with **x-amz-meta-**

E.g.
- x-amz-meta-encryption: "AES-256"
- x-amz-meta-camera-model: "Canon EOS 5D"


## S3 Object Lock

Prevents the deletion of objects in a bucket
Needed for companies that need to prevent objects being deleted to have:

- data integrity
- regulatory compliance

WORM - write once read many

Only through the AWS API


## Amazon S3 Bucket URI

s3://mybucket/filename.txt

## AWS S3 CLI

### aws s3

A high-level way to interact with S3 buckets and objects

### aws s3api

A low level way to interact with S3 buckets and objects

### aws s3control

Managing s3 access points, S3 outposts buckets, S3 batch operations, storage lens.

### aws s3outposts

Manage endpoints for S3 outposts


## S3 Request Styles

When making requests by using the REST API there are two styles of request:

1. Virtual hosted style requests - the bucket name is a subdomain on the host
2. Path-style requests - the bucket name is in the request path

***Path style URLs will be discontinued in the future***

## Dualstack Endpoints

There are two possible endpoints when accessing Amazon S3 API. Dualstack handles both IPV4 and PV6 traffic

Standard and Dualstack

https://s3.dualstack.us-east-2.amazonaws.com

At one point AWS only offered IPV4 and Dualstack is designed as its future replacement since PIV4 addresses are running out and IPV6 has a larger public address space.

## Storage classes

Durability - 11 9s (99.99999999%)

S3 Standard - fast, availabel and durable
 - availability - 4 9s
 - redundency - 3 or more zones
 - retrieval time - milliseconds
 - high throughput - frequently accessed
 - scalability - easily scales to storage size and number of requests
 - use cases - wide range
S3 Reduced Redundancy Storage (RRS) legacy storage class
S3 Intelligent Tiering - Uses ML to anylyze object usage and determine storage class
S3 Express One-Zone single digit ms performance, special bucket type, one AZ, 50% less than standard cost
S3 Standard-IA (infrequent access) fast, cheaper if you access less than once a month. Extar fee to retrieve. 50% less than standard (reduced availability)
S3 One-Zone-IA - Fast object only exist in one AZ. Cheaper than standard IA by 20% less
S3 Glacier Instant Retrieval - for long-term cold storage. Get data instantly
S3 Glacier Flexible Retrieval - takes minutes to hours to get data
S3 Glacier Deep Archive - lowest storage class. Data retrieval time is 12 hours

Versioning


Encryption


Website hosting