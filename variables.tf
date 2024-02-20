variable "ami_id" {
  description = "The AMI ID of the instance"
  type        = string
  default     = "ami-0fc5d935ebf8bc3bc" # ubuntu 2204
}

variable "vpc_id" {
  description = "AWS VPC"
  type        = string
}

variable "instance_type" {
  description = "The type of the instance"
  type        = string
  default     = "t2.small"
}

variable "volume_size" {
  description = "The size of the root volume in GB"
  type        = number
  default     = 40
}


variable "subnet_id" {
  description = "The VPC default subnet ID"
  type        = string
}

variable "ssh_key" {
  description = "AWS SSH key for accessing instances"
  type        = string
}

variable "ssh_key_path" {
  description = "private key path in the SSH client filesystem"
  type        = string
}

variable "ssh_user" {
  description = "SSH user the SSH client will connect as"
  type        = string
  default     = "ubuntu"
}


variable "one_ee" {
  description = "Set to --enterprise <ee_token> for an EE setup or emtpy for CE"
  type        = string
}

variable "one_password" {
  description = "Password for the oneadmin user of the OpenNebula instance running on the minione AWS instance"
  type        = string
}

variable "one_sunstone_port" {
  description = "HTTP port where OpenNebula Sunstone will be running"
  type        = number
  default     = 9869
}

variable "one_fireedge_port" {
  description = "HTTP port where OpenNebula Sunstone will be running"
  type        = number
  default     = 2616
}

variable "one_version" {
  description = "OpenNebula version to install"
  type        = string
  default     = "6.4"
}

variable "one-apps-deps-deb" {
  description = "Dependencies required by one-apps to build appliances on Debian based images. Defaults to Ubuntu package"
  type        = string
  default     = "bash cloud-utils genisoimage libguestfs0 libguestfs-tools make nginx qemu-utils rpm rsync ruby qemu qemu-system-x86"
}


variable "packer-version" {
  type = string
  default = "1.10.0"
}
