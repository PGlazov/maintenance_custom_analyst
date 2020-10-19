#!/bin/bash
cp tcp-qa/checklist.yaml ./maintenance_custom_analyst/
find . -name *skip.list | grep released-heat-cicd >>temp.txt
NAME=''
while read LINE
    do 
	    if [[ $LINE == *"queens"* ]];
	    then NAME=${NAME}"queens"
	    fi
            if [[ $LINE == *"pike"* ]];            
            then NAME=${NAME}"pike"
	    fi
	    if [[ $LINE == *"contrail"* ]];
	    then NAME=${NAME}"-contrail"
	    else NAME=${NAME}"-sl"
            fi
	    echo ${NAME}
	    cp $LINE ./maintenance_custom_analyst/${NAME}-skip.list
	    NAME=''
done < temp.txt
rm temp.txt


