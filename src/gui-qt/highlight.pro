
TARGET = highlight-gui
TEMPLATE = app
INCLUDEPATH += . ../include
QT += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

PRECOMPILED_HEADER = precomp.h
DEFINES += O2 QT

SOURCES += main.cpp \
    mainwindow.cpp \
    io_report.cpp \
    showtextfile.cpp \
    syntax_chooser.cpp

HEADERS += mainwindow.h \
    precomp.h \
    io_report.h \
    showtextfile.h \
    syntax_chooser.h

FORMS += mainwindow.ui \
    io_report.ui \
    showtextfile.ui \
    syntax_chooser.ui

RESOURCES = highlight-gui.qrc
TRANSLATIONS = highlight_de_DE.ts highlight_es_ES.ts highlight_cs_CZ.ts \
    highlight_zh_CN.ts highlight_it_IT.ts highlight_fr_FR.ts highlight_bg_BG.ts

QMAKE_CXXFLAGS += -std=c++11

# If Lua 5.2 is not default on your system yet you have to omit 5.1 here:
unix {
    DESTDIR = ../
    LIBS += -L.. -lhighlight
    LIBS += -llua
    CONFIG += link_pkgconfig
    PKGCONFIG += lua

    # to make it run within Qt Creator
    !contains(DEFINES, DATA_DIR.*) {
        DEFINES+=DATA_DIR=\\\"/usr/share/highlight/\\\"
    }
    !contains(DEFINES, CONFIG_DIR.*) {
        DEFINES+=CONFIG_DIR=\\\"/etc/highlight/\\\"
    }
    !contains(DEFINES, DOC_DIR.*) {
        DEFINES+=DOC_DIR=\\\"/usr/share/doc/highlight/\\\"
    }
}

win32 {
    DESTDIR = ../..

    INCLUDEPATH += F:\libs\lua_5.4.0\
    INCLUDEPATH += ../../include
    INCLUDEPATH += F:/libs/boost_1_70_0

    DEFINES += WIN32
    CONFIG += static
    LIBS += -LF:\git\highlight\src -lhighlight

    contains(QT_ARCH, i386) {
        LIBS += -LF:\libs\lua_5.4.0\x32 -llua
    } else {
        LIBS += -LF:\libs\lua_5.4.0\x64 -llua
    }

    RC_FILE = highlight-gui.rc
    QMAKE_POST_LINK = F:\upx393w\upx.exe --best F:\git\highlight\highlight-gui.exe
}

macx-clang {
    QMAKE_CC = clang
    QMAKE_CXX = clang++
    INCLUDEPATH+=/usr/local/Cellar/lua/5.2.4_4/include/
    INCLUDEPATH += ../../include
    INCLUDEPATH+=/usr/local/Cellar/boost/1.62.0/include

    QT_CONFIG -= no-pkg-config
    CONFIG += link_pkgconfig
    PKGCONFIG += lua
    LIBS += -L.. -lhighlight
    LIBS += -L/Users/andresimon/Downloads/tarballs/lua-5.3.4/src -llua
    ICON = $${PWD}/highlight.icns
}
