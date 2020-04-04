#!/bin/bash -x

#find random number
function random()
{
	echo $((RANDOM%2))
}

#find Heads or Tails in flip coin
function flipCoin()
{
	if [[ "$(random)" -eq 0 ]]
	then
		echo "HEADS"
	else
		echo "TAILS"
	fi
}

echo "Flip a coin"
flipCoin
