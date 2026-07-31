TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += YAGSupport

# Compile and add the code to the support library
YAGSupport_SRCS += xxxRecord.c
YAGSupport_SRCS += devXxxSoft.c

YAGSupport_LIBS += $(EPICS_BASE_IOC_LIBS)


# Build the IOC application
PROD_IOC = YAG

# YAG.dbd will be created and installed
DBD += YAG.dbd

# YAG.dbd will include these files:
YAG_DBD += base.dbd
YAG_DBD += xxxSupport.dbd

# YAG_registerRecordDeviceDriver.cpp derives from YAG.dbd
YAG_SRCS += YAG_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
YAG_SRCS_DEFAULT += YAGMain.cpp
YAG_SRCS_vxWorks += -nil-

# Link in the code from our support library
YAG_LIBS += YAGSupport
YAG_LIBS += stream
YAG_LIBS += asyn

# Finally link IOC to the EPICS Base libraries
YAG_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE
