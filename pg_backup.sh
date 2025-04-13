#!/bin/bash

# Set variables for database connection
PGUSER=your_username
PGDATABASE=your_database_name

# Set the path where you want to store the backup files
BACKUP_DIR=/path/to/backup/directory

# Get current date and time
datestamp=$(date +'%Y-%m-%d')
timestamp=$(date +'%H%M')

# Execute pg_dump command to dump the database
pg_dump -U "$PGUSER" -d "$PGDATABASE" > "$BACKUP_DIR/$PGDATABASE"_"$datestamp"_"$timestamp".sql
