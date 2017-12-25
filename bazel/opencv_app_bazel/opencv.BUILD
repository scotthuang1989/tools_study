cc_library(
    name = "opencv",
    srcs = glob(["lib/libopencv_highgui.so*",\
                 "lib/libopencv_core.so*",\
                 "lib/libopencv_imgcodecs.so*"]),
    hdrs = glob(["include/**/*.h*"]),
    includes = ["include"],
    visibility = ["//visibility:public"],
    linkstatic = 1,
)
