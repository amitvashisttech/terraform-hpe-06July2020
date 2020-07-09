provider kubernetes {
version = "~> 1.8"
  # leave blank to pickup config from kubectl config of local system
}

resource "kubernetes_deployment" "myapp" {
  metadata {
    name = "myapp"
  }

  spec {
    replicas = 3

    selector {
     match_labels = {
      app = "myapp"
    }
   }
   
    template {
      metadata {
        labels {
          app = "myapp"
        }
      }

      spec {
        container {
          image = "amitvashist7/get-started:part2"
          name  = "app"

          resources {
            requests {
              memory = "256Mi"
              cpu    = "100m"
            }

            limits {
              memory = "1Gi"
              cpu    = "500m"
            }
          }

          readiness_probe {
            http_get {
              path = "/"
              port = "80"
            }

            initial_delay_seconds = 10
            period_seconds        = 10
          }

          liveness_probe {
            http_get {
              path = "/"
              port = "80"
            }

            initial_delay_seconds = 120
            period_seconds        = 15
          }

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name = "terraform-myapp-example"
  }

  spec {
    selector {
      app = "myapp"
    }

    session_affinity = "ClientIP"

    port {
      port = 80
    }

    type = "LoadBalancer"
  }
}

output "lb_ip" {
  value = "${kubernetes_service.example.load_balancer_ingress.0.ip}"
}
