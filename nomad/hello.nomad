job "hello" {
  datacenters = ["dc1"]
  type        = "service"

  group "hello-group" {
    task "hello-task" {
      driver = "docker"

      config {
        image = "hello-devops"
        port_map {
          http = 8080
        }
      }

      resources {
        cpu    = 100   # MHz
        memory = 128   # MB
      }

      service {
        name = "hello-service"
        port = "http"
      }
    }
  }
}
