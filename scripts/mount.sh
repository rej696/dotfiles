#!/bin/bash
mount -o "uid=${USER},gid=${USER},users" $1 $2
