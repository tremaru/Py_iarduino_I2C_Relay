from distutils.core import setup

from Cython.Build import cythonize

setup(ext_modules=cythonize("Py_iarduino_I2C_Relay.pyx"))
