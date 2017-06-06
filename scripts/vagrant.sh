#! /bin/bash -x

useradd vagrant -u 1001 -U

su - vagrant -c "
mkdir ~/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+MqIxbaMiUGQUcV9AZwpc211R8yVdDY0Ho4nD3vQ/ZUE0En8/rstBYDVJICvoSCE6D55Xl87bfhPu63gDdyC0apTc0NtvbLrCvjLHWOR0VhK/+Why9G/1XR/3BDvnjKnzQ4HYlMwx/LMfzfPsGfV2abReWD5wfJD40JgHczstZRXgf32BCIH3WH6ZZEDR1AtclqfWXCiRj5lxIkZHBTu9fAQc7cWRceaNxb1M1gMGQw7uWyUhiLq+h1hxFvZyE06U+ucJa9nVaDBr0R6s1SBFxlp8bwNMvSh9js5dagEXyV2MPEjgvv+LGZ75Rp8Fs/Bpy6x/zS8YiISTVxr5EYVN' > ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*
"

echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
