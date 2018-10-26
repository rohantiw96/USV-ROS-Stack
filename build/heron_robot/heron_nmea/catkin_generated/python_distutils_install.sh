#!/bin/sh -x

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

cd "/home/lukewen/heron_ws/src/heron_robot/heron_nmea"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
/usr/bin/env \
    PYTHONPATH="/home/lukewen/heron_ws/install/lib/python2.7/dist-packages:/home/lukewen/heron_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/lukewen/heron_ws/build" \
    "/usr/bin/python" \
    "/home/lukewen/heron_ws/src/heron_robot/heron_nmea/setup.py" \
    build --build-base "/home/lukewen/heron_ws/build/heron_robot/heron_nmea" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/lukewen/heron_ws/install" --install-scripts="/home/lukewen/heron_ws/install/bin"
