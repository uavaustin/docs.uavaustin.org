# Convolutional Neural Networks

A Convolutional Neural Network (CNN) is a type of neural network primarily used for image recognition and classification.
We will explore the basic building blocks of a CNN built using the platform Darknet. 

Here is an example of a fundemental layer in a darknet classification model.

```ini
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

Seems pretty simple, right? Let's dive deeper.

First, `[convolutional]` and `[maxpool]` are just names used to tell Darknet what layers we are going to construct.

### Filters 

A filter is the fundemental block of our convolutional layer; it does all the heavy lifting.

![CNN](../img/filter.png)

Here `filters = 16` means we will be convolving with 16 different filters. Each filter will have a 3x3 kernel size, convolutional stride of 1, and padding of 1 around the image. Here is a picture of a filter acting on an input layer. The stride determine how far over the filter shifts after convolution. Pad means adding rows of 0's to the top and bottom and columns of 0's to the left and right of the input layers. This helps to preserve image size to our layers don't get too small undesirably quickly. 

The `activation` is a function that is applied to the scalar of the output of each convolution. Activation functions are used to help the model's gradient descent converge quicker. Here is a graph of the leaky ReLU activation function.

![CNN](../img/lrelu.jpg)

### Batch Normalization

Batch normalization is a step which normalizes the output of convolutional layers in order to help the model train. When the activations of layers are not normalized, between different layers, The activations can vary significantly between different layers if they are not normalized, taking longer to train the model.  For more information, [here](https://arxiv.org/pdf/1502.03167.pdf) is a link to the original batch normalization paper.

### Max Pooling 

Max pooling is a type of layer with no learnable parameters. This operations is used to down-sample features extracted which can help the model generalize feature associations which prevents overfitting. Also, this method decreases the amount of parameters, making the training and inferencing process quicker.

![Max Pooling Image](../img/maxpool.jpeg)