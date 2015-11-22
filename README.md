# autodemo

Automated live demos, based on the framework developed by Tim Hockin
for [kube-demos](https://github.com/thockin/kube-demos). Run
`tutorial.sh` for an example.


## Dependencies

* [pv](http://www.ivarch.com/programs/pv.shtml)


## Functions

* desc - print comments
* run - run commands
* newl - insert a newline


## Environment variables

* DEMO_AUTO_RUN - run commands without waiting (false|true)
* DEMO_RUN_DELAY - wait before automatically running commands
  (seconds)
* DEMO_RATE - output print rate (bytes-per-second)
* DEMO_DESC_RATE - comment output print rate (bytes-per-second)
* DEMO_RUN_RATE - run command output print rate (bytes-per-second)
