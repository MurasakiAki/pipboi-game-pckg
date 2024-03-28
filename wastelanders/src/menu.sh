#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NONE='\033[0m'

function echo_menu() {
    echo -e "=============================================="
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|--------------------------------------------|"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "|                                            |"
    echo -e "| 1) ${RED}ATTACK${NONE}   3) ${BLUE}DEFEND${NONE}                      |"
    echo -e "| 2) ${GREEN}HEAL${NONE}     4) ${YELLOW}RUN${NONE}                         |"
    echo -e "=============================================="

}
