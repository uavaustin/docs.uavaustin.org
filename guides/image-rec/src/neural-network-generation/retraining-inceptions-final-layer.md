# Retraining Inception's Final Layer

As we learned in a previous section, the actual classification of an image does not happen until the fully connected and softmax layers at the end.
This means we can use the Inception-V3 model to extract all the features of our image and retrain the final layer to fit our dataset.
There's even a handy Python script (retrain.py) that will do all the heavy lifting for us.
All we need to do is generate our training data and run the following command:

```shell
$ sudo python absolute//path//to//retrain.py --bottleneck_dir=//absolute//path//to//bottleneck_dir --output_graph=absolute//path//to//output_graph.pb --output_labels=absolute//path//to//output_labels.txt --image_dir=absolute//path//to//training_data_dir --how_many_training_steps=8000
```

Or, for Windows:
```shell
> python absolute//path//to//retrain.py --bottleneck_dir=//absolute//path//to//bottleneck_dir --output_graph=absolute//path//to//output_graph.pb --output_labels=absolute//path//to//output_labels.txt --image_dir=absolute//path//to//training_data_dir --how_many_training_steps=8000
```

_Note: The bottleneck_dir will create itself as whatever folder you specify.
It does not need to already exist.
Same goes for the output graph and labels._

This process will take, on average, about 4-6 hours.
It will create a directory on your computer full of bottleneck folders and it will take up a lot of space.
These bottleneck files will contain a set of values good enough to distinguish between all the classes it's been asked to recognize.
Your training data will be split up so that the majority of it is used for training and a small set of images are run through after training is complete to test accuracy.

When the process is done, you will see two values in your terminal: Training accuracy and validation accuracy.
Training accuracy is calculated by running ALL images through the newly retrained model and finding the percentage that were correctly classified.
Validation accuracy only looks at the images that were NOT used for training and finds the percentage correctly classified.
If you have high training accuracy and low validation accuracy your model is likely overfitting.