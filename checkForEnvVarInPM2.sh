#!/bin/bash

for i in {111..123}
do
    pm2 env $i | grep $1
done
