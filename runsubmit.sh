for m in 1000
do
  for dm in 12
  do
    mm=$((m-dm))
    #for ct in 0.2 20 
    for ct in 2 200 
    do
      for i in {1..100}
      do
        python submit.py -t STOP -m ${m} -l ${mm} -c ${ct} -n 5000 -y 2024
      done
    done
  done
done
