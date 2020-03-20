# How configure aws-cli


How configure aws-cli with mfa:

first you need to configure your aws-cli with command:
```
aws configure
```
This command will to make a folder `.aws` in your home.
Information you will need:

```
AWS Access Key ID [None]: (key)
AWS Secret Access Key [None]: (key)
Default region name [None]: us-east-1 (example)
Default output format [None]: (optional)
```

after this you can create a file with this content and set this file with `chmod +x filename.sh`

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
ARN_OF_MFA=arn:aws:iam::026783351078:mfa/$USER
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


After you did everything just you run the file with MFA code with argument like 

`./filename.sh 121212` (just a example).