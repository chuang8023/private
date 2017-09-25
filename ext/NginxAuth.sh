#!/bin/bash

openssl passwd -crypt "$1" 2>&1
