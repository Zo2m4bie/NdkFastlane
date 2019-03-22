FROM openjdk:8-jdk

ENV ANDROID_COMPILE_SDK="28" \
ANDROID_BUILD_TOOLS="28.0.3" \
ANDROID_SDK_TOOLS_REV="4333796" \
ANDROID_CMAKE_REV="3.6.4111459"

ENV CLOUD_SDK_VERSION 183.0.0

ENV PATH /google-cloud-sdk/bin:$PATH
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/platform-tools/:${ANDROID_NDK_HOME}:${ANDROID_HOME}/ndk-bundle:${ANDROID_HOME}/tools/bin/

RUN apt-get update && \
apt-get install -y file && \
rm -rf /var/lib/apt/lists/*

RUN apt-get install curl \
        python \
        openssh-client \
        git \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version
    
RUN mkdir -p ${ANDROID_HOME} \
&& wget --quiet --output-document=${ANDROID_HOME}/android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_REV}.zip \
&& unzip -qq ${ANDROID_HOME}/android-sdk.zip -d ${ANDROID_HOME} \
&& rm ${ANDROID_HOME}/android-sdk.zip \
&& mkdir -p $HOME/.android \
&& echo 'count=0' > $HOME/.android/repositories.cfg

RUN yes | sdkmanager --licenses > /dev/null \ 
&& yes | sdkmanager --licenses \
 && yes | sdkmanager --update \
&& yes | sdkmanager 'tools' \
&& yes | sdkmanager 'platform-tools' \
&& yes | sdkmanager 'build-tools;'$ANDROID_BUILD_TOOLS \
&& yes | sdkmanager 'platforms;android-'$ANDROID_COMPILE_SDK \
&& yes | sdkmanager 'extras;android;m2repository' \
&& yes | sdkmanager 'extras;google;google_play_services' \
&& yes | sdkmanager 'extras;google;m2repository' \
&& yes | sdkmanager --licenses

RUN yes | sdkmanager 'cmake;'$ANDROID_CMAKE_REV \
&& yes | sdkmanager 'ndk-bundle' 


RUN gcloud init
