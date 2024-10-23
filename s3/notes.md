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
 - Was cheaper
 - Standard now cheaper than RRS
 - No cost benefit to customers
S3 Intelligent Tiering - Uses ML to anylyze object usage and determine storage class
- automatically moves objects into different storage tiers to reduce storage costs, but charges a low month cost for object monitoring and automation
- frequent access tier automatic - the default tier objects remain here as long as they are being accessed
- infrequent access tier - automatic - if object is not accessed after 30 days its moved here
- archive instant access tier - automatic - if object is not accessed after 90 days its moved here
- archive access tier - optional - after activation if object into accessed after 90 days
- deep archive access tier - optional - if object is not accessed after 180 days
- Has additional cost to analyze your objects for 30 days.

S3 Express One-Zone single digit ms performance, special bucket type, one AZ, 50% less than standard cost
S3 Standard-IA (infrequent access) fast, cheaper if you access less than once a month. Extar fee to retrieve. 50% less than standard (reduced availability)
 - 11 9s of durability
 - availability 39s - slower availability than S3 standard
 - 50% cheaper  __as long as you are not accessing file more than onec a month__
 - Retrieval time within milliseconds
 - scalability easily scales to storage size and number of requests like S3 standard
 - Use cases - data that is accessed less frequently but requires quick access when needed, such as disaster recovery, backups, or long-term data stores where data is not frequently accessed.
 - Pricing
 Storage per GB
 Per Requests
 Has Retrieval fee
 Has a minimum storage duration charge of 30 days

S3 One-Zone-IA - Fast object only exist in one AZ. Cheaper than standard IA by 20% less
 - 11 9s of durability like S3 Standard
 - lower availability: 99.5% Since its in a single AZ it has even lower availability than Standard IA
 - 20% cheaper than standard IA
 - Data stored in 1 availability zones there is a risk of data loss in case of AZ disaster
 - Use case - Ideal for secondary backup copies of on-prem data, or for storing data than can be recreated in the even of an AAZ failure. It's also suitable for storing infrequently accessed data that is non mission critical
 - Pricing storage per GB, per requests, has retrieval fee, has minimum storage duration charge of 30 days

S3 Glacier Instant Retrieval - for long-term cold storage. Get data instantly
 - storage class designed for rarely accessed data that still needs immediate access in performance-sensitive use cases.
 - High durability 11 9s just like S3 standard
 - High availability 3 9s of availability like S3 standard IA
 - cost effective storage. 68% lower cost than Standard IA
 - for long lived data than is accessed once per quarter
 - retrieval time: within milliseconds (low latency)
 - use cases - rarely access data that needs immediate access e.g. image hosting, online file-sharing applications, medical imaging and health records, news media assets, and satellite and aerial imaging.
 - pricing: storage per GB, per requests, has retrieval fee, has minimum storage duration charge of 90 days
 - does not require a vault

S3 Glacier Flexible Retrieval - takes minutes to hours to get data
 - formerly S3 Glacier
 - combines S3 and Glacier into a single set of APIs.
 - considerably faster than Glacier vault based storage
 - 3 retrieval tiers
 - expediated tier 1-5 mins limited to 250MB archive size, 
 - standard tier 3-5 hours. No archive size limit. 
 - bulk tier 5-12 hours. No archive size limit, even petabytes of data
 - you pay per GB and number of requests
 - archived objects will have an additional 40KBs of data. 32KB for archive index and archive metadata information
 - 8KB for the name of the object
 - You should stored fewer and larger files e.g. zip files

S3 Glacier Deep Archive - lowest storage class. Data retrieval time is 12 hours
 - Combines S3 and Glacier into a single set of APIs. More cost effective than S3 glacier flexible but a greater cost of retrieval
 - standrad tier 12-48 hours. No archive limit. Default option
 - Bulk tier 12-48 hours. No archive size limit, even petabytes worth of data

## Security
Bucket Policies: Define permissions for an entire S3 bucket using JSON-based access policy language.
Access Contrrol Lists (ACLs): Provide a legacy method to manage access permissions on individual objects and buckets.
AWS PrivateLink for Amazon S3: Enables private network access to S3, bypassing the public internet for enhanced security.
Cross-Origin Resource Sharing (CORS): Allows restricted resources on a web page from another domain to be requested.
Amazon S3 Block Public Access: Offers settings to easily block public access to all your S3 resources.
IAM Access Analyzer for S3: Analyzes resource policies to help identify and mitigate potential access risks.
Internetwork Traffic Privacy: Ensures data privacy by encrypting data moving between AWS services and the Internet.
Object Ownership: Manages data ownership between AWS accounts when objects are uploaded to S3 buckets.
Access Points: Simplifies managing data access at scale for shared datasets in S3.
Access Grants: Providing access to S3 data via a directory services e.g. Active Directory
Versioning: Preserves, retrieves and restores every version of every object stored in an S3 bucket
MFA Delete: Adds an additional layer of security by requiring MFA for the deletion of S3 objects.
Object Tags: Provides a way to categorize storage by assigning key-value pairs to S3 objecs.
In transit Encryption: Protects data by encrypting it as it travels to and from S3 over the internet.
Server-Side encryption: Automatically encrypts data when writing it to S3 and decrypts it after downloading
Compliance Validation for Amazon S3: Ensures S3 services meet compliance requirements like HIPAA, GDPR etc
Infrastructure Security: Protects the underlying nifrastructure of the S3 service, ensuring data integrity and availability.

Block Public Access is a safety feature that is enabled by default to block all public access to an S3 bucket
Unrestricted access to S3 is the #1 security misconfiguration

The are four options:

- New Access control lists (ACLs)
- Any Access Control Lists
- 

### Access Control Lists (ACLs)

This is a legacy feature of S3 and there are more robust ways to porvide cross-account access via bucket policies and access points.
Need to know for the exam. 

grand basic read/write permissions to other AWS accounts

- you can grant permissions only to other AWS accounts
- you cannot grant permissions to users in your account
- you cannot grant conditional permissions
- you cannot explicitly deny permissions


### Bucket policies

S3 Buckt Policy is resourc-based policy to grant an s3 buckt and bucket objects to other principles e.g. AWS Accounts, Users, AWS services

- Only allow a specific rol to read objects with prod object tag
- restrict access to specific IP

#### S3 bucket policies vs IAM policies

S3 bucket policies have ovelapping functionality as an IAM policy that grant access to S3.
S3 Bucket policies proivde convenience over IAM policies granting S3 access.

- S3 Bucket Policy 

Provides access to aspecific buckte and its objecs
You can specify mulitple principal to grant access

Bucket policies can be 20 KB in size

Block Pbilc Access is turend on by defalut and will DENY all anon access even if the bucket policy grant its unless the feature is turned off

- IAM Policy

Provides access to many AWS services
Can provide permissions for multiple buckets in one policy

The principal by default is the entity the IAM policy is attached to

IAM policy sizes are limited based on the principal:

Users 2KB
Groups 5KB
Roles 10KB

#### IAM ACcess Analyzer for S3

will alert you when your S3 buckets are exposed to the Internet or other AWS Accounts

You need to create an analyzer

#### Internework traffic privacy

keeping data private as it travels across different networks

AWS PrivateLink (VPC Interface Endpoints)
- Allows you to connect an Elastic Network Interface (ENI) directly to other AWS Services eg S3, EC2, Lamda.
- can connect to 3rd praty services via AWS Marketplace
- can go cross account
- fine grained permissions via VPC endpoint policies
- No charge for using

VPC Gateway Endpoint
- Allows you to ocnnect a VPC directly to S3 (or DynamoDB) staying private within the internal AWS Network.
- VPC Gateway Endpoint can not go cross-account
- Does not have fine grain permissions
- No charge though


#### CORS

HTTP header to allow a server to indicate any other origins than its own from which a browser should permit loading of accounts

Allowss you to set CORS configuration to a S3 bucket with static website hosting so different origins can perform HTP requests from your S3 Static website.

The CORS configuration can be in either JSON or XML


Versioning


## Encryption

Encrypotion in Transit - data that is secure when moving betweeen locations
Algorithms: TLS, SSL

This encryption ensures that data remains confidential and cannot be intercepted or viewed by unauthorized parties while in transit.

Data will be encrypted sender-side. Data will be decrypted server-side


TLS - Transport Layer Security
An encryption protocol for data integrity between two or more communicating computer application.
TLS 1.0, 1.1 are deprecated. TLS 1.2 and TLS 1.3 is the current best practice

SSL - Secure sockets layers
An encryption protocol for data integrity between two or more communicating computer application.
SSL 1.0, 2.0 and 3.0 are deprecated



Website hosting