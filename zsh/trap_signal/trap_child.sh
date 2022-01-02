#!/usr/bin/env zsh

function foo() {
    echo 'Trapped CHLD signal'
}

trap 'foo' CHLD

(sleep 2) &
(sleep 4) &
(sleep 6) &

echo 'Waiting for children'
wait
echo 'Done'

