# -*- Mode: Python3; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

import os
import sys


def info():

    dado = ["modulo_principal"]
    dado += [sys.platform]
    dado += [os.name]

    return dado


if __name__ == '__main__':
    pass
