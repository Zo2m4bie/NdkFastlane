FROM reginfell/fastlane

ENV ANDROID_NDK /android-ndk-linux
ENV ANDROID_NDK_HOME /android-ndk-linux
ENV ANDROID_TARGET_SDK="android-27" \
	ANDROID_BUILD_TOOLS="build-tools-27.0.3"

RUN apk update
RUN apk add unzip \
	wget
	
#RUN apk add cmake \
#	make \
#	ninja
	
#RUN cmake -version
#RUN ninja --version


RUN wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip && \
	unzip android-ndk.zip && \
	rm -f android-ndk.zip && \
	mv android-ndk-r18b android-ndk-linux

#RUN cd /opt && \
#	wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip && \
#	unzip android-ndk.zip && \
#	rm -f android-ndk.zip && \
#	mv android-ndk-r18b android-ndk-linux

# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}

RUN ${ANDROID_HOME}/tools/bin/sdkmanager "extras;android;m2repository" "extras;google;m2repository" "extras;google;google_play_services"
RUN ${ANDROID_HOME}/tools/bin/sdkmanager "cmake;3.6.4111459"
RUN ${ANDROID_HOME}/tools/bin/sdkmanager 'ndk-bundle' 

# Android Cmake
#RUN wget -q https://dl.google.com/android/repository/cmake-3.6.3155560-linux-x86_64.zip -O android-cmake.zip
#RUN unzip -q android-cmake.zip -d ${ANDROID_HOME}/cmake
#ENV PATH ${PATH}:${ANDROID_HOME}/cmake/bin
#RUN chmod u+x ${ANDROID_HOME}/cmake/bin/ -R

#RUN /bin/bash ${ANDROID_NDK}/build/tools/make-standalone-toolchain.sh \
#-arch=arm \
#--platform=android-27 \
#--install-dir=/sdk \

#COPY toolchain.cmake .
