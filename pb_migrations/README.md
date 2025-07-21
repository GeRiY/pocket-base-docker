# PocketBase Migrations

This directory contains JavaScript migrations for PocketBase. Migrations are used to manage database schema changes in a controlled and versioned manner.

## Migration Files

Migration files follow this naming convention:
```
{timestamp}_{descriptive_name}.js
```

For example:
- `1687801090_create_clients_collection.js`

The timestamp ensures migrations are applied in the correct order.

## Migration Structure

Each migration file should export a `migrate` function with two parameters:
1. The "up" migration function that applies changes
2. The "down" migration function that reverts changes

Example:
```
migrate((app) => {
    // Up migration - apply changes
    // Create or modify collections, fields, indexes, etc.
    let collection = new Collection({
        // Collection configuration
    });
    app.save(collection);
}, (app) => {
    // Down migration - revert changes
    let collection = app.findCollectionByNameOrId("collection_name");
    app.delete(collection);
});
```

## Collection Configuration

When creating a collection, you can configure various properties:

```
let collection = new Collection({
    type: "auth",              // "auth" or "base"
    name: "collection_name",   // Name of the collection
    listRule: "...",           // Rule for listing records
    viewRule: "...",           // Rule for viewing records
    createRule: "...",         // Rule for creating records
    updateRule: "...",         // Rule for updating records
    deleteRule: "...",         // Rule for deleting records
    fields: [
        // Field definitions
    ],
    indexes: [
        // Index definitions
    ],
});
```

### Field Types

Fields can be of various types:

```
{
    "type": "text",      // Text field
    "name": "field_name",
    "required": true,    // Whether the field is required
    "max": 100          // Maximum length
}

{
    "type": "url",       // URL field
    "name": "field_name",
    "presentable": true  // Whether the field is presentable
}

// Other field types include:
// - "number"
// - "email"
// - "select"
// - "relation"
// - "date"
// - "file"
// - "bool"
// - "json"
```

### Authentication Options

For auth collections, you can configure authentication options:

```
{
    "passwordAuth": {
        "enabled": false    // Enable/disable password authentication
    },
    "otp": {
        "enabled": true     // Enable/disable one-time password authentication
    }
}
```

### Indexes

You can define indexes to improve query performance:

```
indexes: [
    "CREATE INDEX idx_name ON collection_name (field_name)"
]
```

## Creating Migrations

To create a new migration:

1. Create a new file with the current timestamp and a descriptive name
2. Implement the up and down migration functions
3. Test the migration by running PocketBase

## Documentation

For more information about PocketBase migrations, see the [official documentation](https://pocketbase.io/docs/js-migrations/).
