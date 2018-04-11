#!/bin/bash
echo "sets up your local hostname for træfik "

domain="traeffik.dev.wag.tools"

sed  "s/<insert-local-hostname>/$domain/g" example-files/example-docker-compose.yml > docker-compose.yml
sed  "s/<insert-local-hostname>/$domain/g" example-files/example-traefik.toml > traefik.toml

# find existing instances in the host file and save the line numbers
matches_in_hosts="$(grep -n $domain /etc/hosts | cut -f1 -d:)"
host_entry="127.0.0.1	$domain"

echo "Please enter your password if requested."

if [ ! -z "$matches_in_hosts" ]
then
    echo "Updating existing hosts entry."
    # iterate over the line numbers on which matches were found
    while read -r line_number; do
        # replace the text of each line with the desired host entry
        sudo sed -i '' "${line_number}s/.*/${host_entry}/" /etc/hosts
    done <<< "$matches_in_hosts"
else
    echo "Adding new hosts entry."
    echo "$host_entry" | sudo tee -a /etc/hosts > /dev/null
fi

echo "Now run docker-compose up and check http://$domain in your browser"
