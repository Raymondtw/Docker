function create_network (){

    docker network create \
        --driver=bridge \
        --subnet=172.28.0.0/16 \
        --ip-range=172.28.5.0/24 \
        --gateway=172.28.5.254 \
        $1
}

function is_network_exited() {

    if [ ! "$(docker network ls | grep $1)" ]
    then
        echo "false"
    
    else
        echo "true"
    fi
}

function main () {

    name="nginx_network"
    if [ $( is_network_exited $name ) == "false" ]
    then
        echo "run create ${name}"
        create_network $name
        echo "finished"
    else
        echo "network ${name} is exited"
    fi
}

main
