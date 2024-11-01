# AWS IP address ranges

AWS publishes all of its IP address ranges at this url in JSON format

https://ip-ranges.amazonaws/ip-ranges.json

Might need these for allowlists.


## Service endpoints

URL of the entry proint for an AWS web service

protocol://service-code.region-code.amazonaws.com

e.g.

https://cloudformation.us-east-2.amazonaws.com

Four types of service endpoint

1. Global endpoints
2. Regional endpoints
3. FIPS endpoints
4. Dualstack endpoints

# CLI input flag

we can populate params if the --cli-input flag is available for a subcommand

e.g. 

    aws iotevents create-input --cli-input-josn file://pressureInput.json

## Configuration files

~/.aws/credentials
~/.aws/config

credentials takes preference over config

### S3 specific settings

### Named profiles

allow you to switch better different configurations quickly 

leaving out the default profile is good practice.

You can set an ENV VAR to set the profile export AWS_PROFILE="production"

### AWS CLI Configure commands

```sh
aws configure
```

You can set, unset, get or import

If you have sso you can configure using sso command

### Environment variables

Useful for scripting

Common ones

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_DEFAULT_REGION

AWS_CA_BUNDLE
AWS_CLI_AUTO_PROMPT
AWS_CLI_FILE_ENCODING
AWS_CONFIG_FILE


### AWS CLI Auto Prompt

AWS CLI v2

powerful interactive shell built into AWS CLI to assist writing CLI commands

- Fuzzy search
- Command completion
- Paramenter completion
- resource completion
-

Pressing [F3] will bring up a documentation pane

```sh
aws --cli-auto-prompt
export AWS_CLI_AUTO_PROMPT=on
```


Two modes
- full mode
- partial mode (recommended)

only uses auto-prompt mode if the command is incomplete or cannot run due to client-side validation errors

Ctrl+R works inside AWS CLI Autoprompt

