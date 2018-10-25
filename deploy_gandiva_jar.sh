#!/usr/bin/env bash

# Copyright (C) 2017-2018 Dremio Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
set -e

git clone https://github.com/praveenbingo/crossbow crossbow
cd crossbow
git fetch origin
branch=`git branch -r --sort=-committerdate | head -1 | awk '{split($0,a,"/"); print a[2]}'`

cd ${TRAVIS_BUILD_DIR}


wget https://github.com/praveenbingo/crossbow/releases/download/${branch}/arrow-gandiva-0.12.0-SNAPSHOT.jar
mvn --settings ossrh_settings.xml deploy:deploy-file -Durl=https://oss.sonatype.org/content/repositories/snapshots \
                -DrepositoryId=ossrh \
                -Dfile=arrow-gandiva-0.12.0-SNAPSHOT.jar \
                -DpomFile=pom.xml
