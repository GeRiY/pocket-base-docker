#!/bin/sh

# futtatás előtt létrehozzuk az admin-t, csak ha nincs
/pb/pocketbase superuser upsert "$ADMIN_EMAIL" "$ADMIN_PASS"

# továbbadjuk az eredeti parancsot
exec /pb/pocketbase serve --http=0.0.0.0:8080