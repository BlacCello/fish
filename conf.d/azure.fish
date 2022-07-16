# List kubernetes cluster which match a pattern
function akl
    set pattern $argv[1]
    az aks list | jq "[.[] | \
                select((.name | test(\"$pattern\")) \
                or (.fqdn| test(\"$pattern\"))) \
                | { \"name\": .name, \"resourceGroup\": .resourceGroup, \"location\": .location, \"nodeCount\": [.agentPoolProfiles[].count] | add}]"
end

# Initialize kubectl with azure kubernetes cluster credentials
function akc
    set pattern $argv[1]
    set cluster_list (akl "$pattern")
    if [ "$cluster_list" != "[]" ]
        set name (echo "$cluster_list" | jq -r '.[0].name')
        set resourceGroup (echo "$cluster_list" | jq -r '.[0].resourceGroup')
        az aks get-credentials --name "$name" --resource-group "$resourceGroup"
    else
        echo "No cluster matching the pattern \"$pattern\" was found" >&2
        return 1
    end
end

# List subscriptions that match a pattern
function as
    set pattern $argv[1]
    az account list | jq -r "[.[] | select(.name | test(\"$pattern\"; \"i\")) | {\"name\": .name, \"id\": .id}]"
end

# Set the subscription that matches a pattern as default
function ass
    set pattern $argv[1]
    set subscription (as "$pattern" | jq -r ".[0].id")
    if [ "$subscription" != null ]
        az account set --subscription "$subscription"
        az account show | jq -r '[.name, .id] | @tsv'
        return 0
    else
        echo "No subscription found" >&2
        return 1
        fi
    end
end

