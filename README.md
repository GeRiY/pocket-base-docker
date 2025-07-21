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

## Configuration

### Environment Variables

- `ADMIN_EMAIL`: Email for the admin user
- `ADMIN_PASS`: Password for the admin user

These credentials will be used to create a superuser when the container starts.

### Persistent Data

Data is stored in the `pb_data` directory, which is mounted as a volume in the container. This ensures your data persists between container restarts.

### Custom Hooks and Migrations

PocketBase provides powerful extensibility through hooks and migrations:

#### Hooks

Hooks are JavaScript files that allow you to extend PocketBase functionality by adding custom business logic. They can be used to:
- Validate data before it's saved
- Transform data after it's retrieved
- Trigger actions when certain events occur
- Implement custom authentication logic
- Add custom API endpoints

The hooks are automatically loaded from the `pb_hooks` directory.

#### Migrations

Migrations are JavaScript files that help you manage database schema changes over time. They allow you to:
- Create or modify collections
- Add, modify, or remove fields
- Set up indexes and relations
- Seed your database with initial data
- Version control your database schema

Migrations are stored in the `pb_migrations` directory and are executed in alphabetical order.

#### Setup in Docker

The Dockerfile is already configured to copy your hooks and migrations into the container:

```dockerfile
COPY ./pb_migrations /pb/pb_migrations
COPY ./pb_hooks /pb/pb_hooks
```

To use these features:

1. Create the appropriate directories in your project:

   Option A: Manually create the directories:
   ```
   mkdir -p pb_hooks pb_migrations
   ```

   Option B: Use the provided setup script which creates all necessary directories with proper permissions:
   ```
   ./setup.sh
   ```

2. Add your hook files to the `pb_hooks` directory. Example hook file (`pb_hooks/example.js`):
   ```javascript
   // This hook runs before a record is created
   onRecordBeforeCreateRequest((e) => {
       // Add a timestamp field
       e.record.set("created", new Date().toISOString());
   });
   ```

3. Add your migration files to the `pb_migrations` directory. Example migration file (`pb_migrations/1_create_tasks.js`):
   ```javascript
   migrate((db) => {
       const collection = new Collection({
           name: 'tasks',
           schema: [
               {
                   name: 'title',
                   type: 'text',
                   required: true,
               },
               {
                   name: 'completed',
                   type: 'bool',
                   default: false,
               }
           ],
       });

       return db.createCollection(collection);
   });
   ```

4. Rebuild and restart the container:
   ```
   docker-compose build
   docker-compose up -d
   ```

For more information on hooks and migrations, refer to the [PocketBase documentation](https://pocketbase.io/docs/).

## Updating PocketBase

To update to a newer version of PocketBase, change the `PB_VERSION` argument in the Dockerfile and rebuild the container:

```
docker-compose build --no-cache
docker-compose up -d
```

## License

This Docker setup is provided as-is. PocketBase itself is licensed under the MIT License.
