#!/bin/bash

UVPVER=$(rpm -qa --qf '%{VERSION}-%{RELEASE}' uvp-win32)
WTMVER=$(rpm -qa --qf '%{VERSION}-%{RELEASE}' wtm3-win32)
SMCVER=$(rpm -qa --qf '%{VERSION}-%{RELEASE}' wmsmc-win32)
CVVER=$(rpm -qa --qf '%{VERSION}-%{RELEASE}' ctms_vessel-win32)
CTVER=$(rpm -qa --qf '%{VERSION}-%{RELEASE}' ctms_train-win32)
KIOSKVER=$(rpm -qa --qf '%{VERSION}-%{RELEASE}' solvo-KioskPROJ)
XRDTVER=$(rpm -qa --qf '%{VERSION}-%{RELEASE}' solvo-xrdt-PROJ)

echo "UVP:        "$UVPVER "\nWTM:         "$WTMVER "\nWMSMC:       "$SMCVER "\nCTMS VESSEL: "$CVVER "\nCTMS TRAIN:  "$CTVER "\nKIOSK:       "$KIOSKVER "\nXRDT:        "$XRDTVER
