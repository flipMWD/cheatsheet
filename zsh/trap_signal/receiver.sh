#!/usr/bin/env zsh

running=1

# also trap 'action' sigNAL, NAL from kill -l
TRAPINT() {
    running=0
}

while [[ $running != 0 ]]
do
    read '?Type: ' word
    echo "$word"
done

