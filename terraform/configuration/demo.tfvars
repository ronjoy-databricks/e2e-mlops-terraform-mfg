#Referenced common across modules
owner_custom = "ron"
purpose_custom = "demo"

#Referenced in resource-group module
owner = "ron.joy@databricks.com"
purpose = "test"
location = "southcentralus"
org = "databricks"

#Referenced in network module
address_space = ["10.10.0.0/21"]

subnets = {
    subnet1 = {
        name = "public_subnet"
        address_space = ["10.10.1.0/26"]
        subnet_delegation = true
        }

    subnet2 = {
        name = "private_subnet"
        address_space = ["10.10.1.64/26"]
        subnet_delegation = true
        }

    subnet3 = {
        name = "privatelink_subnet"
        address_space = ["10.10.1.128/26"]
        subnet_delegation = false
        }
    
    subnet4 = {
        name = "AzureFirewallSubnet"
        address_space = ["10.10.1.192/26"]
        subnet_delegation = false
        }
}

nsg = {
    public_nsg = {
        name = "public_nsg"
        }

    private_nsg = {
        name = "private_nsg"
        }
    }

    private_link_subnet = ""

    fw_subnet_id = ""

    rt_public_subnet = ""
    
    rt_private_subnet = ""