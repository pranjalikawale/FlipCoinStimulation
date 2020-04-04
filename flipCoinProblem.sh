#!/bin/bash -x

read -p "Number of time you flip coin " counter
declare -A flipCoin

#find random number
function random()
{
	echo $((RANDOM%2))
}

#find Heads or Tails in flip coin
function flippingCoin()
{
	echo "Flip a coin"
	for ((i=0;i<$1;i++))
	do
		if [[ "$(random)" -eq 0 ]]
		then
			((flipCoin["HEADS"]++))
		else
			((flipCoin["TAILS"]++))
		fi
	done
	calculatePercentage
}

#calculate percentage
function calculatePercentage()
{
	for val in "${!flipCoin[@]}"
	do
		echo "${val} percentage is " `awk "BEGIN {print ${flipCoin[$val]}/$counter*100}"`
	done
}

flippingCoin $counter
