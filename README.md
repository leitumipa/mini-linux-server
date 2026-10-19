# Mini Linux Server Environment

## Overview

A beginner-friendly Linux administration portfolio project
built using Ubuntu on WSL2, Bash, Python, and systemd.

The project demonstrates how to run and monitor a small HTTP
application while practicing Linux administration.

## Architecture

Windows Host
    |
    v
WSL2
    |
    v
Ubuntu Linux
    |
    v
systemd
    |
    v
Python HTTP Application
    |
    v
127.0.0.1:8080

## Features

- Dedicated Linux service account and group
- Linux directory ownership and permission management
- Python HTTP application with a health endpoint
- systemd service management
- Process and resource monitoring
- Network socket inspection
- Application log analysis
- Timestamped backup automation
- Bash health-check script
- Troubleshooting documentation

## Health Check

Run:

    curl -i http://127.0.0.1:8080/health

Expected result when the application is healthy: HTTP 200.

## Service Management

    systemctl status mini-linux-server.service --no-pager
    systemctl is-active mini-linux-server.service

## Process Monitoring

    pgrep -a -u appsvc -f server.py
    free -h
    sudo ss -lntp

## Automation

    ./scripts/health_check.sh
    ./scripts/backup.sh

The backup script may request sudo authentication to read the
application directories under /srv/mini-linux-server.

## Project Structure

- app/: application source code
- config/: example systemd unit
- scripts/: Bash automation
- docs/: learning and troubleshooting reports
- logs/: local generated logs
- backups/: local generated backup archives

## Documentation

See the docs/ directory for environment, permission, resource
monitoring, networking, logging, backup, automation, and
troubleshooting reports.

## Safety Notes

- The HTTP application listens on 127.0.0.1 for local testing.
- The health-check script does not restart the service.
- Backup archives are created separately from active data.
- Diagnostic commands should be used before changing the system.

## Limitations

This is a local learning environment, not a production-ready
server. It does not implement production authentication, TLS,
high availability, centralized monitoring, or a complete
backup retention policy.

WSL2 service startup depends on the Ubuntu environment and
its systemd configuration being started.

## Learning Outcomes

This project practices Linux permissions, service management,
process monitoring, networking, log analysis, backup,
Bash automation, and evidence-based troubleshooting.
