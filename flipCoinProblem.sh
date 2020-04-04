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
		if [[ (("$(random)" -eq 0)) && (("$(random)" -eq 0))]]
		then
			((flipCoin["(HEADS HEADS)"]++))
		elif [[ (("$(random)" -eq 0)) && (("$(random)" -eq 1))]]
		then
			((flipCoin["(HEADS TAILS)"]++))
		elif [[ (("$(random)" -eq 1)) && (("$(random)" -eq 0))]]
		then
			((flipCoin["(TAILS HEADS)"]++))
		else
			((flipCoin["(TAILS TAILS)"]++))
		fi
	done
	storePercentageInDictionary
}

#calculate and store percentage in dictionary
function storePercentageInDictionary()
{
   for val in "${!flipCoin[@]}"
   do
      flipCoin[$val]="`awk "BEGIN {print ${flipCoin[$val]}/$counter*100}"`"
   done
   printPercentage
}

#print percentage
function printPercentage
{
   for val in "${!flipCoin[@]}"
   do
      echo "${val} percentage is ${flipCoin[$val]}"
   done
}

flippingCoin $counter
