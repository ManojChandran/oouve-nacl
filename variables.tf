#----root/variables.tf----

variable "aws-region" {
  description = "stored aws region data"
}

variable "vpc-id" {
  description = "stores vpc id"
}

variable "pub-subnet-tagname" {
  description = "stores public subnet tag name to filter"
}

variable "pvt-subnet-tagname" {
  description = "stores private subnet tag name to filter"
}

variable "db-subnet-tagname" {
  description = "stores databse subnet tag name to filter"
}
