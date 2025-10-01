#!/bin/bash

export SCRAM_ARCH=el8_amd64_gcc12
source /cvmfs/cms.cern.ch/cmsset_default.sh
n=EVENTCOUNT
HOME="$PWD"

if [ ! -r CMSSW_14_0_21/src ]; then
  scram p CMSSW CMSSW_14_0_21
fi
cd CMSSW_14_0_21/src
eval `scram runtime -sh`
#git cms-merge-topic 46834
mkdir -p Configuration/GenProduction/python/
cp $HOME/fragment.py Configuration/GenProduction/python/fragment.py
cp $HOME/random.py Configuration/GenProduction/python/random.py
mkdir -p Configuration/GenProduction/data/
cp $HOME/../../Configuration-Generator/* Configuration/GenProduction/data/.
cp $HOME/../../SLHA/* Configuration/GenProduction/data/.
scram b -j 8

cmsDriver.py Configuration/GenProduction/python/fragment.py --python_filename LHEGEN-cfg.py --eventcontent RAWSIM,LHE --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM,LHE --fileout file:LHEGEN.root --conditions 140X_mcRun3_2024_realistic_v26 --beamspot DBrealistic --step LHE,GEN,SIM --geometry DB:Extended --era Run3_2024 --customise SimG4Core/CustomPhysics/Exotica_HSCP_SIM_cfi.customise --no_exec --mc --customise Configuration/GenProduction/random.random -n $n

cmsDriver.py  --era Run3_2024 --customise Configuration/DataProcessing/Utils.addMonitoring --procModifiers premix_stage2 --datamix PreMix --step DIGI,DATAMIX,L1,DIGI2RAW,HLT:2024v14 --geometry DB:Extended --conditions 140X_mcRun3_2024_realistic_v26 --datatier GEN-SIM-RAW --eventcontent PREMIXRAW --python_filename PREMIX-cfg.py --fileout file:PREMIX.root --filein file:LHEGEN.root --pileup_input "dbs:/Neutrino_E-10_gun/RunIIISummer24PrePremix-Premixlib2024_140X_mcRun3_2024_realistic_v26-v1/PREMIX" --no_exec --mc -n $n 

cmsDriver.py  --era Run3_2024 --customise Configuration/DataProcessing/Utils.addMonitoring --step RAW2DIGI,L1Reco,RECO,RECOSIM --geometry DB:Extended --conditions 140X_mcRun3_2024_realistic_v26 --datatier AODSIM --eventcontent AODSIM --python_filename AODSIM-cfg.py --fileout file:AODSIM.root --filein file:PREMIX.root --no_exec --mc -n $n

cd $HOME

cp CMSSW_14_0_21/src/LHEGEN-cfg.py LHEGEN-cfg.py
cp CMSSW_14_0_21/src/PREMIX-cfg.py PREMIX-cfg.py
cp CMSSW_14_0_21/src/AODSIM-cfg.py AODSIM-cfg.py

rm -rf CMSSW_14_0_21
