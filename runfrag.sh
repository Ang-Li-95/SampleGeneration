# For STOP request
#for m in 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600
#do
#  python frag.py -m ${m} -d 25 -c 0.2 -n 5000
#  python frag.py -m ${m} -d 25 -c 1 -n 5000
#  python frag.py -m ${m} -d 20 -c 5 -n 5000
#  python frag.py -m ${m} -d 20 -c 2 -n 5000
#  python frag.py -m ${m} -d 20 -c 0.2 -n 5000
#  python frag.py -m ${m} -d 15 -c 50 -n 5000
#  python frag.py -m ${m} -d 15 -c 20 -n 5000
#  python frag.py -m ${m} -d 15 -c 2 -n 5000
#  python frag.py -m ${m} -d 12 -c 500 -n 5000
#  python frag.py -m ${m} -d 12 -c 200 -n 5000
#  python frag.py -m ${m} -d 12 -c 20 -n 5000
#done

# For C1N2 request
#for m in 200 300 400 500 600 700 800 900
#do
#  for dm in 5 10 15 20 25
#  do
#    for ct in 0.2 2 20 200
#    do
#      python frag.py -t C1N2 -m ${m} -d ${dm} -c ${ct} -e run3
#    done
#  done
#done

# For C1N2 run2 supp request
for m in 700 800 900
do
  for dm in 5 10 15 20 25
  do
    for ct in 0.2 2 20 200
    do
      python frag.py -t C1N2 -m ${m} -d ${dm} -c ${ct} -e run2
    done
  done
done

for m in 200 300 400 500 600
do
  for dm in 5 10 
  do
    for ct in 0.2 2 20 200
    do
      python frag.py -t C1N2 -m ${m} -d ${dm} -c ${ct} -e run2
    done
  done
done

