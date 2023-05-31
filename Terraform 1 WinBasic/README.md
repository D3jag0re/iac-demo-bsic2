## WinBasic

This will be for spinning up a basic windows VM as well as creating all the dependencies such as RG / VNet / Subnet etc. 
This readme assumes you have terraform installed. If you do not please see <LINK> 
The goal of 'WinBasic' is to spin up the resources, and be able to RDP in.

Steps: 

1. You will need to create a .tfvars file (ex. terraform.tfvars) in this folder with the following parameters (as defined in the input file):
    - rgname 
    - vnetname 
    - subname 
    - sgname 
    - vmname
    - niname 
    - location 
    - admin_username 
    - admin_password 

    Ex. rgname = "resourcegroup1" 

2. From the terminal, navigate to this folder.

3. Connect to your Azure environment using the Azure CLI with the command: az login

4. Set the Subscription you want to deploy the resources to:
    - run 'az account list -otable' to see a list of your subscriptions (isDef column shows the current subscription as True)
    - run 'az account set --subscription <subscription_name>' to set the subscription 
    - for further confirmation on the selected subscription run 'az account show'

