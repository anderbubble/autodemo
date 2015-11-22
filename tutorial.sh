#!/bin/bash


# Original Copyright 2015 Tim Hockin
# Additions Copyright 2015 Jonathon Anderson
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


. $(dirname ${BASH_SOURCE})/autodemo.sh


DEMO_AUTO_RUN='true'


desc "autodemo tutorial"
newl

desc "Using autodemo, you can script your live demos ahead of time."
desc "You'll have less to type and less to worry about."
newl

desc "Functions"
desc
desc "* \`desc' prints comments, like these."
newl
run "desc 'This is a comment.'"
newl

desc "* \`run' runs commands. We used it to run the \`desc' example"
desc "  above. Commands are actually run, not simulated."
run "run ls"
newl

desc "* \`newl' moves to a new line, similar to how one might hit"
desc "  \`return' to create whitespace in an interactive shell."
run "newl"
desc "That was a newline."
newl

desc "Using these functions you can write scripts that execute"
desc "interacitvely, as though you were typing them yourself."
newl

desc "Environment variables"
newl

desc "* DEMO_AUTO_RUN skips waiting for \`return' during command"
desc "  execution. It defaults to \`false', but has been set to"
desc "  \`true'"

desc "  for this tutorial."
newl
run "DEMO_AUTO_RUN=false"
newl
desc "Now commands will wait for \`return' before executing."
run hostname
run "DEMO_AUTO_RUN=true"
newl

desc "* DEMO_RUN_DELAY controls the delay before running an AUTO_RUN"
desc "  command."
newl
run "DEMO_RUN_DELAY=5"
run date
run "unset DEMO_RUN_DELAY"
newl

desc "* DEMO_RATE controls the rate at which commands and comments are"
desc "  printed."
newl
run "DEMO_RATE=50"
desc "Now everything is printed at twice the default rate."
newl

desc "* DEMO_DESC_RATE controls the rate at which comments are"
desc "  printed. It can be used to override DEMO_RATE."
newl
run "DEMO_DESC_RATE=25"
desc "Now comments are printed at the original rate; but commands will"
desc "continue to print at DEMO_RATE."
newl
run "df -a -h"
newl

desc "* DEMO_RUN_RATE controls the rate at which commands are"
desc "  printed. It also overrides DEMO_RATE."
newl
run "DEMO_RUN_RATE=5"
run pwd
newl

desc "That's everything you need to know to use autodemo. You can"
desc "find the source for this tutorial in \`$0'."
