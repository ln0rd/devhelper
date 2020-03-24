# How configure aws-cli with mfa:

first you need to configure your aws-cli with command:

`aws configure`

This command will to make a folder .aws in your home. Information you will need:
```
AWS Access Key ID [None]: (key) 
AWS Secret Access Key [None]: (key) 
Default region name [None]: us-east-1 (example)
Default output format [None]: (optional)
```
Everything you can get in your aws console.After this step you can to create a file with this content and set the permission file: chmod +x yourfilename.sh

Content
```
#!/bin/bash
AWS_CLI='which aws'
if [ $? -ne 0 ]; then
  echo "AWS CLI is not installed; exiting"
  exit 1
fi
if [ $# -ne 1 ]; then
  echo "Usage: $0  <MFA_TOKEN_CODE>"
  echo "Where:"
  echo "   <MFA_TOKEN_CODE> = Code from virtual MFA device"
  exit 2
fi
ARN_OF_MFA=arn:aws:iam::{YOUR ID ARN IN AWS}:mfa/$USER
MFA_TOKEN_CODE=$1
DURATION=129600
echo "MFA ARN: $ARN_OF_MFA"
read AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN <<< \
$( aws sts get-session-token \
  --duration $DURATION  \
  --serial-number $ARN_OF_MFA \
  --token-code $MFA_TOKEN_CODE \
  --output text  | awk '{ print $2, $4, $5 }')
echo "AWS_ACCESS_KEY_ID: " $AWS_ACCESS_KEY_ID
echo "AWS_SECRET_ACCESS_KEY: " $AWS_SECRET_ACCESS_KEY
echo "AWS_SESSION_TOKEN: " $AWS_SESSION_TOKEN
if [ -z "$AWS_ACCESS_KEY_ID" ]
then
  exit 1
fi
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws configure set aws_session_token "$AWS_SESSION_TOKEN"
```
in your .aws folder need contain two files, like example:

config
```
[profile mfa]
region = us-east-1
output = json
[default]
region = us-east-1
output = json
```
no credentials mantenha o profile e o default o mesmo credentials

in credentials file keep default content like your profile
```
[default]
aws_access_key_id = get in aws console
aws_secret_access_key = get in aws console
[profile mfa]
aws_access_key_id = get in aws console
aws_secret_access_key = get in aws console
```

Let's test it, run aws s3 ls command and if you get list content in return, its working! 

after this step we just need to authentication in docker, run the command `aws ecr get-login` copy the result and execute it but without `-e none url...`
