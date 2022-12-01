#!/bin/bash
killall -q prlcc
killall -q prlcp
prlcc & disown
prlcp & disown
