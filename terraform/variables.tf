variable "GITHUB_OWNER" {
  type        = string
  default     = ""
  description = "GitHub user"
}

variable "FLUX_GITHUB_REPO" {
  type        = string
  default     = ""
  description = "The name of repository to store Flux manifest"
}
variable "GITHUB_TOKEN" {
  type        = string
  description = "GitHub personal access token"
}

variable "FLUX_GITHUB_TARGET_PATH" {
  type        = string
  default     = "clusters"
  description = " Flux manifets subbdirectory"
}