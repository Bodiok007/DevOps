#!/usr/bin/bash

distribution=""

define_distribution() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        distribution="$ID"
    else
        echo "Cannot determine the distribution."
    fi
}

check_if_distribution_empty() {
    if [[ -z $distribution ]]; then
        echo "Distribution is empty, exiting."
        exit 1
    else
        echo "Current distribution: $distribution"
    fi
}

process_input() {
    while [[ $# -ne 0 ]]; 
    do
        install_or_update $1
        shift
    done
}

install_or_update() {
    package_name="$1"

    if [ -z "$package_name" ]; then
        echo "Please provide a package name as an argument."
        return
    fi

    case $distribution in
        centos)
            install_or_update_centos $package_name
            ;;
        ubuntu)
            install_or_update_ubuntu $package_name
            ;;
        *)
            echo "Installation for $distribution is not supported"
            exit 1
            ;;
    esac
}

install_or_update_centos() {
    package_name="$1"

    if rpm -q "$package_name"; then
        echo "$package_name is already installed. Updating..."
        sudo yum check-update
        sudo yum update "$package_name"
    else
        echo "$package_name is not installed. Installing..."
        sudo yum check-update
        sudo yum install "$package_name" -y
    fi
}

install_or_update_ubuntu() {
    package_name="$1"

    # Check if the package is installed, if no - install
    if dpkg -l | grep -q "ii  $package_name"; then
        echo "$package_name is already installed. Updating..."
        sudo apt-get update
        sudo apt-get install --only-upgrade "$package_name" -y
    else
        echo "$package_name is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install "$package_name" -y
    fi
}

define_distribution
check_if_distribution_empty
process_input "$@"
