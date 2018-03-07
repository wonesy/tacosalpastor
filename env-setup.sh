echo "Exporting variables"

for i in $(cat secrets.env); do
  export $i
  if [[ $1 == "-v" ]]; then
    echo "exported $i"
  fi
done

$(source venv/bin/activate)

echo "Environment activated"