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

app_name=Gradle
app_args=""

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

JAVA_OPTS=$( printf '%s\n' "${JAVA_OPTS}" | sed 's|\\\\|\\\\\\\\|g' )

CLASSPATH=$APP_HOME/gradle/wrapper/gradle-wrapper.jar

exec "$JAVACMD" "$@"
