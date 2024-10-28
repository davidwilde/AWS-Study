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


## Versioning

allow you to store multiple versions of S3 objects

### with versioning you can recover more easily from unintended user actions and application failures
### versioning-enabled buckets can help you recover objects from accidental deletion or overwrite

- store all versions of an object in S3 at the same object key address
- by default S3 versioning is disabled on buckets, and you must explicity enable it
- once enabled, it cannot be disabled, only suspended on the bucket
- fully integrates with S3 lifecycle rules
- MFA delete feature provides extra protection against deletion of your data

Buckets can be in one of 3 states
1. unversioned (default)
2. versioned
3. versioned suspended

### S3 lifecyle

allows you to automate the storage class changes, archival or deletion of objects

set up your own rules

- can be used with versioning
- can be applied to both current and previous versions

E.g. after 7 days move to glacier, after 365 perm delete

Rule actions:
- move current versions of objects between storage classes
- move non-current versions of objects between storage classes
- expire current versions of objects
- perm delete noncurrent versions of objects
- delete expired object delete markers or incomplete multipart uploads

Lifecyle filters:
- filter based on prefix

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

S3 Server side encryption - is **always on** for all new S3 objects.

### SSE-S3

Amazon S3 manages the keys, encrypts using AES-GCM (256-bit algorithm)
S3 encypts each object with a unique key
S3 uses envelope encryption
S3 rotates regularly key automatically
By default all objects will have SSE-S3 applied
There is no additonal charge for using
Uses 256bit advanced encyption


### SSE-KMS 

Amazon Key Management Service and you maneg the keys
You first create a KMS managed key
KMS can automatically rotate keys
KMS key poily controls who can decrypt using the key
KMS can help meet regulatory compliance
Have their own addiotal costs
Must be in the same region as the bucket
To upload with KMS you need kms:GenerateDataKey
To download with KMS you need kms:Decrypt

BUcket key can be set for SSE-KMS for improved performance

### SSE-C - Customer provided key

You provide your own encryption key that Amazon S3 then uses to apply AES-256
You need to provide the encryption key everytime you retrieve objects
The encryption key you upload is removed from Amazon S3 memory after each request
No additonal charge to use
Amazon S3 will store a randomly salted Hash-bashed Message Authentication Code (HMAC) of your encryption key to validate future requests
Presigned URLs support SSE-C

With bucket versioning different object versions can be encrypted with different keys
You manage encyption keys on the client side, you manage any additional safeguards, such as key rotation on the client side


### DDSE-KMS - Dual layer server-side encryption. 

Encrypts cliennt side than server side.
Datas is encrypted twice
The key for client-ide encyption comes from KMS
No additional charges for DSSE and KMS keys

*Encrypt* 
client side requests AWS KMS to generate a data encryption key using CMK
KMS sends two versions of the DEK to you: a plaintext version and an encrypted version
You use plaintext DEK to encrypt your data locally and then discards it from memory
Encrypted version of the DEK is stored alongside the encrypted data in Amazon S3

*Decrypt*
You retriev the encrypted data and the associated encrypted DEK
You send the encrypted DEK to AWS KMS, which decrypts it using the corresponding CMK and returns the plaintext DEK
Use this plaintext DEK to decrypt the data locally and then discard the DEK from memory

_Service side encryption only encrypts the contents of an object, not its metadata_


## Data consistency

When data being kept in different place and wether the data exactly match or do not match

### Strongly consistent
every time request data you can expect consistent data to be returned with x time (1 sec)

_We will never return to you old data. But you will have to wait at least 2 secs for the query to return_

### Eventually Consistent
When you request data you may get back inconsistent data within 2 secs.

_We are giving you whatever data is currently in the database, you may get new data or old data, but if you wait a little bit longer it will generally be up to date_

__Amazon S3 offers *strong consistency* for all read, write, and delete operations__
(Prior to Jan 2020, S3 did not have strong consistency for all S3 operations)

## Object replication

Can help you do the following:

- replicate objects while retaining metadata
- replicate objects into different storage clases
- maintain object copies under different ownership
- keep objects stored over multiple AWS Regions
- Replicate objects within 15 minutes
- Sync buckets, replicate existing objects, and replicate previously failed or replicated objects
- replicate objects and fail over to a bucket in another AWS region

Options
- Cross region replication (live)
- Same region replication (live)
- Bi-directional replication (live)
- S3 batch replication (on-demand)


## Presigned URLs

provide temporary access to upload or download object data via URL

Commonly used to provide access to private objects

You can use AWS CLI or AWS SDK to generate a presigned URL

aws s3 presign s3://mybucket/myobject --expires-in 300


## Object lambda access points

allow you to transform the output requests of S3 objects when you want to present data differently.

E.g. hiding personally identifiable information

S3 object lambda access points only operates on the outputted objects, the original objects in the S3 bucket remain unmodified

Can be performed on the operations:
- HEAD
- GET
- LIST


## Mountpoint for Amazon S3

allows you to mount an S3 bucket to your linux local file system

an open-source client that you install on your Linux OS and provides high throughput access to objects with basic file-system ops

Can:
- read files up to 5TB
- list and read existing files
- create new files

Cannot / does not:
- modify existing files
- delete directories
- support symlinks
- support file locking

Can be used in the following storage classes:
- S3 standard
- S3 standard IA
- S3 one-zone IA
- Reduced redundancy storage (legacy)
- S3 Glacier instant retrieval

## Requesters Pays

bucket option allows the bucket owner to *offset specific S3 costs to the requester* (the user requesting the data)

Bucket owner still pays data storage cost

For when you want to share data but not incur the charges associated with others accessing the data

e.g.
- Collaborative Projects
- Client data storage
- Shared educational resources. 
- Content distribution

Can enable anytime using a toggle

After enabling:

- all requests must authenticate
- requester assumes an IAM role before making their request (The IAM policy will have a s3:RequestPayer condition)
- anonymous access to that bucket is not allowed


Requesters must include `x-amz-request-payer` in their API request header for DELETE, GET, HEAD, POST and PUT requests or as a parameter in a REST request

(presumably so that they are confirming that they are happy to be charged for the retrieval)

Troubleshooting:

A 403 Forbidden request HTTP Error code will occur in the following scenarios:
- The requester doesn't include the parameter x-amz-request-payer
- request authentication fails (something is wrong with the IAM role or IAM policy)
- the request is anonymous
- The request is a SOAP request

When a 403 occurs, no charge will occurs to the requester. No charge will occur to the bucket owner

Website hosting