#!/bin/bash -x

read -p "Number of time you flip coin " counter
declare -A flipCoin
win=0

#flipping a coin
function flippingCoin()
{
   for ((i=0;i<$counter;++i))
   do
      coinFaceStoreInDictionary $1
   done
}

#find random number
function random()
{
	echo $((RANDOM%2))
}

#store in a dictionary
function coinFaceStoreInDictionary()
{
   for ((j=0;j<$1;++j))
   do
      if [[ "$(random)" -eq 0 ]]
      then
         face+='HEADS '
      else
         face+='TAILS '
      fi
   done
   ((flipCoin[$face]++))
   face=''
}

#calculate percentage & store in dictionary
function calculatePercentage()
{
   for val in "${!flipCoin[@]}"
   do
      flipCoin[$val]=$((flipCoin[$val]*100/counter))
   done
}

#create array of dictionary
function createArray()
{
   count=0
   for val in "${flipCoin[@]}"
   do
      resultArray[((count++))]=$val
   done
   sortDescending "${resultArray[@]}"
}

#sort the array to get highest percentage
function sortDescending()
{
   array=("${@}")
   for ((i=0;i<$((${#array[@]}-1));i++))
   do
      for ((j=$((i+1));j<${#array[@]};j++))
      do
         if [[ ${array[$i]} -le ${array[$j]} ]]
         then
            temp=${array[$i]}
            array[$i]=${array[$j]}
            array[$j]=$temp
         fi
      done
   done
   win=${array[0]}
}

#print the winnig Combination
function printWinningCombination
{
   for val in "${!flipCoin[@]}"
   do
      if [[ (($win -eq ${flipCoin[$val]})) ]]
      then
         echo "${val} is winning combination ${flipCoin[$val]}"
      fi
   done
}
SINGLET=1
DOUBLET=2
TRIPLET=3
flippingCoin $SINGLET
flippingCoin $DOUBLET
flippingCoin $TRIPLET
calculatePercentage
createArray
printWinningCombination

