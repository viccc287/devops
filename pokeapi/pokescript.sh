#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: $0 <nombre_pokemon>"
    exit 1
fi

POKEMON="$1"
URL="https://pokeapi.co/api/v2/pokemon/$POKEMON"
CSV_FILE="pokemon_data.csv"

data=$(curl -s "$URL")

if [ -z "$data" ] || echo "$data" | jq -e .id >/dev/null 2>&1; then
    ID=$(echo "$data" | jq '.id')
    NAME=$(echo "$data" | jq -r '.name')
    WEIGHT=$(echo "$data" | jq '.weight')
    HEIGHT=$(echo "$data" | jq '.height')
    ORDER=$(echo "$data" | jq '.order')
    
    echo "$NAME (No. $ID)"
    echo "Id = $ID"
    echo "Weight = $WEIGHT"
    echo "Height = $HEIGHT"
    echo "Order = $ORDER"
    
    if [ ! -f "$CSV_FILE" ]; then
        echo "id,name,weight,height,order" > "$CSV_FILE"
    fi
    
    echo "$ID,$NAME,$WEIGHT,$HEIGHT,$ORDER" >> "$CSV_FILE"
else
    echo "Error: Pokémon no encontrado."
    exit 1
fi