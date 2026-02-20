# Cloud-Native DevOps Platform

This repository contains a CI-driven infrastructure platform that provisions cloud infrastructure, configures servers, and deploys a containerized application using Infrastructure as Code.

The architecture allows us to reliably rebuild the environment, apply changes repeatedly without side effects, and maintain consistency even when the infrastructure changes.

## Architecture Overview

The platform is built in clearly separated layers:


## Terraform – Infrastructure Layer

- Provisions EC2 instance

- Manages security group rules

- Stores remote state in S3

- Detects and reconciles infrastructure drift


## Ansible – Configuration Layer

- Installs and configures Docker

- Ensures Docker service state

- Deploys and manages the application container

- Enforces idempotent configuration


## Docker – Application Runtime Layer

- Packages the application into an immutable image

- Ensures consistent runtime behavior

- Runs the containerized service


## GitHub Actions – Orchestration Layer

- Executes Terraform and Ansible

- Injects secrets securely

- Automates end to end deployment


## State Management

- Terraform state is stored remotely in AWS S3.

- Both CI and local environments reference the same backend, ensuring consistent visibility of infrastructure state and preventing duplication.


## Drift Recovery Model

The platform automatically reconciles common operational drift:

- Manual EC2 deletion = Terraform recreates the instance

- Security group modification = Terraform restores declared rules

- Docker service stopped = Ansible restarts the service

- Container removed = Ansible recreates the container

- Each layer enforces its declared state on every CI run.


## Deployment Flow

- Code push triggers GitHub Actions

- Terraform initializes backend and applies infrastructure

- EC2 public IP is retrieved from outputs

- Ansible configures the server

- Docker container is deployed

- Application becomes accessible


## Design Principles

- Infrastructure as Code

- Configuration as Code

- Idempotent operations

- Remote state management

- Separation of concerns

- Reproducible deployments

## License

This project is licensed under the MIT License. See the LICENSE file for details
