#!/bin/bash
# rsync -avhzP "${1}" "${2}"
rsync -S -vrltH -pgo --stats -D --numeric-ids --delete --partial "${1}" "${2}"
