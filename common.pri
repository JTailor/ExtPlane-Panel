CONFIG += c++11

QT += quick

# Place ExtPlane plugin to a directory next to or inside build directory, or
# define the directory here:

# Snapcraft
# HACKHACKHACK: SNAPCRAFT_PROJECT_DIR doesn't seem to work, so we just do it the ugly way
#EXTPLANE_PLUGIN_PATH=$$(SNAPCRAFT_PROJECT_DIR)/extplane/src
EXTPLANE_PLUGIN_PATH=$$(PWD)/../../extplane/src

!exists($$EXTPLANE_PLUGIN_PATH/clients/extplane-client-qt) {
        EXTPLANE_PLUGIN_PATH=$$absolute_path(../../ExtPlane)
        !exists($$EXTPLANE_PLUGIN_PATH/clients/extplane-client-qt) {
                EXTPLANE_PLUGIN_PATH=$$absolute_path(../ExtPlane)
                !exists($$EXTPLANE_PLUGIN_PATH/clients/extplane-client-qt) {
                       error("You don't have ExtPlane checked out in directory next to this. Place it there or build will fail.")
                }
        }
}
message(plugin path $$EXTPLANE_PLUGIN_PATH)

EXTPLANE_CLIENT_PATH=$$EXTPLANE_PLUGIN_PATH/clients/extplane-client-qt

INCLUDEPATH += $$EXTPLANE_CLIENT_PATH

SOURCES += \
    $$EXTPLANE_CLIENT_PATH/../../util/basictcpclient.cpp \
    $$EXTPLANE_CLIENT_PATH/extplaneclient.cpp \
    $$EXTPLANE_CLIENT_PATH/extplaneconnection.cpp \
    $$EXTPLANE_CLIENT_PATH/dataref.cpp \
    $$EXTPLANE_CLIENT_PATH/clientdataref.cpp \
    $$EXTPLANE_CLIENT_PATH/clientdatarefprovider.cpp \
    $$EXTPLANE_CLIENT_PATH/simulateddatarefs/simulateddataref.cpp \
    $$EXTPLANE_CLIENT_PATH/simulateddatarefs/fixedsimulateddataref.cpp \
    $$EXTPLANE_CLIENT_PATH/simulateddatarefs/alternatingsimulateddataref.cpp \
    $$EXTPLANE_CLIENT_PATH/simulatedextplaneconnection.cpp

HEADERS += \
    $$EXTPLANE_CLIENT_PATH/extplaneconnection.h \
    $$EXTPLANE_CLIENT_PATH/extplaneclient.h \
    $$EXTPLANE_CLIENT_PATH/dataref.h \
    $$EXTPLANE_CLIENT_PATH/clientdataref.h \
    $$EXTPLANE_CLIENT_PATH/clientdatarefprovider.h \
    $$EXTPLANE_CLIENT_PATH/simulateddatarefs/simulateddataref.h \
    $$EXTPLANE_CLIENT_PATH/simulateddatarefs/fixedsimulateddataref.h \
    $$EXTPLANE_CLIENT_PATH/simulateddatarefs/alternatingsimulateddataref.h \
    $$EXTPLANE_CLIENT_PATH/simulatedextplaneconnection.h \
    $$EXTPLANE_PLUGIN_PATH/util/basictcpclient.h \
