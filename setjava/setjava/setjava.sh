#!/bin/bash

function setjava-optional () {
        #wsimport
        if test -f "$1/bin/$2"; then
            sudo update-alternatives --install /usr/bin/$2 $2 $1/bin/$2 1000
            sudo update-alternatives  --set $2 $1/bin/$2
       else
            sudo update-alternatives  --remove $2
        fi
}

function setjava () {
    if [ "$(sudo id -u)" -eq 0 ]; then
        sudo rm -f /opt/java/JAVA_HOME
        sudo ln -s $1 /opt/java/JAVA_HOME

        #java and Javac
        sudo update-alternatives --install /usr/bin/java java $1/bin/java 1000
        sudo update-alternatives --install /usr/bin/javac javac $1/bin/javac 1000
        sudo update-alternatives  --set java $1/bin/java
        sudo update-alternatives  --set javac $1/bin/javac
        
        setjava-optional $1 keytool
        setjava-optional $1 wsimport
        setjava-optional $1 wsgen
        setjava-optional $1 pack200
        setjava-optional $1 unpack200
    fi
}

setjava $1
