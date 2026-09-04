#!../../bin/linux-arm/YAG

## You may have to change YAG to something else
## everywhere it appears in this file

< envPaths

epicsEnvSet("STREAM_PROTOCOL_PATH","$(TOP)/db")

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/YAG.dbd"
YAG_registerRecordDeviceDriver pdbbase

# streamDevice protocol file location
epicsEnvSet("STREAM_PROTOCOL_PATH","$(TOP)/db")

#DB include for database concatenation
epicsEnvSet("EPICS_DB_INCLUDE_PATH", "$(TOP)/db")

#YAG seeder (serial)
drvAsynSerialPortConfigure("YAG","/dev/YAG",0,0,0)
asynSetOption("YAG", -1, "baud", "57600")
asynSetOption("YAG", -1, "bits", "8")
asynSetOption("YAG", -1, "parity", "none")
asynSetOption("YAG", -1, "stop", "1")

dbLoadRecords("db/FLM0151.db", "P=pi:,PORT=YAG,R=YAG:,A=0")

#Q-smart pulsed laser (Ethernet, raw ASCII socket)
drvAsynIPPortConfigure("QSMART","10.100.2.43:10001 tcp",0,0,0)

dbLoadRecords("db/Qsmart.db", "PORT=QSMART,R=YAG:,A=0")

## Run this to trace the stages of iocInit
#traceIocInit

cd "${TOP}/iocBoot/${IOC}"
iocInit
