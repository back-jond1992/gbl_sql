#!/bin/bash
for file in "./database"/*.sql; do
    psql -f "${file}" > ${file%.sql}.txt
done