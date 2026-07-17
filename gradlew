#!/usr/bin/env sh

#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

app_path=$0

# Need this for daisy-chained symlinks.
while
    APP_HOME=${app_path%"${app_path##*/}"}
    [ -h "$app_path" ]
do
    ls=$( ls -ld "$app_path" )
    link=${ls#*' -> '}
    case $link in
    /*) app_path=$link ;;
    *) app_path=$APP_HOME$link ;;
    esac
done

APP_HOME=$( cd "${APP_HOME-.}" && pwd -P ) || exit

APP_NAME="Gradle"
app_args="$()"

case $( uname ) in
*[Cc][Yy][Gg][Ww][Ii][Nn]* )
    APP_HOME=$( cygpath --path --windows "$APP_HOME" )
    APP_CLASSPATH=$( cygpath --path --windows "$APP_CLASSPATH" )

    CLASSPATH=$(
        cat "$APP_HOME/gradle/wrapper/gradle-wrapper.jar"
    )
    case $CLASSPATH in
    *\\ *)
        APP_CLASSPATH=$(
            printf '%s' "$CLASSPATH" | sed 's|\\\\|\\\\\\\\|g'
        )
        ;;
    esac
    APP_HOME=$( cygpath --path --mixed "$APP_HOME" )
    APP_CLASSPATH=$( cygpath --path --mixed "$APP_CLASSPATH" )
    CLASSPATH=$(
        printf '%s' "$CLASSPATH" | sed 's|\\\\|\\\\\\\\|g'
    )
    ;;
esac

if [ "$ITERM_SESSION_ID" != "" ] -o [ "$TERM_PROGRAM" = "iTerm.app" ] ; then
    export TERM_PROGRAM_VERSION
fi

DETECT_MODULES=true

if [ "$DETECT_MODULES" = "true" ]; then
    if command -v java > /dev/null 2>&1 && [ "$(java -version 2>&1 | head -c 8)" = "openjdk " ] || [ "$(java -version 2>&1 | head -c 10)" = "java version" ]; then
        for module in java.base java.compiler java.desktop java.instrument java.management java.prefs java.rmi java.scripting java.sql java.xml; do
            CLASSPATH="$CLASSPATH:$JAVA_HOME/jmods/$module.jmod"
        done
    fi
fi

exec "$JAVACMD" "$@"
