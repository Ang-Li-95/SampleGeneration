import os, sys, glob
import getopt, datetime
import shutil

########## options

opts, args = getopt.getopt(sys.argv[1:], "t:m:l:c:n:y:", ["model=", "llpmass=", "lspmass=", "ctau=", "nevents=", "year="])

model = ''
llpmass = 600.
lspmass = 588.
ctau = 200.  # in mm!
nevents = 5000
year = 2024
useCustomPhysics = True

for opt, arg in opts:
    if opt in ("-t", "--model"):
        model = arg
    if opt in ("-m", "--llpmass"):
        llpmass = float(arg)
    if opt in ("-l", "--lspmass"):
        lspmass = float(arg)
    if opt in ("-c", "--ctau"):
        ctau = float(arg)
    if opt in ("-n", "--nevents"):
        nevents = int(arg)
    if opt in ("-y", "--year"):
        year = int(arg)

assert model in ["C1N2","STOP"], "Unknow model {}".format(model)

########## setup

home = os.getcwd()
dirtemplates = home + "/templates"
dirgridpacks = "/groups/hephy/cms/ang.li/gridpacks/"
if model=="STOP":
  fnamegridpack_t = "SMS_StopStop_mStop_LLPMASS_el8_amd64_gcc12_CMSSW_12_4_8_tarball.tar.xz"
elif model=="C1N2":
  fnamegridpack_t = "SMS_C1N2_mC1_LLPMASS_el8_amd64_gcc12_CMSSW_12_4_8_tarball.tar.xz"
wdir = home + "/drivers"


fnamegridpack = dirgridpacks + "/" + fnamegridpack_t.replace("LLPMASS", str(int(llpmass)))

if not os.path.exists(fnamegridpack):
    exit("gridpack " + fnamegridpack + " does not exists; change the mass")

########## prepare working directory

if not os.path.exists(wdir):
    os.mkdir(wdir)
os.chdir(wdir)

thiswdir = "{}_{}_{}_{}_{}_{}{}".format(model,llpmass, lspmass, ctau, nevents, year,'_CP' if useCustomPhysics else '')

if os.path.exists(thiswdir):
    shutil.rmtree(thiswdir)

os.mkdir(thiswdir)
os.chdir(thiswdir)

setupfile_t = dirtemplates + "/setup_template_{}{}.sh".format('CustomPhysics_' if useCustomPhysics else '',year)
setupfile = "setup.sh"

fragmentfile_t = dirtemplates + "/{}-fragment_template.py".format(model)
fragmentfile = "fragment.py"

random_t = dirtemplates + "/random.py"
random = "random.py"

shutil.copyfile(random_t, random)

shutil.copyfile(setupfile_t, setupfile)
os.system('sed -i "s|EVENTCOUNT|' + str(nevents) + '|g" ' + setupfile)

shutil.copyfile(fragmentfile_t, fragmentfile)
os.system('sed -i "s|LLPMASS|' + str(llpmass) + '|g" ' + fragmentfile)
os.system('sed -i "s|LSPMASS|' + str(lspmass) + '|g" ' + fragmentfile)
os.system('sed -i "s|CTAUVALUE|' + str(ctau) + '|g" ' + fragmentfile)
os.system('sed -i "s|EVENTCOUNT|' + str(nevents) + '|g" ' + fragmentfile)
os.system('sed -i "s|GRIDPACKFILE|' + str(fnamegridpack) + '|g" ' + fragmentfile)

########## run job

os.system("bash setup.sh")
