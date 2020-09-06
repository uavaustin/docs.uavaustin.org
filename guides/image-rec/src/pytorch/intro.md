# Intro to PyTorch

From the [PyTorch website](https://pytorch.org/): 

`"An open source machine learning framework that accelerates the path from research
prototyping to production deployment."`

While TensorFlow was the go-to machine learning framework for quite some time, 
developers of PyTorch (a Facebook platform), saw an opportunity to create a framework
that excelled in the areas where TensorFlow lacked. What the devs created is an
extremely dynamic, user friendly library which enables rapid prototyping.

Let's dive in to some code. We'll rely upon some of the PyTorch docs and tutorials
as they are great resources.

Install the CPU PyTorch package like so. If you have a GPU, you're more than welcome
to install the GPU version.

```sh
python3 -m pip install torch==1.6.0+cpu torchvision==0.7.0+cpu \ 
-f https://download.pytorch.org/whl/torch_stable.html
```

## PyTorch Image Classification

We'll use some built-in packages to load a classification model and perform inference,
and we'll heavily rely on
[this](https://pytorch.org/tutorials/beginner/blitz/cifar10_tutorial.html) tutorial, but
with a couple of adaptations.

The package we installed above, `torchvision`, is an external package maintained by 
PyTorch devs and the open source community. It comes with a variety of items, such as
models architectures, model weights, data, and more.


```python
import torch
import torchvision
from torchvision import transforms

# Define some basic transformations for loading the images. Convolutional nets tend
# to learn better when the inputs of layers are normalized (think batchnorm), so we will
# normalize our input images.
transform = transforms.Compose(
    [transforms.ToTensor(), transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))]
)

# These are the CIFAR-10 classes:
classes = (
    "plane", "car", "bird", "cat", "deer", "dog", "frog", "horse", "ship", "truck"
)

# Load the CIFAR-10 datasets. We have a train set which the model learns from, but we
# also need a set which the model never learns from that we use to monitor progress.
trainset = torchvision.datasets.CIFAR10(root="./data", train=True,
                                        download=True, transform=transform)
testset = torchvision.datasets.CIFAR10(root="./data", train=False,
                                       download=True, transform=transform)
```

Next, we need a method to actually load this data, i.e. some object which will open the
image files, load them into memory, and apply the transformations. In PyTorch, we use
the
[`torch.utils.data.DataLoader`](https://pytorch.org/docs/stable/data.html#torch.utils.data.DataLoader).
Internally, the dataloader calls `__getitem__` on our datasets, a method which can be
implemented for custom datasets, like in the actual UAV code.

```python
# Batch size: How many images to load on each iteration.
# shuffle: Whether or not to shuffle the data. Good for training, not useful for test.
trainloader = torch.utils.data.DataLoader(trainset, batch_size=4, shuffle=True)
testloader = torch.utils.data.DataLoader(testset, batch_size=4, shuffle=False)
```

We have our data, so now we need to make a model to learn from this dataset. We'll 
define model using some of the basic building blocks discussed in the previous section.
The output of this model will be vector of length equal to the number of  classes in the
dataset. The vector values will correspond to which class the model predicts the image
belongs to.

```python
net = torch.nn.Sequential(
    torch.nn.Conv2d(3, 8, 3, stride=1, padding=1),
    torch.nn.MaxPool2d(2),
    torch.nn.Conv2d(8, 16, 3, stride=1, padding=1),
    torch.nn.MaxPool2d(2),
    torch.nn.Conv2d(16, 32, 3, stride=1, padding=1),
    torch.nn.AdaptiveAvgPool2d(1),
    torch.nn.Flatten(),
    torch.nn.Linear(32, len(classes))
)   
```

OK, we have data and a model. Now we need to define the _loss function_ which informs
the model how far away its predictions are from the ground truth. Cross entropy is 
typically used in multi-class classification problems. In general, think of the model
outputting a probability distribution over the given classes, and cross entropy measures
the difference between the predicted and ground truth distributions.

```python3
loss_fn = torch.nn.CrossEntropyLoss()
```

The last piece to the puzzel is a method to update the weights of the model based on
what our `loss_fn` returns. In PyTorch, these are called `optimizers`. There are _many_
optimizers out there, but for simplicity, assume the optimizer simply updates a model
based on information recieved from the `loss_fn`.

```python3
optimizer = torch.optim.Adam(net.parameters(), lr=1.0e-3)
```

Awesome! Now we have all the necessary building blocks to train our own classifier!

## Classifier Training

In just a few lines of code, we will be able to train our model. We will loop over the
`trainloader` to load batches of data, perform a _forward pass_ through the model, call
the `loss_fn` then pass the results through the model using _backpropagation_, and then
update the model's weights.

```python3
for idx, (images, labels) in enumerate(trainloader):

    # Take this for granted, but PyTorch optimizers always keep gradient history unless
    # we manually flush it out.
    optimizer.zero_grad()

    # forward + backward + optimizer step
    outputs = net(images)
    loss = loss_fn(outputs, labels)
    loss.backward()
    optimizer.step()

    # print statistics
    running_loss += loss.item()
    if idx % 100 == 0:
        print(f"Step: {idx}. Loss: {running_loss / 100}.")
        running_loss = 0.0
```

You should start to see the loss values slowly decrease as training goes on! The smaller
the loss, the better the model is doing on the _training data_.

We also like to monitor the model's performance on images that it does not train on.
This is called test or validation data. The code looks like so:

```python3
correct = total = 0
# During training, we want PyTorch to keep a record of how values are computed, i.e., the
# inputs and outputs so we can send information back through the model. Since we are
# only testing the model here, we do not care about keeping this record of the gradients.
with torch.no_grad():
    for images, labels in testloader:
        outputs = net(images)
        _, predicted = torch.max(outputs.data, 1)
        total += labels.size(0)
        correct += (predicted == labels).sum().item()

print(f"Accuracy of the network on the 10000 test images: {100 * correct / total:.4f}")
```

Hopefully, you'll see something like:
`Accuracy of the network on the 10000 test images: 39.5000`.
Not great, but we can continue training to make the model better!

## Summary

By now, you have a basic understanding of the high-level pipeline for training a
classifier using PyTorch. We have skipped over some important aspects to training,
namely backpropogation, but this tends to be the trickiest subject for new students.
There are numerous online resources to learn more about deep learning here:

* [`Stanford CS231n`](9http://cs231n.stanford.edu/)
* [`PyTorch Tutorials`](https://pytorch.org/tutorials/)
* [`Andrew Ng's Video Series`](https://www.youtube.com/channel/UCcIXc5mJsHVYTZR1maL5l9w/playlists)