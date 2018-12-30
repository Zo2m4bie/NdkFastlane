FROM reginfell/fastlane

ENV ANDROID_NDK /opt/android-ndk-linux
ENV ANDROID_NDK_HOME /opt/android-ndk-linux
ENV ANDROID_TARGET_SDK="android-27" \
	ANDROID_BUILD_TOOLS="build-tools-27.0.3"

RUN apk update
RUN apk add unzip \
	wget

RUN apk add cmake \
	make \
	ninja-build 
	
RUN cd /opt && \
	wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip && \
	unzip android-ndk.zip && \
	rm -f android-ndk.zip && \
	mv android-ndk-r18b android-ndk-linux

# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}

#RUN /bin/bash ${ANDROID_NDK}/build/tools/make-standalone-toolchain.sh \
#--arch=arm \
#--platform=android-27 \
#--install-dir=/opt/android \

#COPY toolchain.cmake .
