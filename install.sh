#! /usr/bin/env bash

SRC_DIR=$(cd $(dirname $0) && pwd)
ROOT_UID=0

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
    SCHEMES_DIR="/usr/share/color-schemes"
    PLASMA_DIR="/usr/share/plasma/desktoptheme"
    KVANTUM_DIR="/usr/share/Kvantum"
else
    SCHEMES_DIR="$HOME/.local/share/color-schemes"
    PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
    KVANTUM_DIR="$HOME/.config/Kvantum"
fi

THEME_NAME=Onyx

[[ ! -d ${SCHEMES_DIR} ]] && mkdir -p ${SCHEMES_DIR}
[[ ! -d ${PLASMA_DIR} ]] && mkdir -p ${PLASMA_DIR}
[[ ! -d ${KVANTUM_DIR} ]] && mkdir -p ${KVANTUM_DIR}

install() {
    local name=${1}

    [[ -d ${PLASMA_DIR}/${name} ]] && rm -rf ${PLASMA_DIR}/${name}*
    [[ -f ${SCHEMES_DIR}/${name}.colors ]] && rm -rf ${SCHEMES_DIR}/${name}*.colors
    [[ -d ${KVANTUM_DIR}/${name} ]] && rm -rf ${KVANTUM_DIR}/${name}*

    cp -r ${SRC_DIR}/color-schemes/*.colors                                            ${SCHEMES_DIR}
    cp -r ${SRC_DIR}/kvantum/*                                                         ${KVANTUM_DIR}
    cp -r ${SRC_DIR}/plasma/desktoptheme/${name}                                       ${PLASMA_DIR}
    cp -r ${SRC_DIR}/plasma/desktoptheme/${name}-dark                                  ${PLASMA_DIR}
    cp -r ${SRC_DIR}/plasma/desktoptheme/icons                                         ${PLASMA_DIR}/${name}
    cp -r ${SRC_DIR}/plasma/desktoptheme/icons                                         ${PLASMA_DIR}/${name}-dark
    cp -r ${SRC_DIR}/color-schemes/${name}.colors                                      ${PLASMA_DIR}/${name}/colors
    cp -r ${SRC_DIR}/color-schemes/${name}Dark.colors                                  ${PLASMA_DIR}/${name}-dark/colors
}

echo "Installing '${THEME_NAME}' Plasma and Kvantum themes..."

install "${name:-${THEME_NAME}}"

echo "Install finished..."
