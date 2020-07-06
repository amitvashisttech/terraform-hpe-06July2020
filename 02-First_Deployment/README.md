# Terraform 11 

## Credentials Syntax
```
provider "google" {
  credentials = "${file("/home/terraform01/.ssh/account.json")}"
  project     = "gleaming-design-282503"
  region      = "us-central1"
#  version     = "~> 1.20.0"
}

```



# Terraform 12 

## Credentials Syntax
```
provider "google" {
  credentials = file("/home/terraform01/.ssh/account.json")
  project     = "gleaming-design-282503"
  region      = "us-central1"
#  version     = "~> 1.20.0"
}
```

