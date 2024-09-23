variable "filename" {
    default = "./pets.txt"
    description = "The file contains data about petes."
}
  

variable "content" {
  default = " I love Pets!"
}

variable "prefix" {
    default = "Mrs"
    type = list
}

variable "seperator" {
    default = "."
}

variable "length" {
    default = "1"
}