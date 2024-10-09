import { Stack, StackProps } from 'aws-cdk-lib';
import * as s3 from 'aws-cdk-lib/aws-s3'
import * as cdk from "aws-cdk-lib"
import { Construct } from 'constructs';

export class CdkStack extends Stack {
  constructor(scope: cdk.App, id: string, props?: StackProps) {
    super(scope, id, props);

    new s3.Bucket(this, "MyBucket");
  }
}
