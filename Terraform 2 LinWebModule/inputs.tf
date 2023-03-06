# subnet vars
variable "subname" {
    type = string
    description = "existing subnet"
}

variable "vnetname" {
    type = string
    description = "existing vnet"
}

variable "vnetrg" {
    type = string
    description = "The name of the vnet resource group"
}
   