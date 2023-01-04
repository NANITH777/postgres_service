#!/bin/bash

dir="/home/nanith/odev/test"


database="mydata"
table="changes"


inotifywait -m -e create,delete,modify --format '%w%f %e' "$dir" | while read file event; do
  
  if [ "$event" = "DELETE" ]; then
    psql -c "UPDATE $table SET deleted_date=CURRENT_TIMESTAMP WHERE filename='$file'" $database
  
  else
    psql -c "INSERT INTO $table (date, filename) VALUES (CURRENT_TIMESTAMP, '$file')" $database
  fi
done

