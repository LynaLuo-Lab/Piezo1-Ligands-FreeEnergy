j=4
for i in `seq 0 1 127`
do  
    echo "$i  and check $i"
    #cp output_site/$i/job0.$i.log  output_sort/$i/job0.$i.log
    cp output_site/$i/*job${j}* output_sort/$i/
    mv output_site/$i/fep.job${j}.$i.rehistory  output_sort/$i/fep.job${j}.$i.history
done
  
