#!/bin/bash

#print the current date
date

#update using aptitude
aptitude update

#get the current os: e.g. xenial and append -security
TARGET_RELEASE=$(lsb_release -cs)-security

#run the upgrade
aptitude safe-upgrade -o Aptitude:Delete-Unused=false --assume-yes --target-release $TARGET_RELEASE
