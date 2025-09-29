import os

def STOPSLHA(mStop,mLSP,ctau):
  ### For STOP
  hBarCinGeVmm = 1.973269788e-13
  gevWidth = hBarCinGeVmm / ctau
  baseSLHATable="""
BLOCK MASS  # Mass Spectrum
# PDG code           mass       particle
   1000001     1.00000000E+05   # ~d_L
   2000001     1.00000000E+05   # ~d_R
   1000002     1.00000000E+05   # ~u_L
   2000002     1.00000000E+05   # ~u_R
   1000003     1.00000000E+05   # ~s_L
   2000003     1.00000000E+05   # ~s_R
   1000004     1.00000000E+05   # ~c_L
   2000004     1.00000000E+05   # ~c_R
   1000005     1.00000000E+05   # ~b_1
   2000005     1.00000000E+05   # ~b_2
   1000006     %MSTOP%          # ~t_1
   2000006     1.00000000E+05   # ~t_2
   1000011     1.00000000E+05   # ~e_L
   2000011     1.00000000E+05   # ~e_R
   1000012     1.00000000E+05   # ~nu_eL
   1000013     1.00000000E+05   # ~mu_L
   2000013     1.00000000E+05   # ~mu_R
   1000014     1.00000000E+05   # ~nu_muL
   1000015     1.00000000E+05   # ~tau_1
   2000015     1.00000000E+05   # ~tau_2
   1000016     1.00000000E+05   # ~nu_tauL
   1000021     1.00000000E+05    # ~g
   1000022     %MLSP%           # ~chi_10
   1000023     1.00000000E+05   # ~chi_20
   1000025     1.00000000E+05   # ~chi_30
   1000035     1.00000000E+05   # ~chi_40
   1000024     1.00000000E+05   # ~chi_1+
   1000037     1.00000000E+05   # ~chi_2+

# DECAY TABLE
#         PDG            Width
DECAY   1000001     0.00000000E+00   # sdown_L decays
DECAY   2000001     0.00000000E+00   # sdown_R decays
DECAY   1000002     0.00000000E+00   # sup_L decays
DECAY   2000002     0.00000000E+00   # sup_R decays
DECAY   1000003     0.00000000E+00   # sstrange_L decays
DECAY   2000003     0.00000000E+00   # sstrange_R decays
DECAY   1000004     0.00000000E+00   # scharm_L decays
DECAY   2000004     0.00000000E+00   # scharm_R decays
DECAY   1000005     0.00000000E+00   # sbottom1 decays
DECAY   2000005     0.00000000E+00   # sbottom2 decays
DECAY   1000006     %CTAU0%   # stop1 decays
    0.00000000E+00    4    1000022      5     -1    2  # dummy allowed decay, in order to turn on off-shell decays
    0.50000000E+00    3    1000022      5   24
    0.50000000E+00    2    1000022      4 
DECAY   2000006     0.00000000E+00   # stop2 decays
DECAY   1000011     0.00000000E+00   # selectron_L decays
DECAY   2000011     0.00000000E+00   # selectron_R decays
DECAY   1000012     0.00000000E+00   # snu_elL decays
DECAY   1000013     0.00000000E+00   # smuon_L decays
DECAY   2000013     0.00000000E+00   # smuon_R decays
DECAY   1000014     0.00000000E+00   # snu_muL decays
DECAY   1000015     0.00000000E+00   # stau_1 decays
DECAY   2000015     0.00000000E+00   # stau_2 decays
DECAY   1000016     0.00000000E+00   # snu_tauL decays
DECAY   1000021     0.00000000E+00   # gluino decays
DECAY   1000022     0.00000000E+00   # neutralino1 decays
DECAY   1000023     0.00000000E+00   # neutralino2 decays
DECAY   1000024     0.00000000E+00   # chargino1+ decays
DECAY   1000025     0.00000000E+00   # neutralino3 decays
DECAY   1000035     0.00000000E+00   # neutralino4 decays
DECAY   1000037     0.00000000E+00   # chargino2+ decays
"""
  
  slhatable = baseSLHATable.replace('%MSTOP%','%e' % mStop)
  slhatable = slhatable.replace('%MLSP%','%e' % mLSP)
  slhatable = slhatable.replace('%CTAU0%','%e' % gevWidth)
  return slhatable

def saveSLHA(table,output):
  with open(output,'w') as f:
    f.write(table)

def prepareSLHA(mStop,mLSP,ctau,output):
  table = STOPSLHA(mStop,mLSP,ctau)
  saveSLHA(table,output)

if __name__ == '__main__':
  output = 'SLHA'
  if not os.path.exists(output):
    os.makedirs(output)
  ms = [400,500,600,700,800,900,1000,1100,1200,1300,1400]
  ct_dm = { 
      5: [0.2,2,20,200],
      #12: [0.2,2,20,200],
      #15: [0.2,2,20,200],
      #20: [0.2,2,20,200],
      #25: [0.2,2,20,200]
  }
  nevts_dm = { 
      5: 150000,
      12: 150000,
      15: 50000,
      20: 50000,
      25: 500000,
  }
  for m in ms: 
    for dm in ct_dm:
      for ct in ct_dm[dm]:
        ctaustr = "{:.1f}".format(ct).replace('.','p')
        SLHA_FILE ='LL_stop_%d_Neutralino_%d_CTau_%s_SLHA.spc' % (m, m-dm, ctaustr)
        prepareSLHA(m,m-dm,ct,SLHA_FILE)
