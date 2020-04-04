#!/bin/bash -x

read -p "Number of time you flip coin " counter
declare -A flipCoin
win=0

#find random number
function random()
{
	echo $((RANDOM%2))
}

#find Singlet combination in coin
function singlet()
{
	for ((i=0;i<$1;i++))
	do
		if [[ "$(random)" -eq 0 ]]
		then
			((flipCoin["HEADS"]++))
		else
			((flipCoin["TAILS"]++))
		fi
	done
}

#find doublet combination in coin
function doublet()
{
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
}

#find triplet combination in coin
function triplet()
{
   for ((i=0;i<$1;i++))
   do
      if [[ (("$(random)" -eq 0)) && (("$(random)" -eq 0)) && (("$(random)" -eq 0))]]
      then
         ((flipCoin["(HEADS HEADS HEADS)"]++))
      elif [[ (("$(random)" -eq 0)) && (("$(random)" -eq 0)) && (("$(random)" -eq 1))]]
      then
         ((flipCoin["(HEADS HEADS TAILS)"]++))
      elif [[ (("$(random)" -eq 0)) && (("$(random)" -eq 1)) && (("$(random)" -eq 0))]]
      then
         ((flipCoin["(HEADS TAILS HEADS)"]++))
      elif [[ (("$(random)" -eq 0)) && (("$(random)" -eq 1)) && (("$(random)" -eq 1))]]
      then
         ((flipCoin["(HEADS TAILS TAILS)"]++))
      elif [[ (("$(random)" -eq 1)) && (("$(random)" -eq 0)) && (("$(random)" -eq 0))]]
      then
         ((flipCoin["(TAILS HEADS HEADS)"]++))
      elif [[ (("$(random)" -eq 1)) && (("$(random)" -eq 0)) && (("$(random)" -eq 1))]]
      then
         ((flipCoin["(TAILS HEADS TAILS)"]++))
      elif [[ (("$(random)" -eq 1)) && (("$(random)" -eq 1)) && (("$(random)" -eq 0))]]
      then
         ((flipCoin["(TAILS TAILS HEADS)"]++))
      else
         ((flipCoin["(TAILS TAILS TAILS)"]++))
      fi
   done
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

singlet $counter
doublet $counter
triplet $counter
calculatePercentage
createArray
printWinningCombination
