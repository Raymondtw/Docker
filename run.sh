iamges=("image1" "image2")

function stop_dockercompose() {
    docker compose down
}

function start_dockercompose() {
    docker compose up -d
}

function is_image_exited() {

    res=false
    if test ! -z "$(docker images -q ${1})"; 
    then
        res=true
    fi

    echo $res
}


function clear() {

    stop_dockercompose

    for tag in ${iamges[@]}; do
        res=$(is_image_exited ${tag})
        if [ "$res" = true ];
        then
            docker image rm $tag
        fi
    done
}

function build() {
    clear
    docker compose build --no-cache
}

function auto_build() {

    for tag in ${iamges[@]}; do
        res=$(is_image_exited ${tag})
        if [ "$res" = false ];
        then
            build
        fi
    done

}

function run() {

    stop_dockercompose
    auto_build
    start_dockercompose
}

option="${1}" 
case ${option} in 
   -b) 
      build
      exit 1 # Command to come out of the program with status 1
      ;; 
   -c) 
      clear
      exit 1 # Command to come out of the program with status 1
      ;; 
   *) 
      run
      exit 1 # Command to come out of the program with status 1
      ;; 
esac 
