# Introduction

The UAVA Image Recognition pipeline consists of various steps:

- Aerial imagery is captured from the drone using an RGB camera. The GSD 
(ground sampling distance) can vary, but the drone's altitude is a couple hundred feet,
on average.

- The original images taken can be up to 4k quality. For efficient computation, we slice
the image up into smaller tiles for processing.

- These tiles are sent to a classification network which determines whether a specific
tile has a target or not. This is called binary classification because there are just
two classes.

- Tiles classified with targets are sent to an object detection model which is not only 
able to determine the shape and alphanumeric (A-Z or 0-9), but is also able to
localize, or draw a box, around the target in the tile.

- The detected objects are further processed using single shot learning to determine
their orientation and colors.

The UAVA Image Recognition software stack can be found here:
[[`hawk-eye`](https://github.com/uavaustin/hawk-eye)].