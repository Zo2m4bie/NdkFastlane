FROM reginfell/fastlane

ENV ANDROID_NDK /opt/android-ndk-linux
ENV ANDROID_NDK_HOME /opt/android-ndk-linux
ENV ANDROID_TARGET_SDK="android-27" \
	ANDROID_BUILD_TOOLS="build-tools-27.0.3"

RUN apk update
RUN apk add unzip \
	wget
	
RUN cd /opt && \
	wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip && \
	unzip android-ndk.zip && \
	rm -f android-ndk.zip && \
	mv android-ndk-r18b android-ndk-linux

# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}

# Android Cmake
RUN wget -q https://dl.google.com/android/repository/cmake-3.6.3155560-linux-x86_64.zip -O android-cmake.zip
RUN unzip -q android-cmake.zip -d ${ANDROID_HOME}/cmake
ENV PATH ${PATH}:${ANDROID_HOME}/cmake/bin
RUN chmod u+x ${ANDROID_HOME}/cmake/bin/ -R

RUN echo y | ${ANDROID_HOME}/tools/android update sdk --no-ui --all --filter "${ANDROID_TARGET_SDK}" && \
echo y | ${ANDROID_HOME}/tools/android update sdk --no-ui --all --filter platform-tools && \
echo y | ${ANDROID_HOME}/tools/android update sdk --no-ui --all --filter "${ANDROID_BUILD_TOOLS}"
RUN echo y | ${ANDROID_HOME}/tools/android update sdk --no-ui --all --filter extra-android-m2repository && \
echo y | ${ANDROID_HOME}/tools/android update sdk --no-ui --all --filter extra-google-google_play_services && \
echo y | ${ANDROID_HOME}/tools/android update sdk --no-ui --all --filter extra-google-m2repository
