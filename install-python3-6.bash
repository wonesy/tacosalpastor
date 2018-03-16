function install_python3()
{
    py3version=$(python3 --version)
    if [[ "$py3version" != *"3.6"* ]]; then
        echo "Installing python3.6..."
        update_cmd="$admincmd $pkgman update"
        install_cmd="$admincmd $pkgman install python3"

        if [[ "$OSTYPE" == "linux"* ]]; then

            release=$(lsb_release -a | grep -i release)
            if [[ "$release" == *"16.04"* ]]; then
                sudo add-apt-repository ppa:deadsnakes/ppa
                sudo apt-get update
            fi
            install_cmd="${install_cmd}.6 python3.6-dev"
        fi

        eval "$update_cmd"
        eval "$install_cmd"
    fi
}

install_python3
