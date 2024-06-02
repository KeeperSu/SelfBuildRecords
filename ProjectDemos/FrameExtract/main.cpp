#include <iostream>
#include "readVideo.h"

int main(int argc, char *argv[])
{
    std::cout << "Program name: " << argv[0] << std::endl;
    std::cout << "Number of arguments: " << argc - 1 << std::endl;
    for (int i = 1; i < argc; ++i) {
        std::cout << "Argument " << i << ": " << argv[i] << std::endl;
    }

    readVideo(argv[1]);
    return 0;
}