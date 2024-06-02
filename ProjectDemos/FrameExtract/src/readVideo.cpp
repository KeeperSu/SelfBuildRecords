#include <iostream>
#include "opencv2/opencv.hpp"

void readVideo(const std::string &videoPath)
{
    std::cout << "Enter readVideo ..." << std::endl;
    std::cout << videoPath << std::endl;
    cv::VideoCapture cap(videoPath);
    if(!cap.isOpened()){
        std::cout << "Read video failed" << std::endl;
        return;
    }
    double totalFrameCnt = cap.get(cv::CAP_PROP_FRAME_COUNT);
    std::cout << "整个视频共" << totalFrameCnt << "帧" << std::endl;
}