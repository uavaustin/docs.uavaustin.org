# Convolutional Neural Networks

A Convolutional Neural Network (CNN) is a type of neural network primarily used for image recognition and classification.
We will explore the basicc building blocks of a CNN built using the platform Darknet. 

Here is an example of a layer in the model.

```md
[convolutional]
batch_normalize=1
filters=16
size=3
stride=1
pad=1
activation=leaky

[maxpool]
size=2
stride=2
```

![CNN](../img/cnn.jpeg)

