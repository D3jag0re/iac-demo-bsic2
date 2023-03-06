# 
variable "subname" {
    type = string
    description = "subnet name"
}

variable "vnetname" {
    type = string
    description = "vnet name"
}

variable "location" {
    type = string
    default = "westus2"
    description = "Azure Location"
}

variable "rgname" {
    type = string
    description = "The name of the existing resource group"
}

variable "sgname" {
    type = string
    description = "The name of the security group"
}

variable "niname" {
    type = string
    description = "Network interface name"
}

variable "vmname" {
    type = string
    description = "The name of the security group"
}

variable "vmsize" {
    type = string
    default = "Standard_B2s"
    description = "The instance size"
}

variable "admin_username" {
    type = string
    description = "Username for Local Admin"
}

variable "admin_password" {
    type = string
    description = "Password for Local Admin"
}