# PocketBase Docker Setup

This repository contains a Docker setup for [PocketBase](https://pocketbase.io/), a lightweight open source backend consisting of embedded database (SQLite) with realtime subscriptions, built-in auth management, convenient dashboard UI and simple REST-ish API.

## Project Structure

- `Dockerfile`: Defines the container image
- `docker-compose.yml`: Configures the service
- `entrypoint.sh`: Script that runs when the container starts
- `setup.sh`: Script to create required directories with proper permissions
- `.env-example`: Template for environment variables
- `pb_data/`: Directory for persistent data (gitignored)
- `pb_hooks/`: Directory for hooks (gitignored)
- `pb_migrations/`: Directory for migrations (gitignored)

## Requirements

- Docker
- Docker Compose

## Quick Start

1. Clone this repository
2. Create a `.env` file based on the `.env-example` template:
   ```
   cp .env-example .env
   ```
3. Edit the `.env` file and set your admin credentials:
   ```
   ADMIN_EMAIL=your-email@example.com
   ADMIN_PASS=your-secure-password
   ```
4. Run the setup script to create required directories with proper permissions:
   ```
   ./setup.sh
   ```
5. Start the container:
   ```
   docker-compose up -d
   ```
6. Access PocketBase at http://localhost:8080/_/
7. REST API: http://localhost:8080/api/

## Configuration

### Environment Variables

- `ADMIN_EMAIL`: Email for the admin user
- `ADMIN_PASS`: Password for the admin user

These credentials will be used to create a superuser when the container starts.

### Persistent Data

Data is stored in the `pb_data` directory, which is mounted as a volume in the container. This ensures your data persists between container restarts.