variable "ssh_password" {
  type        = string
}

variable "ssh_user" {
  type        = string
}

variable "ssh_pub_key" {
  type        = string
}

variable "k3s_masters" {
  type        = map(any)
}

variable "k3s_workers" {
  type = map(any)
  
}



variable "k3s_source_template" {
  type = string
  
}

variable "ciuser" {
  type = string
  
}

variable "cipassword" {
  type = string
  
}