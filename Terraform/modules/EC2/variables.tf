variable "environment" {
  description = "dev or prod"
}
variable "ami" {
  default = "ami-0f30a9c3a48f3fa79"
}

variable "instance_type" {
  default = "t2.large"
}

variable "availability_zone" {
  description = "zona de disponibilidad"
  type        = string
}

variable "jenkins_security_group" {
  description = "grupo de seguridad de la instancia"
  type        = string
}

variable "public_subnet" {
  description = "subnet publica"
  type        = string
}

variable "ami_amazon" {
  default = "ami-0ddda618e961f2270"
}

variable "monitoring_security_group" {
  description = "grupo de seguridad de la instancia de monitoreo"
  type        = string
}

variable "private_subnet" {
  description = "subnet privada"
  type        = string
}
