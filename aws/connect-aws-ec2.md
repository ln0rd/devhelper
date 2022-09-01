Example

Instance ID
service name (service-hogwarts)

    Open an SSH client.

    Locate your private key file. The key used to launch this instance is aws-connect.pem

    Run this command, if necessary, to ensure your key is not publicly viewable.

 chmod 400 aws-connect.pem

Connect to your instance using its Public DNS:

     ec2-3-85-235-19.compute-1.amazonaws.com

Example:
 ssh -i "aws-connect.pem" ec2-user@ec2-3-85-235-19.compute-1.amazonaws.com