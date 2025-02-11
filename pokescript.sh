#!/bin/bash

# Verificar si se proporcionó un parámetro
if [ $# -eq 0 ]; then
    echo "Error: Debes proporcionar el nombre de un Pokémon."
    exit 1
fi

POKEMON="$1"
URL="https://pokeapi.co/api/v2/pokemon/${POKEMON}"

data=$(curl -s -f "$URL")

if [ $? -ne 0 ]; then
    echo "Error: Pokémon '${POKEMON}' no encontrado."
    exit 1
fi

id=$(echo "$data" | jq '.id')
name_lower=$(echo "$data" | jq -r '.name')
name_capitalized=$(echo "$data" | jq -r '.name | sub("^."; .[0:1] | ascii_upcase)')
weight=$(echo "$data" | jq '.weight')
height=$(echo "$data" | jq '.height')
order=$(echo "$data" | jq '.order')

echo "${name_capitalized} (No. ${id})"
echo "Id = ${id}"
echo "Weight = ${weight}"
echo "Height = ${height}"
echo "Order = ${order}"

CSV_FILE="pokemon.csv"

if [ ! -f "$CSV_FILE" ]; then
    echo "id,name,weight,height,order" > "$CSV_FILE"
fi

echo "${id},${name_lower},${weight},${height},${order}" >> "$CSV_FILE"
