#!/bin/bash

if ! type git; then
    sudo apt-get install git -y
fi

release="$(lsb_release --release | awk '{print $2}')"

if [ "$release" == "14.10" ] || [ "$release" == "15.04" ] || [ "$release" == "15.10" ]; then
    release="14.04"
elif [ "$release" == "16.10" ] || [ "$release" == "17.04" ]; then
    release="16.04"
fi

git clone https://github.com/wrvenkat/bnr.git && cd bnr && chmod +x bnr &&\
    git clone https://github.com/wrvenkat/bash_helper_scripts.git && cd bash_helper_scripts && chmod +x *.sh && cd .. &&\
    git clone https://github.com/wrvenkat/bnr-conf.git &&\
    git clone https://github.com/wrvenkat/config_scripts.git && cd config_scripts && git checkout "$release" && chmod +x *.sh && cd ..
