navvy
=====

Infrastructure installation for *201 Created* projects.


## Pre-requisites for OS X

*   Install [homebrew]

        # follow instructions on website

*   Install [terraform]

        brew install terraform

*   Install [terraform-inventory]

        TFI_RELEASE=0.6.1
        wget https://github.com/adammck/terraform-inventory/releases/download/v0.6.1/terraform-inventory_v${TFI_RELEASE}_darwin_amd64.zip
        unzip terraform-inventory_v${TFI_RELEASE}_darwin_amd64.zip
        mv terraform-inventory /usr/local/bin/terraform-inventory-${TFI_RELEASE}
        ln -sf terraform-inventory-${TFI_RELEASE} /usr/local/bin/terraform-inventory

*   Install [ansible]

        sudo easy_install pip
        sudo pip install --upgrade pip
        sudo pip install ansible

[homebrew]: http://brew.sh
[terraform]: https://www.terraform.io
[terraform-inventory]: https://github.com/adammck/terraform-inventory
[ansible]: https://www.ansible.com


## Check out the keys repository

From within your local checkout of this repo, bring in the dependencies:

    git submodule update --init

This will fail on the `keys` repo if you aren't me, so you will need some
things if you are intending to actually try this out (may not work for you
without some more customisation; this is me documenting what I've done as I've
created this repository):

    mkdir keys

    # fill out missing values for AWS operations
    cp sample_aws.vars.tf keys/aws.vars.tf
    ${EDITOR} keys/aws.vars.tf

    # create the SSH key used to connect to EC2
    # instances, and add it to your ssh agent
    ssh-keygen -b 4096 -f keys/id_rsa
    ssh-add keys/id_rsa


## Set stuff up

When changing the underlying infrastructure:

    # make changes to terraform configuration...

    cd terraform
    terraform plan

    # if it looks good, run it...
    sh apply.sh

When changing the software installed:

    # make changes to ansible playbooks...
    cd terraform
    sh ansible.sh
