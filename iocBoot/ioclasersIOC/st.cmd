#!../../bin/linux-arm/lasersIOC

## You may have to change lasersIOC to something else
## everywhere it appears in this file

< envPaths

epicsEnvSet("STREAM_PROTOCOL_PATH","$(TOP)/db")

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/lasersIOC.dbd"
lasersIOC_registerRecordDeviceDriver pdbbase

# streamDevice protocol file location
epicsEnvSet("STREAM_PROTOCOL_PATH","$(TOP)/db")

#DB include for database concatenation
epicsEnvSet("EPICS_DB_INCLUDE_PATH", "$(TOP)/db")

#TOPTICA
# connect to the device ...
drvAsynIPPortConfigure("DLC","10.100.2.4:1998",0,0,0)

## Load record instances
dbLoadRecords("db/DLCpro.db", "P=pi:,PORT=DLC,R=DLCpro:,L=0,A=0")

#YAG
drvAsynSerialPortConfigure("YAG","/dev/YAG",0,0,0)
asynSetOption("YAG", -1, "baud", "57600")
asynSetOption("YAG", -1, "bits", "8")
asynSetOption("YAG", -1, "parity", "none")
asynSetOption("YAG", -1, "stop", "1")

dbLoadRecords("db/FLM0151.db", "P=pi:,PORT=YAG,R=YAG:,A=0")

#WaveFormGen
# Device configurations
epicsEnvSet("AFG_IP",    "$(AFG3000_IP=10.100.2.2)")   # Choose afg ethernet address
epicsEnvSet("AFG_PREFIX", "$(AFG3000_PREFIX=AFG3052C)") # Choose site prefix name
epicsEnvSet("AFG_ASYN_PORT",  "AFG3052C")  # Choose asyn port name
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", 100000)

# Setup IOC->hardware link
vxi11Configure("$(AFG_ASYN_PORT)", "$(AFG_IP)", 0, 0.0, "inst0", 0)

# Load records
dbLoadRecords("$(TOP)/db/AFG3000Device.template", "P=$(AFG_PREFIX):,PREFIX=$(AFG_PREFIX),ASYN_PORT=$(AFG_ASYN_PORT),ASYN_ADDR=0")
dbLoadRecords("$(TOP)/db/AFG3000Channel.template", "P=$(AFG_PREFIX):, R=AO0:, CHANNEL=1, PREFIX=$(AFG_PREFIX),ASYN_PORT=$(AFG_ASYN_PORT),ASYN_ADDR=0")
dbLoadRecords("$(TOP)/db/AFG3000Channel.template", "P=$(AFG_PREFIX):, R=AO1:, CHANNEL=2, PREFIX=$(AFG_PREFIX),ASYN_PORT=$(AFG_ASYN_PORT),ASYN_ADDR=0")
dbLoadRecords("$(TOP)/db/AFG3000Channel-internal.template", "P=$(AFG_PREFIX):, R=CH0:, CHANNEL=3, PREFIX=$(AFG_PREFIX),ASYN_PORT=$(AFG_ASYN_PORT),ASYN_ADDR=0")
dbLoadRecords("$(TOP)/db/AFG3000Channel-internal.template", "P=$(AFG_PREFIX):, R=CH1:, CHANNEL=4, PREFIX=$(AFG_PREFIX),ASYN_PORT=$(AFG_ASYN_PORT),ASYN_ADDR=0")



#drvAsynIPPortConfigure("WFG","10.100.2.2:5025",0,0,0)
#vxi11Configure("WFG","10.100.2.2:5025",1,1000,"inst0")
#dbLoadRecords("db/WFG.db","PORT=WFG,CH=1")

## Set this to see messages from mySub
#var mySubDebug 1

## Run this to trace the stages of iocInit
#traceIocInit

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncExample, "user=pi"
