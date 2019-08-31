# Intro to Neural Nets

A neural network is a computing system _loosely_ modeled after biological neural networks.

```math
y=\sum_{i=1}^n g(x_i)
```
We will construct a very simple neural network in python with the following components:

 - An input layer **x**
 - A fully connected hidden layer. Fully connected means every neuron in the current layer recieves every neuron of the previous layer as input.
 - An output layer **y**
 - Weights **W** and biases **b**
 - An activation function for each hidden layer

![CNN vs NN](../img/ex_net.png)


```python 
class NeuralNetwork:
    def __init__(self, x, y):
        self.input      = x
        self.weights1   = np.random.rand(self.input.shape[1],4) 
        self.weights2   = np.random.rand(4,1)                 
        self.y          = y
        self.output     = np.zeros(y.shape)
```
