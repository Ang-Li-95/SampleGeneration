#!/bin/bash

export SCRAM_ARCH=el8_amd64_gcc12
source /cvmfs/cms.cern.ch/cmsset_default.sh
n=EVENTCOUNT
HOME="$PWD"
STORE="/scratch/ang.li/GenOutput_mixstop_new"
RUN_NUMBER=$RUN_NUMBER
FIRST_EVENT=$FIRST_EVENT
#EVENT_NUMBER=$EVENT_NUMBER

if [ ! -d $STORE ]; then
  mkdir $STORE
fi

if [ ! -r CMSSW_14_0_21/src ]; then
  scram p CMSSW CMSSW_14_0_21
fi
cd CMSSW_14_0_21/src
mkdir -p Configuration/GenProduction/python/
cp $HOME/random.py Configuration/GenProduction/python/random.py
eval `scram runtime -sh`
scram b

#GEN
cp $HOME/drivers/LHEGEN-cfg.py LHEGEN-cfg.py
config_content=$(cat <<EOL
#####################################

process.source.firstEvent = cms.untracked.uint32($FIRST_EVENT)

#####################################
EOL
)
echo "$config_content" >> "LHEGEN-cfg.py"

cmsRun LHEGEN-cfg.py

#PREMIX
cp $HOME/drivers/PREMIX-cfg.py PREMIX-cfg.py
cmsRun PREMIX-cfg.py

#AODSIM
cp $HOME/drivers/AODSIM-cfg.py AODSIM-cfg.py
cmsRun AODSIM-cfg.py

#COPY FILES
cd $STORE

directories=("PROCESS_LLPMASS_LSPMASS_CTAUVALUE" "PROCESS_LLPMASS_LSPMASS_CTAUVALUE/AODSIM")

for dir in "${directories[@]}"; do
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
  fi
done

cp $HOME/CMSSW_14_0_21/src/AODSIM.root PROCESS_LLPMASS_LSPMASS_CTAUVALUE/AODSIM/$RUN_NUMBER-AODSIM_EVENTCOUNT.root

rm -r $HOME/CMSSW_14_0_21
