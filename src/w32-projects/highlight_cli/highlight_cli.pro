
QT -= core gui
TARGET = highlight
CONFIG += console
CONFIG -= app_bundle
TEMPLATE = app

win32 {
    DESTDIR = ..\\..\\..
    SOURCES += ..\\..\\cli\\main.cpp \
        ..\\..\\cli\\help.cpp \
        ..\\..\\cli\\cmdlineoptions.cpp \
        ..\\..\\cli\\arg_parser.cc
    HEADERS += ..\\..\\cli\\main.h \
        ..\\..\\cli\\help.h \
        ..\\..\\cli\\cmdlineoptions.h \
        ..\\..\\cli\\arg_parser.h

    INCLUDEPATH += F:/libs/lua_5.4.0

    INCLUDEPATH += F:/libs/boost_1_70_0
    INCLUDEPATH += ../../include
    QMAKE_CXXFLAGS += -std=c++11
}
else {
    SOURCES += cli/main.cpp \
        cli/help.cpp \
        cli/cmdlineoptions.cpp \
        cli/arg_parser.cc
    HEADERS += src/cli/main.h \
        cli/help.h \
        cli/cmdlineoptions.h \
        cli/arg_parser.h
}

# get rid of mingw32 DLL dependency
win32:QMAKE_LFLAGS_WINDOWS += -static-libgcc -static-libstdc++

win32:LIBS += -LF:\git\highlight\src -lhighlight
unix:LIBS += -L.. -lhighlight

win32 {
    contains(QT_ARCH, i386) {
        LIBS += -LF:/libs/lua_5.4.0/x32 -llua
    } else {
        LIBS += -LF:/libs/lua_5.4.0/x64 -llua
    }
}

!contains( LINKTYPE, LUA52 ) {
    unix:LIBS += -L.. -llua5.1
}
contains( LINKTYPE, LUA52 ) {
    unix:LIBS += -L.. -llua5.2
    unix:DEFINES += USE_LUA52
}

win32:QMAKE_POST_LINK = F:\upx393w\upx.exe --best ..\..\..\highlight.exe
