"""
 -----------------------------------------------------------------------
ensemble
 -----------------------------------------------------------------------
"""
import os
import shutil
import subprocess
import numpy as np
import time
from configobj import ConfigObj

from ipsframework import Component
from ipsframework import ipsutil
from ipsframework.ipsutil import params_from_csv

class ips_scan_driver(Component):
    def __init__(self, services, config):
        Component.__init__(self, services, config)
        print('Created %s' % (self.__class__))

    def init(self, timeid=0):
        self.clean_after = int(getattr(self, 'CLEAN_AFTER', '0'))
        self.time_out = int(getattr(self, 'TIME_OUT', '3600000'))

    def step(self, timeid=0, **keywords):
        # --- stage input files
        print(self.INPUT_FILES)
        self.services.stage_input_files(self.INPUT_FILES)

        f_inscan = getattr(self, 'INSCAN', 'inscan.csv')
        variables = params_from_csv(f_inscan)

        f_sim_config = getattr(self, 'SIMULATION', '')
        print(f_sim_config)

        num_nodes = int(getattr(self, 'NUM_NODES', '1'))
        cores_per_instance = int(getattr(self, 'CORES_PER_SIMULATION', '1'))

        pwd = self.services.get_config_param('PWD')

        mapping = self.services.run_ensemble(
                      f_sim_config,
                      variables,
                      pwd,
                      name='SANDBOX_',
                      num_nodes=num_nodes,
                      cores_per_instance=cores_per_instance,
                      oversubscribe=False,
                      logfile='ips_sandbox.out',
                      errfile='ips_sandbox.err',
                  )

    def finalize(self, timeid=0):
        pass


