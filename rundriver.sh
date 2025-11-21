#for m in 200 300 400 500 600
#do
#  for dm in 12 25
#  do
#    mm=$((m-dm))
#    python driver.py -m ${m} -l ${mm} -c 2 -n 5000 -y 2018
#  done
#done

#python driver.py -m 600 -l 580 -c 2 -n 5000 -y 2018
#python driver.py -m 600 -l 588 -c 200 -n 5000 -y 2018
#python driver.py -m 600 -l 575 -c 0.2 -n 5000 -y 2017
#python driver.py -m 600 -l 580 -c 2 -n 5000 -y 2017
#python driver.py -m 600 -l 585 -c 20 -n 5000 -y 2017
#python driver.py -m 600 -l 588 -c 200 -n 5000 -y 2017
#python driver.py -m 1000 -l 975 -c 0.2 -n 5000 -y 2017
#python driver.py -m 1000 -l 980 -c 2 -n 5000 -y 2017
#python driver.py -m 1000 -l 985 -c 20 -n 5000 -y 2017
#python driver.py -m 1000 -l 988 -c 200 -n 5000 -y 2017
#python driver.py -m 1400 -l 1375 -c 0.2 -n 5000 -y 2017
#python driver.py -m 1400 -l 1380 -c 2 -n 5000 -y 2017
#python driver.py -m 1400 -l 1385 -c 20 -n 5000 -y 2017
#python driver.py -m 1400 -l 1388 -c 200 -n 5000 -y 2017

#python driver.py -m 1000 -l 988 -c 200 -n 5000
#python driver.py -m 1000 -l 988 -c 2 -n 5000
#python driver.py -m 1000 -l 988 -c 0.2 -n 5000
#python driver.py -m 1000 -l 980 -c 200 -n 5000
#python driver.py -m 1000 -l 980 -c 2 -n 5000
#python driver.py -m 1000 -l 980 -c 0.2 -n 5000
#python driver.py -m 600 -l 585 -c 20 -n 5000

#python driver_C1N2.py -m 200 -l 195 -c 20 -n 5000
#python driver_C1N2.py -m 200 -l 190 -c 20 -n 5000
#python driver_C1N2.py -m 200 -l 191 -c 20 -n 5000
#python driver_C1N2.py -m 200 -l 192 -c 20 -n 5000
#python driver_C1N2.py -m 200 -l 193 -c 20 -n 5000
#python driver_C1N2.py -m 200 -l 194 -c 20 -n 5000

#for m in 600 1000
#do
#  for dm in 5
#  do
#    mm=$((m-dm))
#    for ct in 0.2 2 20 200
#    do
#      echo python driver.py -m ${m} -l ${mm} -c ${ct} -n 5000 -y 2018
#      python driver.py -m ${m} -l ${mm} -c ${ct} -n 5000 -y 2018
#    done
#  done
#done

#for m in 400
#do
#  for dm in 12 
#  do
#    mm=$((m-dm))
#    #for ct in 0.2 2 20 200 
#    for ct in 2 200 
#    do
#      echo python driver.py -t C1N2 -m ${m} -l ${mm} -c ${ct} -n 5000 -y 2024
#      python driver.py -t C1N2 -m ${m} -l ${mm} -c ${ct} -n 5000 -y 2024
#    done
#  done
#done

for m in 1000
do
  for dm in 12
  do
    mm=$((m-dm))
    for ct in 2 200 
    do
      echo python driver.py -t STOP -m ${m} -l ${mm} -c ${ct} -n 5000 -y 2024
      python driver.py -t STOP -m ${m} -l ${mm} -c ${ct} -n 5000 -y 2024
    done
  done
done
