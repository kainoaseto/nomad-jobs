job "network-namespace-job" {
  datacenters = ["app"]

  group "echo-app" {
    network {
      mode = "bridge"
      port "proxy" {
        to = "80"
      }
    }

    task "task-a-proxy" {
      driver = "docker"

      config {
        image = "kainoaseto/http-echo:alpine"
        args = [
          "-listen",
          ":80",
          "-text",
          "proxying for task-b",
        ]
      }
    }

    task "task-b-app" {
      driver = "docker"

      config {
        image = "kainoaseto/http-echo:alpine"
        args = [
          "-listen",
          ":5678",
          "-text",
          "hello world",
        ]
      }
    }
  }
}