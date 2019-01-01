FROM reginfell/fastlane

ENV ANDROID_NDK $ANDROID_HOME/ndk-bundle
ENV NINJA_PATH /ninja
ENV ANDROID_NDK_HOME $ANDROID_HOME/ndk-bundle
ENV ANDROID_NDK_ROOT $ANDROID_HOME/ndk-bundle
ENV NDK_HOME $ANDROID_HOME/ndk-bundle
ENV NDK_ROOT $ANDROID_HOME/ndk-bundle
ENV ANDROID_TARGET_SDK="android-27" \
	ANDROID_BUILD_TOOLS="build-tools-27.0.3"

RUN ${ANDROID_HOME}/tools/bin/sdkmanager \
        "cmake;3.6.4111459" \
        ndk-bundle \
    && rm -rf  \
        # Delete simpleperf tool
        $NDK_ROOT/simpleperf \
        # Delete STL version we don't care about
        $NDK_ROOT/sources/cxx-stl/stlport \
        $NDK_ROOT/sources/cxx-stl/gnu-libstdc++ \
        # Delete unused prebuild images
        $NDK_ROOT/prebuilt/android-mips* \
        # Delete obsolete Android platforms
        $NDK_ROOT/platforms/android-9 \
        $NDK_ROOT/platforms/android-12 \
        $NDK_ROOT/platforms/android-13 \
        $NDK_ROOT/platforms/android-15 \
        $NDK_ROOT/platforms/android-16 \
        # Delete unused platform sources
        $NDK_ROOT/sources/cxx-stl/gnu-libstdc++/4.9/libs/mips* \
        $NDK_ROOT/sources/cxx-stl/llvm-libc++/libs/mips* \
        # Delete LLVM STL tests
        $NDK_ROOT/sources/cxx-stl/llvm-libc++/test \
        # Delete unused toolchains
        $NDK_ROOT/toolchains/mips \
        $NDK_ROOT/build/core/toolchains/mips* \
    && ${ANDROID_HOME}/tools/bin/sdkmanager --list | sed -e '/Available Packages/q'
    
ENV PATH ${PATH}:${ANDROID_NDK_HOME}
ENV PATH ${PATH}:${NDK_HOME}
ENV PATH ${PATH}:${NDK_ROOT}
ENV PATH ${PATH}:${ANDROID_NDK_ROOT}

RUN echo ${ANDROID_NDK_HOME}

#FROM reginfell/fastlane

#ENV ANDROID_NDK /android-ndk-linux
#ENV NINJA_PATH /ninja
#ENV ANDROID_NDK_HOME /android-ndk-linux
#ENV ANDROID_TARGET_SDK="android-27" \
#	ANDROID_BUILD_TOOLS="build-tools-27.0.3"

#RUN apk update
#RUN apk add unzip \
#	wget
	
#RUN apk add --update --no-cache libstdc++
#RUN wget -q --output-document=ninja-linux.zip https://github.com/ninja-build/ninja/releases/download/v1.6.0/ninja-linux.zip && \
#	unzip ninja-linux.zip && \
#	rm -f ninja-linux.zip

#RUN /ninja
#RUN ninja --version

#RUN wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip && \
#	unzip android-ndk.zip && \
#	rm -f android-ndk.zip && \
#	mv android-ndk-r18b android-ndk-linux

# add to PATH
#ENV PATH ${PATH}:${ANDROID_NDK_HOME}

#RUN ${ANDROID_HOME}/tools/bin/sdkmanager "extras;android;m2repository" "extras;google;m2repository" "extras;google;google_play_services"
#RUN ${ANDROID_HOME}/tools/bin/sdkmanager "cmake;3.6.4111459"
#RUN ${ANDROID_HOME}/tools/bin/sdkmanager 'ndk-bundle' 
