variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}


variable "zone_name" {
    default = "daws81s.space"
}

variable "zone_id" {
    default = "Z04180323PZ2QTLJV7PXL"
}