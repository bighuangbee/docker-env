FROM centos:7.6.1810

# 切换到工作目录
WORKDIR /root
#COPY set_env.sh /usr/local/bin/set_env.sh
#RUN chmod +x /usr/local/bin/set_env.sh

RUN yum -y install vim make wget gcc gcc-c++ gtk2 gtk3 unzip

#安装中文字符包
RUN localedef -i zh_CN -f UTF-8 zh_CN.UTF-8 && yum -y install kde-l10n-Chinese glibc-common && localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
ENV LC_ALL=zh_CN.utf8

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:$PATH
ENV LD_LIBRARY_PATH /root/rtc_recognize/face/libs/face_recognize/lib:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH /opt/OpenBLAS/lib:$LD_LIBRARY_PATH

#golang环境
RUN wget https://dl.google.com/go/go1.14.14.linux-amd64.tar.gz
RUN tar -xf go1.14.14.linux-amd64.tar.gz -C /usr/local/
ENV PATH=$PATH:/usr/local/go/bin
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN go env -w GOBIN=/usr/local/go/bin
ENV GO111MODULE=on
ENV GOPATH=/root/go
ENV GOROOT=/usr/local/go
ENV GODEBUG=cgocheck=0

RUN ln -s /root/rtc_recognize/face/libs/OpenBLAS/lib/libopenblas.so  /usr/lib/libblas.so.3
RUN ln -s /root/rtc_recognize/face/libs/OpenBLAS/lib/liblapack.so.3 /usr/lib/liblapack.so.3

#人脸识别
ENV LD_LIBRARY_PATH=$LD_LIBRARY/root/rtc_recognize/face/libs/usr/lib/libblas.so.3/rtc_warper_PATH:/root/rtc_recognize/face/libs/face_recognize/lib
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/rtc_recognize/face/libs/OpenBLAS/lib
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib

#车牌识别
ENV OpenCVHome=/root/rtc_recognize/rtc/libs/openvino_2020.4.287/opencv
ENV InferenceHome=/root/rtc_recognize/rtc/libs/openvino_2020.4.287/deployment_tools
ENV LPRHome=/root/rtc_recognize/rtc/libs/ITS/lib
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/rtc_recognize/rtc/libs/openvino_2020.4.287/opencv/lib
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/rtc_recognize/rtc/libs/openvino_2020.4.287/deployment_tools/inference_engine/lib/intel64
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/rtc_recognize/rtc/libs/openvino_2020.4.287/deployment_tools/inference_engine/external/tbb/lib
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/rtc_recognize/rtc/libs/openvino_2020.4.287/deployment_tools/ngraph/lib
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/rtc_recognize/rtc/libs/ITS/lib

#RTC Recording解码
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/rtc_recognize/rtc/libs/ffmpeg4.3/lib
#ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/rtc_recognize/libs/rtc_warper


COPY opencv4.pc /usr/local/lib/pkgconfig/opencv4.pc
#ENV PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
