# AWS set up

1. Sign up for AWS (Root Account)

2. Create an IAM user for administration

3. Add an MFA policy to account for security. ```forceMfa.json``` is the policy you can add to create ```forceMFA``` policy.  Refer the following video for the process. 

```
  https://www.youtube.com/watch?v=S49Dbzmv_kk
```

4. You should have IAM user, IAM user's access key and secrety key, AWS account ID by now. 


5. Set up AWS Vault


* Install ```aws-vault``` by following the instruction from following Github.

```
  https://github.com/99designs/aws-vault
```

* Store AWS credentials for the **IAM user** profile. For example, if you created IAM user of ```johnsmith```,

```
  $ aws-vault add jonsmith
  Enter Access Key Id: ABDCDEFDASDASF
  Enter Secret Key: %%%%%%%%%%%%%
```

* You can find mfa_serial from IAM --> My security Credentials
* Copy and paste Assigned MFA device ARN in ```config`` file as below.

![](./img/mfa-arn.png)

```
  $ cat ~/.aws/config
  [default]
  region=us-east-1
  output=json

  [profile cahn]
  region=us-east-1
  mfa_serial=arn:aws:iam::031173249615:mfa/cahn <-- Assigned MFA device from the picture above
```

6. You can use AWS-VAULT.  

```sh
$ aws-vault exec <username> --duration=12h

# my username is cahn
$ aws-vault exec cahn --duration=12h
```

7. Your credential is valid for the next 12 hours.  **aws-vault** stores AWS profile in local environmental variables.

```
$ printenv | grep AWS

AWS_VAULT=cahn
AWS_DEFAULT_REGION=us-east-1
AWS_REGION=us-east-1
AWS_ACCESS_KEY_ID=ASIAQOQQSBJHX2S5UHV5
AWS_SECRET_ACCESS_KEY=rPkxjBSo.....
AWS_SECURITY_TOKEN=FwoGZXIvYXdzE.....
AWS_SESSION_EXPIRATION=2021-06-14T02:56:20Z
```

Therefore, you don't need to set up **profile** in provider block of Terraform AWS any longer.  Terraform will pul all AWS_* variables directly from your local machine.

```sh
terraform {
  required_version = "0.15.5" // use fixed version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0" // right most is lower and upper bound of version
    }
  }
}


provider "aws" {
  region = var.aws_region
  # shared_credentials_file = "/Users/tf_user/.aws/creds"
  # profile                 = "customprofile"
}
```