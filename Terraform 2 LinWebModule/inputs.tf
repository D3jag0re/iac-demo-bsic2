variable "rgname" {
    type = string
    description = "Existing RG"
}

variable "location" {
    type = string
    description = "Location"
}

# subnet vars
variable "subname" {
    type = string
    description = "existing subnet"
}

variable "vnetname" {
    type = string
    description = "existing vnet"
}

variable "vmname" {
    type = string
    description = "The name of the VM"
}
