#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --qos=medium

cat > inside_container.sh <<'EOS'
#!/bin/bash

echo "env setup"
export SCRAM_ARCH=el8_amd64_gcc12
source /cvmfs/cms.cern.ch/cmsset_default.sh
n=EVENTCOUNT
SOURCE="$PWD"
STORE="/scratch/ang.li/GenOutput_2024"
RUN_NUMBER=$RUN_NUMBER
FIRST_EVENT=$FIRST_EVENT
echo "First event $FIRST_EVENT"
HOME=$RUN_DIR
echo "Work directory $HOME"
mkdir -p $HOME
cd $HOME
#EVENT_NUMBER=$EVENT_NUMBER

cp -r $SOURCE/* .

if [ ! -d $STORE ]; then
  mkdir $STORE
fi

if [ ! -r CMSSW_14_0_21/src ]; then
  scram p CMSSW CMSSW_14_0_21
fi
cd CMSSW_14_0_21/src
eval `scram runtime -sh`
#git cms-merge-topic 46834
mkdir -p Configuration/GenProduction/python/
cp $HOME/random.py Configuration/GenProduction/python/random.py
mkdir -p Configuration/GenProduction/data/
#cp /scratch/ang.li/Configuration-Generator/* Configuration/GenProduction/data/.
cp /groups/hephy/cms/ang.li/Generation/SLHA/* Configuration/GenProduction/data/.
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

rm -rf $HOME/CMSSW_14_0_21

echo "Container job finished!"
EOS

chmod +x inside_container.sh

cmssw-el8 --command-to-run bash inside_container.sh
