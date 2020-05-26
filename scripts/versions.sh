#!/bin/bash

UVPVER=$(rpm -qa --qf '%{VERSION}' uvp-win32)
WTMVER=$(rpm -qa --qf '%{VERSION}' wtm3-win32)
SMCVER=$(rpm -qa --qf '%{VERSION}' wmsmc-win32)
CVVER=$(rpm -qa --qf '%{VERSION}' ctms_vessel-win32)
CTVER=$(rpm -qa --qf '%{VERSION}' ctms_train-win32)
KIOSKVER=$(rpm -qa --qf '%{VERSION}' solvo-KioskPROJ)
XRDTVER=$(rpm -qa --qf '%{VERSION}' solvo-xrdt-PROJ)

echo "UVP:        "$UVPVER "\nWTM:         "$WTMVER "\nWMSMC:       "$SMCVER "\nCTMS VESSEL: "$CVVER "\nCTMS TRAIN:  "$CTVER "\nKIOSK:       "$KIOSKVER "\nXRDT:        "$XRDTVER
