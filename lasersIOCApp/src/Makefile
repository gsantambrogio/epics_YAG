TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += lasersIOCSupport

# Compile and add the code to the support library
lasersIOCSupport_SRCS += xxxRecord.c
lasersIOCSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
# This is required for Windows DLL builds.
lasersIOCSupport_SRCS += dbSubExample.c
lasersIOCSupport_SRCS += lasersIOCHello.c
lasersIOCSupport_SRCS += initTrace.c

lasersIOCSupport_LIBS += $(EPICS_BASE_IOC_LIBS)


# Build the IOC application
PROD_IOC = lasersIOC

# lasersIOC.dbd will be created and installed
DBD += lasersIOC.dbd

# lasersIOC.dbd will include these files:
lasersIOC_DBD += base.dbd
lasersIOC_DBD += xxxSupport.dbd
lasersIOC_DBD += dbSubExample.dbd
lasersIOC_DBD += lasersIOCHello.dbd
lasersIOC_DBD += initTrace.dbd

# lasersIOC_registerRecordDeviceDriver.cpp derives from lasersIOC.dbd
lasersIOC_SRCS += lasersIOC_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
lasersIOC_SRCS_DEFAULT += lasersIOCMain.cpp
lasersIOC_SRCS_vxWorks += -nil-

# Link in the code from our support library
lasersIOC_LIBS += lasersIOCSupport
lasersIOC_LIBS += stream
lasersIOC_LIBS += asyn

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into lasersIOCSupport
    sncExample_SNCFLAGS += +r
    lasersIOC_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    lasersIOCSupport_SRCS += sncExample.stt
    lasersIOCSupport_LIBS += seq pv
    lasersIOC_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link IOC to the EPICS Base libraries
lasersIOC_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

