#       Copyright 2017-2019 IBM Corp All Rights Reserved

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at

#       http://www.apache.org/licenses/LICENSE-2.0

#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

FROM ibmcom/websphere-liberty:kernel-ubi-min
USER root

ARG SSL=false
ARG MP_MONITORING=false
ARG HTTP_ENDPOINT=false

COPY ./src/main/liberty/config /config/
COPY ./messaging-ear/target/messaging-ear-1.0-SNAPSHOT.ear /config/apps/Messaging.ear
RUN chown -R 1001.0 /config /opt/ibm/wlp/usr/servers/defaultServer /opt/ibm/wlp/usr/shared/resources && chmod -R g+rw /config /opt/ibm/wlp/usr/servers/defaultServer  /opt/ibm/wlp/usr/shared/resources

USER 1001

RUN installUtility install --acceptLicense mdb-3.2 ejbLite-3.2 jndi-1.0 jsonb-1.0 jca-1.7 jms-2.0 mpRestClient-1.3 mpConfig-1.3 cdi-2.0 ssl-1.0 appSecurity-3.0 jwt-1.0
