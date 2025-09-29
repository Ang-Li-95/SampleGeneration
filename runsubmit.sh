
#for m in 200 300 400 500 600
#do
#  for dm in 12 25
#  do
#    mm=$((m-dm))
#    for i in {1..10}
#    do
#      python submit.py -m ${m} -l ${mm} -c 2 -n 5000 -y 2018
#    done
#  done
#done

#for i in {1..100}
#do
#  #python submit.py -m 200 -l 191 -c 20 -n 5000 -y 2018
#  #python submit.py -m 200 -l 192 -c 20 -n 5000 -y 2018
#  #python submit.py -m 200 -l 193 -c 20 -n 5000 -y 2018
#  python submit.py -m 200 -l 195 -c 20 -n 5000 -y 2018
#done

for m in 400 600 800 1000 1200 1400 
do
  #for dm in 12 15 20 25
  for dm in 5 2
  do
    mm=$((m-dm))
    for ct in 0.2 2 20 200
    do
      for i in {1..200}
      do
        python submit.py -m ${m} -l ${mm} -c ${ct} -n 5000 -y 2018
        #python submit_C1N2.py -m ${m} -l ${mm} -c ${ct} -n 5000 -y 2018
      done
    done
  done
done

#for m in 400 
#do
#  #for dm in 12 15 20 25
#  for dm in 5 12
#  do
#    mm=$((m-dm))
#    for ct in 0.2 20
#    do
#      for i in {1..200}
#      do
#        #python submit.py -m ${m} -l ${mm} -c ${ct} -n 5000 -y 2018
#        python submit_C1N2.py -m ${m} -l ${mm} -c ${ct} -n 5000 -y 2018
#      done
#    done
#  done
#done
#for i in {1..100}
#do
#  python submit.py -m 600 -l 580 -c 2 -n 5000 -y 2018
#  python submit.py -m 600 -l 588 -c 200 -n 5000 -y 2018
#done

#python submit.py -m 200 -l 175 -c 0.2 -n 5000 -y 2018
#python submit.py -m 200 -l 188 -c 200 -n 5000 -y 2018
#python submit.py -m 600 -l 575 -c 0.2 -n 5000 -y 2018
#python submit.py -m 600 -l 588 -c 200 -n 5000 -y 2018

#for i in {1..100}
#do
#  python submit.py -m 600 -l 575 -c 0.2 -n 5000 -y 2017
#done
#
#for i in {1..100}
#do
#  python submit.py -m 600 -l 580 -c 2 -n 5000 -y 2017
#done

#for i in {1..100}
#do
#  python submit.py -m 600 -l 585 -c 20 -n 5000 -y 2018
#done

#for i in {1..100}
#do
#  python submit.py -m 600 -l 588 -c 200 -n 5000 -y 2017
#done
#
#for i in {1..100}
#do
#  python submit.py -m 1000 -l 975 -c 0.2 -n 5000 -y 2017
#done
#
#for i in {1..100}
#do
#  python submit.py -m 1000 -l 980 -c 2 -n 5000 -y 2017
#done
#
#for i in {1..100}
#do
#  python submit.py -m 1000 -l 985 -c 20 -n 5000 -y 2017
#done
#
#for i in {1..100}
#do
#  python submit.py -m 1000 -l 988 -c 200 -n 5000 -y 2017
#done
#
#for i in {1..100}
#do
#  python submit.py -m 1400 -l 1375 -c 0.2 -n 5000 -y 2017
#done
#
#for i in {1..100}
#do
#  python submit.py -m 1400 -l 1380 -c 2 -n 5000 -y 2017
#done
#
#for i in {1..100}
#do
#  python submit.py -m 1400 -l 1385 -c 20 -n 5000 -y 2017
#done
#
#for i in {1..100}
#do
#  python submit.py -m 1400 -l 1388 -c 200 -n 5000 -y 2017
#done

#for i in {1..50}
#do
#  python submit.py -m 1000 -l 988 -c 200 -n 5000
#  python submit.py -m 1000 -l 988 -c 2 -n 5000
#  python submit.py -m 1000 -l 988 -c 0.2 -n 5000
#  python submit.py -m 1000 -l 980 -c 200 -n 5000
#  python submit.py -m 1000 -l 980 -c 2 -n 5000
#  python submit.py -m 1000 -l 980 -c 0.2 -n 5000
#done
#for m in 200 400
#do
#  for dm in 10 15 20 25
#  do
#    mm=$((m-dm))
#    for ct in 0.2 2 20 200
#    do
#      echo python submit.py -m ${m} -l ${mm} -c ${ct} -n 5000
#      for i in {1..50}
#      do
#        python submit.py -m ${m} -l ${mm} -c ${ct} -n 5000
#      done
#    done
#  done
#done
