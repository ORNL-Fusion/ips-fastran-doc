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

class ips_scan_init(Component):
    def __init__(self, services, config):
        Component.__init__(self, services, config)
        print('Created %s' % (self.__class__))

    def init(self, timeid=0):
        pass

    def step(self, timeid=0, **keywords):
        pass

    def finalize(self, timeid=0):
        pass

