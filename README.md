[![CI](https://github.com/yaAbdou/devops-intern-final/actions/workflows/ci.yml/badge.svg)](https://github.com/yaAbdou/devops-intern-final/actions/workflows/ci.yml)

# devops-intern-final
# DevOps Intern Final Assessment

Name: Yakubu Abdullahi YUsuf
Date: 2026-02-19  

## Project Description
This project demonstrates a DevOps workflow using Linux, GitHub, Docker, CI/CD, Nomad, and monitoring tools.  
The workflow includes building, deploying, and monitoring a sample application.

## Docker Instructions

### Build the Docker image
```bash
docker build -t hello-devops .

## Step 5: Deploy with Nomad

To run the Docker container as a Nomad job:

1. Make sure Nomad agent is running (dev mode is fine):

```bash
nomad agent -dev
