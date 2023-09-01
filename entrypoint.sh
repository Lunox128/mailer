#!/bin/bash
# Docker entrypoint script.

# Function to wait for Postgres to be ready
wait_for_postgres() {
  until pg_isready -h $PG_HOST -p $PG_PORT -U $PG_USER
  do
    echo "Waiting for database to start..."
    sleep 5
  done
}

# Wait for Postgres to be ready
wait_for_postgres

# Create, migrate, and seed database if it doesn't exist.
if [[ -z `psql -Atqc "\\list $PG_DATABASE"` ]]; then
  echo "Database $PG_DATABASE does not exist. Creating..."
  mix ecto.create
  mix ecto.migrate
  mix run priv/repo/seeds.exs
  echo "Database $PG_DATABASE created."
fi

# Start the Phoenix server
exec mix phx.server
