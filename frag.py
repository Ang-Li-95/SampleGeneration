import os, sys, glob
import getopt, datetime
import shutil


########## options

opts, args = getopt.getopt(sys.argv[1:], "t:m:d:c:e:", ["model=", "llpmass=", "massdiff=", "ctau=", "era="])

model = 'STOP'
llpmass = 600.
lspmass = 12.
ctau = 200.  # in mm!
era = 'run3'

for opt, arg in opts:
    if opt in ("-t", "--model"):
        model = str(arg)
    if opt in ("-m", "--llpmass"):
        llpmass = float(arg)
    if opt in ("-d", "--massdiff"):
        dm = float(arg)
    if opt in ("-c", "--ctau"):
        ctau = float(arg)
    if opt in ("-e", "--era"):
        era = str(arg)

lspmass=llpmass-dm

########## setup

home = os.getcwd()
dirtemplates = home + "/templates"

if era=="run2":
    print("Prepare for run2")
    ### For Run 2 UL
    if model=='C1N2':
        dirgridpacks = "/cvmfs/cms.cern.ch/phys_generator/gridpacks/UL/13TeV/madgraph/V5_2.6.5/sus_sms/SMS-C1N2_v2"
        fnamegridpack_t = "SMS-C1N2_mC1-LLPMASS_slc7_amd64_gcc700_CMSSW_10_6_19_tarball.tar.xz"
    elif model=='STOP':
        dirgridpacks = "/cvmfs/cms.cern.ch/phys_generator/gridpacks/UL/13TeV/madgraph/V5_2.6.5/sus_sms/SMS-StopStop_v2"
        fnamegridpack_t = "SMS-StopStop_mStop-LLPMASS_slc7_amd64_gcc700_CMSSW_10_6_19_tarball.tar.xz"
    else:
        raise Exception("Model {} not supported!".format(model))
elif era=="run3":
    print("Prepare for run3")
    ### For Run 3
    if model=='C1N2':
        dirgridpacks = "/eos/home-l/lian/SMS-C1N2"
        fnamegridpack_t = "SMS_C1N2_mC1_LLPMASS_el8_amd64_gcc12_CMSSW_12_4_8_tarball.tar.xz"
    elif model=='STOP':
        dirgridpacks = "/eos/home-l/lian/SMS-StopStop"
        fnamegridpack_t = "SMS_StopStop_mStop_LLPMASS_el8_amd64_gcc12_CMSSW_12_4_8_tarball.tar.xz"
    else:
        raise Exception("Model {} not supported!".format(model))
else:
    raise Exception("Era {} not supported!".format(era))

fnamegridpack = dirgridpacks + "/" + fnamegridpack_t.replace("LLPMASS", str(int(llpmass)))

#if not os.path.exists(fnamegridpack):
#    exit("gridpack " + fnamegridpack + " does not exists; change the mass")

########## prepare working directory

wdir = home + "/fragments{}{}".format(model,era)
if not os.path.exists(wdir):
    os.mkdir(wdir)
os.chdir(wdir)

fragmentfile_t = dirtemplates + "/{}-fragment_requesttemplate_{}.py".format(model,era)
ctau_str = str(ctau).replace('.','p')
if not 'p' in ctau_str:
  ctau_str += 'p0'
llpmass_str = str(int(llpmass))
lspmass_str = str(int(lspmass))
if model=='C1N2':
    if era=='run3':
        fragmentfile = "c1n2_Fil-MET100-HT200_Par-Mc1n2-{}-Mlsp-{}-ctau-{}_TuneCP5_13p6TeV_madgraph-pythia8_cff.py".format(llpmass_str,lspmass_str,ctau_str)
    elif era=='run2':
        fragmentfile = "c1n2_Mc1n2-{}_Mlsp-{}_ctau-{}_MET100-HT200_TuneCP5_13TeV_madgraph-pythia8_cff.py".format(llpmass_str,lspmass_str,ctau_str)
elif mode=='STOP':
    if era=='run3':
        fragmentfile = "stop_Fil-MET100-HT200_Par-Mstop-{}-Mlsp-{}-ctau-{}_TuneCP5_13p6TeV_madgraph-pythia8_cff.py".format(llpmass_str,lspmass_str,ctau_str)
    elif era=='run2':
        fragmentfile = "stop_Mstop-{}_Mlsp-{}_ctau-{}_MET100-HT200_TuneCP5_13TeV_madgraph-pythia8_cff.py".format(llpmass_str,lspmass_str,ctau_str)

shutil.copyfile(fragmentfile_t, fragmentfile)
os.system('sed -i "s|LLPMASS|' + str(llpmass) + '|g" ' + fragmentfile)
os.system('sed -i "s|LSPMASS|' + str(lspmass) + '|g" ' + fragmentfile)
os.system('sed -i "s|CTAUVALUE|' + str(ctau) + '|g" ' + fragmentfile)
os.system('sed -i "s|GRIDPACKFILE|' + str(fnamegridpack) + '|g" ' + fragmentfile)


