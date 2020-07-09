module "kubernetes" {
  source = "./kubernetes"
  region = "us-east1"

  project_id_map = {
    default = "gleaming-design-282503"
  }
}

output "connection-command" {
  value = "${module.kubernetes.connect-string}"
}
