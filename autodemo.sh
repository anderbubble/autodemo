#!/bin/bash


# Copyright 2015 Tim Hockin
# Copyright 2015 Jonathon Anderson
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


readonly reset=$(tput sgr0)
readonly green=$(tput bold; tput setaf 2)
readonly yellow=$(tput bold; tput setaf 3)
readonly blue=$(tput bold; tput setaf 6)


function newl
{
    echo_off
    prompt
    echo
    tty_restore
}


function desc
{
    echo_off
    prompt
    type_desc "$blue# $@$reset"
    tty_restore
}


function run
{
    echo_off
    local command
    local r

    prompt
    command="$green$1$reset"
    type_run -n "${command}"
    if [ "$DEMO_AUTO_RUN" == 'true' ]
    then
        sleep $(get_run_delay)
    else
        wait_for_return
        #clear_stdin
    fi
    echo
    eval "$1"
    r=$?
    tty_restore
    return $r
}


function relative
{
    local arg
    for arg in "$@"
    do
        echo "$(realpath $(dirname $0))/$arg" | sed "s|$(realpath $(pwd))|.|"
    done
}


function prompt
{
    echo -n "$yellow\$ $reset"
}


function check_dependencies
{
    local dependency
    for dependency in "$@"
    do
        if [ -z "$(which "${dependency}")" ]
        then
            echo >&2 "dependency \`${dependency}' not found"
            exit 1
        fi
    done
}


function get_rate
{
    if [ -n "$DEMO_RATE" ]
    then
        echo $DEMO_RATE
    else
        echo 25
    fi
}


function get_desc_rate
{
    if [ -n "$DEMO_DESC_RATE" ]
    then
        echo $DEMO_DESC_RATE
    else
        echo $(get_rate)
    fi
}


function get_run_rate
{
    if [ -n "$DEMO_RUN_RATE" ]
    then
        echo $DEMO_RUN_RATE
    else
        echo $(get_rate)
    fi
}


function get_run_delay
{
    if [ -n "$DEMO_RUN_DELAY" ]
    then
        echo $DEMO_RUN_DELAY
    else
        echo 0.5
    fi
}


function type_run
{
    echo "$@" | pv --quiet --rate-limit $(get_run_rate)
}


function type_desc
{
    echo "$@" | pv --quiet --rate-limit $(get_desc_rate)
}


function wait_for_return
{
    read command
}


function clear_stdin
{
    read -d '' -t 1 -n 10000
}


function echo_off
{
    stty -echo
}


function tty_restore
{
    stty $tty_orig
}


function reset_trap
{
    echo "$reset"
}


function reset_exit_trap
{
    reset_trap
    tty_restore
    exit
}


function init
{
    trap reset_trap EXIT
    trap reset_exit_trap INT

    check_dependencies pv realpath dirname sed
    tty_orig=$(stty -g)
    echo >&2 "$tty_orig"
}


init
