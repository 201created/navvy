# keys to the kingdom
variable "aws_access_key" {
    default = "FILL ME OUT"
}
variable "aws_secret_key" {
    default = "FILL ME OUT"
}

# where to do stuff
variable "aws_region" {
    default = "eu-west-1"
}
variable "aws_availability_zone" {
    default = "eu-west-1a"
}

# enabling ssh access
variable "aws_key_path" {
    default = "id_rsa.pub"
}
variable "aws_key_name" {
    default = "navvy"
}
resource "aws_key_pair" "aws_auth" {
    key_name   = "navvy"
    public_key = "${file(var.aws_key_path)}"
}

variable "home_ip" {
    default = "FILL ME OUT"
}
