# Convolutional Neural Networks

A Convolutional Neural Network (CNN) is a type of neural network primarily used for image
recognition and classification. We will explore the basic building blocks of a CNN.

Most modern convolutional nets are made up of the same type of layers. The first is the
convolutional filter.

## Filters 

A convolutional filter extracts features from a given input and is motivated by the idea
of efficient (or sparse) parameter sharing during signal analysis (cross correlation).
For now, think of features as abstract components of an image that make sense to the
model. When we see a human face, we instinctually recognize features, but the computer
might see different ones. The following is an example of a _convolutional filter_ applied
to an input matrix.

![CNN](../img/filter.png)

In this image we have a 3x3 filter (9 weights) being applied to our input. The convolution
operation is essentially a weighted linear combination of portions of the input, and these 
weights extract certain features.

In real convolutional networks, we end up with thousands of filters. There are a few more
inputs to the convolutional layer which I'll touch on here:

* `stride`: The number of rows/columns to jump when moving to the next convolution.
* `padding`: Without padding, a convolutional of filter size > 1 will result in an input
size greater than the output. Padding adds a value around the outside of the input so that
the output is a certain size.
* `kernel size`: The kernel does not have to be 3x3 or even square.

## Batch Normalization

Batch normalization (BN) was introducted in a 2015 paper,
[here](https://arxiv.org/pdf/1502.03167.pdf). While BN is still a hotly debated topic 
because people disagree on _why_ it works, most people agree it certainly works. The
idea is to normalize each input by finding the mean and variance. Many think of this as
allowing subsequent levels to not be largely affected by the activations of the previous
level, meaning each level can learn independently. This tends to make training more
stable.


## Activations

The `activation` is a function that is applied to each convolutional output. Activation
functions introduce non-linearities into the models and help the learning process
converge quicker. Here is a graph of the leaky ReLU activation function. Without
activations, a convolutional neural net would actually just be a composition of linear
functions!

![CNN](../img/lrelu.jpg)

The idea here is anything `> 0` remains the same, but anything below 0 is changed to some
factor multiplied by the value.

## Pooling

Pooling is a type of layer with no learnable parameters. This operation is used to
downsample extracted features which can help the model generalize feature associations,
preventing overfitting. Also, this method decreases the amount of parameters, making the
training and inferencing process quicker.

![Max Pooling Image](../img/maxpool.jpeg)

Another commonly used pooling level is average pooling.