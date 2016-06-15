#!/bin/bash

sudo tail -n 1000 /var/log/auth.log | grep sshd | grep Accept

echo
exit
