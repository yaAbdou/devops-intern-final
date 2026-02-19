# DevOps Intern Final Assessment

**Name:** Abdullahi Yakubu  
**Date:** 19 Feb 2026  

This project demonstrates a small DevOps pipeline using Linux scripting, GitHub, Docker, CI/CD, Nomad, and Loki monitoring.  

[![CI](https://github.com/yaAbdou/devops-intern-final/actions/workflows/ci.yml/badge.svg)](https://github.com/yaAbdou/devops-intern-final/actions/workflows/ci.yml)

---

## 1. Git & GitHub Setup

- Created a public repository: `devops-intern-final`
- Added a `README.md` (this file) and `hello.py`:

```python
# hello.py
print("Hello, DevOps!")

##2. Created folder scripts/ and scripts/sysinfo.sh

#!/bin/bash
echo "Current user: $(whoami)"
echo "Current date: $(date)"
echo "Disk usage:"
df -h

chmod +x scripts/sysinfo.sh


'''bash 
./scripts/sysinfo.sh

##3. Docker Basics
Created Dockerfile to containerize hello.py:

FROM python:3.11-slim
WORKDIR /app
COPY hello.py .
CMD ["python", "hello.py"]

Build a container

'''bash
docker build -t hello-devops .
docker run --rm hello-devops
# Output: Hello, DevOps!


##4. CI/CD with GitHub Actions

Created .github/workflows/ci.yml:

'''yaml
name: Python CI
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run hello.py
        run: python hello.py

#Every push automatically runs hello.py

CI status badge shown at top

##5. Job Deployment with Nomad

#Created nomad/hello.nomad:

job "hello" {
  datacenters = ["dc1"]
  type        = "service"

  group "hello-group" {
    task "hello-task" {
      driver = "docker"
      config {
        image = "hello-devops"
      }
      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}


#Start Nomad agent (Terminal 1):

'''bash
"/c/Users/Abdullahi Yakubu/Downloads/nomad_1.11.2_windows_amd64/nomad.exe" agent -dev


#Run the job (Terminal 2):

'''bash
"/c/Users/Abdullahi Yakubu/Downloads/nomad_1.11.2_windows_amd64/nomad.exe" job run nomad/hello.nomad
"/c/Users/Abdullahi Yakubu/Downloads/nomad_1.11.2_windows_amd64/nomad.exe" job status hello

##6. Monitoring with Loki

#Run Loki with Docker:

'''bash
docker run -d --name loki -p 3100:3100 grafana/loki:latest

#Run container to generate logs:

docker run --rm hello-devops
# Output: Hello, DevOps

#Push log to Loki manually:
'''bash 
curl -X POST http://localhost:3100/loki/api/v1/push \
  -H "Content-Type: application/json" \
  -d '{"streams":[{"stream":{"job":"hello"},"values":[["'"$(date +%s%N)"'","Hello, DevOps"]]}]}'

#Query logs (last 5 minutes):

'''bash
END=$(date +%s%N)
START=$(($(date +%s%N) - 300000000000))
curl -G http://localhost:3100/loki/api/v1/query_range \
  --data-urlencode "query={job=\"hello\"}" \
  --data-urlencode "start=$START" \
  --data-urlencode "end=$END"

