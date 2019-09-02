# Intro to Neural Nets

A neural network is a computing system _loosely_ modeled after biological neural networks.

We will construct a very simple neural network in python with the following components:

 - An input layer **x**
 - A fully connected hidden layer. Fully connected means every neuron in the current layer recieves every neuron of the previous layer as input.
 - An output layer **y**
 - Weights **W** and biases **b**
 - An activation function for each hidden layer

![CNN vs NN](../img/ex_net.png)

The activation is a function that is applied to the scalar of the output of each convolution. Activation functions are used to help the model's gradient descent converge quicker. Here is a graph of the leaky ReLU activation function. The activation function we will use here is called a sigmoid function. This works by squashing numbers between [0,1].

![CNN vs NN](../img/sigmoid.png)
```python 
def sigmoid(x):
    return 1.0/(1+ np.exp(-x))
```

Next, we need the derivative of this function in order to make the model actually learn. This is called _backpropagation_. Check [this](http://cs231n.github.io/optimization-2/) link to learn about backpropagation which is a calculus based operation. 

```python
def sigmoid_derivative(x):
    return x * (1.0 - x)
```

Now, let's define our neural network class.
```python 
class NeuralNetwork:
    def __init__(self, x, y):
        self.input      = x
        self.weights1   = np.random.rand(self.input.shape[1],4) 
        self.weights2   = np.random.rand(4,1)                 
        self.y          = y
        self.output     = np.zeros(y.shape)
```
We will construct the NeuralNetwork object with two pieces of data, or dataset ```x```, and the associated output ```y```. The ```weights1``` is a 2 dimensional array where the number of rows corresponds to the number of columns of our input data and the columns is 4 because there are 4 neurons on our hidden layer. The ```weights2``` the second set of weights that is applied to the four outputs from the hidden layer by the final neuron. 

Now we need a method to pass the input through the model. This is often called "feed-forward."

```python
    def feedforward(self):
        self.layer1 = sigmoid(np.dot(self.input, self.weights1))
        self.output = sigmoid(np.dot(self.layer1, self.weights2))
```

So we can pass the input through the model and get an output, but how do we make the model _learn_? The answer is through bacckpropagation.
```python
def backprop(self):
    # application of the chain rule to find derivative of the loss function with respect to weights2 and weights1
    d_weights2 = np.dot(self.layer1.T, (2*(self.y - self.output) * sigmoid_derivative(self.output)))
    d_weights1 = np.dot(self.input.T,  (np.dot(2*(self.y - self.output) * sigmoid_derivative(self.output), self.weights2.T) * sigmoid_derivative(self.layer1)))

    # update the weights with the derivative (slope) of the loss function
    self.weights1 += d_weights1
    self.weights2 += d_weights2
```

We can wrap all this together and run the script with the following:

```python
if __name__ == "__main__":
    X = np.array([[0,0,1],
                  [0,1,1],
                  [1,0,1],
                  [1,1,1]])
    y = np.array([[0],[1],[1],[0]])
    nn = NeuralNetwork(X,y)

    for i in range(5000):
        nn.feedforward()
        nn.backprop()

    print(nn.output)
```
When you run this function for the 5000 iterations specified by ```range(5000):```, you should get the following output: 
```python
[[0.01050021]
 [0.98786207]
 [0.99237218]
 [0.01088507]]
 ```
This is pretty close to our ground-truth output which was 
```python
[[0]
 [1]
 [1]
 [0]])
```
