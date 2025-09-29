import uuid, os

cwd = os.getcwd()
with file('jobs.sh', 'w') as jf:
  uuid_ =  str(uuid.uuid4())
  run_dir = '/tmp/%s/'%uuid_
  cmd = 'mkdir -p %s; cd %s; '%(run_dir, run_dir)
  cmd += 'cp {0}/*.py .; cp -r {0}/templates .; cp -r {0}/Configuration-Generator .; cp -r {0}/SLHA .; '.format(cwd)
  for m in [600,1000,1400]:
    for dm in [12,15,20,25]:
      for ct in ['0.2','2','20','200']:
        ctnum = float(ct)
        cpcmd = "cp -r drivers/STOP_{}.0_{}.0_{:.1f}_5000_2018_CP/ {}/drivers/.;".format(m,m-dm,ctnum,cwd)
        newcmd = "{} python driver.py -m {} -l {} -c {} -n 5000 -y 2018; {} \n".format(cmd,m,m-dm,ct,cpcmd)
        jf.write(newcmd)
