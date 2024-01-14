variable "db_name" {
  description = "db name"
  type        = string
}

variable "db_instance_identifier" {
  description = "db instance identifier"
  type        = string  
}

variable "db_username" {
  description = "db instance username"
  type        = string  
}

variable "db_password" {
  description = "db instance pwd"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "db instance port"
  type        = number
  default     = 3306
}

variable "db_engine" {
  description = "db instance engine"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "db instance version"
  type        = string
  default     = "5.7"
}

variable "db_instance_class" {
  description = "db instance class"
  type        = string
  default     = "db.t3a.large"
}

variable "db_allocated_storage" {
  description = "db allocated storage"
  type        = number
  default     = 5
}