
# Image Recognition

## Code

### Target Finder
[GitHub](https://github.com/uavaustin/target-finder)
* Training, tuning, and optimizing models
* Misc recognition experiments
* Processing and generating image data
* Python3, OpenCV, TensorFlow

### Target Finder Model
[GitHub](https://github.com/uavaustin/target-finder-model)
* Pre-processing for actual image data
* An [inference-only](https://blogs.nvidia.com/blog/2016/08/22/difference-deep-learning-training-inference-ai/) interface for running images 
* An API for the [Orchestra](http://docs.uavaustin.org/guides/architecture/stack/orchestra.html) Image Rec service to use
* Python3, TensorFlow, TensorRT

## History

### ? - Spring 2018

A collections of [scripts](https://github.com/uavaustin/Image-Recognition) written in MATLAB and Python which use a variety of techniques to classify target images. 

* Targets found with [Canny edge detection](https://en.wikipedia.org/wiki/Canny_edge_detector)
* Shapes classified via [TensorFlow](https://www.tensorflow.org/)
* Characters found with [Tesseract](https://pypi.org/project/pytesseract/)
* Trained on a minimal artificially generated training data
* Inference speed: Very Fast

### Fall 2018 - Spring 2019

Using [Object Detection](https://towardsdatascience.com/object-detection-simplified-e07aa3830954) to find and classify targets. Mainly based on [Darknet](https://pjreddie.com/darknet/) model implementations.

* Shapes and characters found simultaneously with [YOLOv3](https://pjreddie.com/darknet/yolo/) 
* A small convolutional classifier is used to narrow down where shapes might be
* Primary colors found by clustering RGB values
* Trained on a significant amount of near-realistic semi-artificial training data
* Inference speed: Slow

### Fall 2019 - Current
  
Replaced Darknet with TensorFlow and [TensorRT](https://developer.nvidia.com/tensorrt). 
* Interchangeable models (although primarily [FasterRCNN](https://arxiv.org/abs/1506.01497))
* Hardware-specific model optimization
* Interence speed: Fast, thanks to a [Jetson Xavier](https://developer.nvidia.com/embedded/jetson-agx-xavier-developer-kit)