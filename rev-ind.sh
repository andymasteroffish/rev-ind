            #!/bin/bash
            
            # reverse Indenter
            # total copyright Andy Wallace 2020
            # use this all you want BUT
            # if you steal this you're going to JAIL!
            # send compliments to andy@andymakes
            # do not send any criticism or advice.
            
            input=$1 
            output=$2
            
            space=" "
            
            max_tabs=0
            while IFS= read -r line
            do
        tab_count=0
        for i in $(seq 1 ${#line})
        do
    this_char=${line:i-1:1}
    if [ "$this_char" = "$space" ]
    then
tab_count=$((tab_count+1))
    else
break
    fi
        done
            
        #is this the new max?
        if [ $tab_count -gt $max_tabs ]
        then
    max_tabs=$tab_count
        fi
            done < "$input"
            
            echo "-- max tabs: $max_tabs --"
            
            
            #now that we have the max tabs we can cut them down
            while IFS= read -r line
            do
        tab_count=0
        for i in $(seq 1 ${#line})
        do
    this_char=${line:i-1:1}
    if [ "$this_char" = "$space" ]
    then
tab_count=$((tab_count+1))
    else
break
    fi
        done
            
        trim_line=${line:$tab_count}
            
        num_to_add_f=$(bc -l <<< "(1.0-($tab_count/$max_tabs))*$max_tabs")
        num_to_add_i=${num_to_add_f%.*}
            
        for (( c=1; c<=$num_to_add_i; c++ ))
        do  
     trim_line=" $trim_line"
        done
        echo "$trim_line" >> $output
            
            done < "$input"
            echo "enjoy your new, reverse indented file."  
