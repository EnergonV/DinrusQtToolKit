#!/bin/sh
QBS_VERSION=1.21.0
export QBS_VERSION
QBS_VERSION_TAG=1210
export QBS_VERSION_TAG
QT_INSTALL_DOCS=E:/dinrus/Docs/Qt-6.2.0
export QT_INSTALL_DOCS
exec 'E:\dinrus\mingw64\bin\qdoc.exe' "$@"
