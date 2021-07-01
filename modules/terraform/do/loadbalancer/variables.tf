variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "region" {
  type        = string
  default     = ""
  description = "The region for the loadbalancer"
}

variable "entry_ports" {
  type        = list
  default     = []
  description = "List of entry ports."
}

variable "entry_protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol. If not icmp, tcp, udp, or all use the."
}

variable "target_ports" {
  type        = list
  default     = []
  description = "List of target ports."
}

variable "target_protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol. If not icmp, tcp, udp, or all use the."
}

variable "port" {
  type        = string
  default     = ""
  description = "Health check port."
}

variable "protocol" {
  type        = string
  default     = ""
  description = "Health check protocol."
}

variable "droplet_ids" {
  type        = list
  default     = []
  description = "The ID of the IDs of the droplets."
}

variable "droplet_tag" {
  type        = string
  default     = ""
  description = "The tag of the droplets to add."
}

variable "vpc_uuid" {}