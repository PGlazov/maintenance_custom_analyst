#!/bin/bash
#cd ..
cp tcp-qa/checklist.yaml maintenance_custom_analyst/
find . -name *skip.list | grep released-heat-cicd >>temp.txt
NAME=''
NOCP='false'
while read LINE
    do 	    NAME=$LINE
	    NAME=$(echo $NAME | sed 's/.\/tcp-qa\/tcp_tests\/templates\/released-heat-cicd-//' | sed 's/\/tempest_skip.list//')
	    echo $NAME
	    echo $LINE
	    DIFF=$(diff $LINE  ./maintenance_custom_analyst/${NAME}-skip.list)
	    if [[ "$DIFF" != "" ]]
		 then cp $LINE ./maintenance_custom_analyst/${NAME}-skip.list
	    		 echo 'copied '${NAME}
			 	NOPC='false'
		 else echo 'no copied '${NAME}
	    fi
	    NAME=''
done < temp.txt
rm temp.txt
#cd maintenance_custom_analyst
if [ $NOCP == 'false' ];
then    
        cd maintenance_custom_analyst	
	git add --all
	git commit -m 'New changes in tcp-qa skip lists or checklist'
	git push origin master
	cd ..
fi
