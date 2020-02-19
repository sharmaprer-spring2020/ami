# Building custom AMI using Packer with Ubuntu 18 LTS as source image #

### Prerequisites  ###
* Homebrew for MAC OS
* Packer Installation and setup

### Packer Installation Steps on Mac OS ###

1. Open terminal and execute below command to install home brew on MAC OS
```
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

2. After successfull installation of [Homebrew](https://brew.sh/), execute following command:
```
    brew install packer
```
* For additional packer installation methods please refer packer installation [guide](https://packer.io/intro/getting-started/install.html#alternative-installation-methods)

### Verify Packer Installation ###

Open terminal and hit **`packer`**. The output should be as in below image:

![PackerInstallation](/images/PackerInstallation.png)


##### Execute Packer Build Locally #####
To get project on local do following:  
1. __`git clone git@github.com:prernsha/ami.git`__
2. **`cd`** into **`ami`**
3. Execute the following command to verify packer Template *`packerTemplate.json`* is correct:
    1. Replace following variables with their values:
        * dev_aws_access_key 
        * dev_aws_secret_key
        * awsRegion : us-east-1
        * sourceAMI : ami-07ebfd5b3428b6f4d
 ```
    packer validate \
    -var "aws_access_key=${dev_aws_access_key}" \
    -var "aws_secret_key=${dev_aws_secret_key}" \
    -var "aws_region=${awsRegion}" \
    -var "source_ami=${sourceAMI}" \
    packerTemplate.json
 ```

4. Now, if you get step 3 output as **_Template Validate Successfully_**. Perform packer build to build an image into AWS dev account.
```
    packer build \
    -var "aws_access_key=${dev_aws_access_key}" \
    -var "aws_secret_key=${dev_aws_secret_key}" \
    -var "aws_region=${awsRegion}" \
    -var "source_ami=${sourceAMI}" \
    packerTemplate.json
```
