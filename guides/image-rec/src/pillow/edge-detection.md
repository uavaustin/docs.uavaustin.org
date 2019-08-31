# Classifier Data
So now we have our background image with an artificial target on it. We need to generate the data to train our classifier. Darknet needs the training images to be labeled as follows: ```//path//to//image//index_classid.ext```. For our purposes we have two classification classes, target (index = 0) and background (index = 1).

Our models cannot look at an approximatly 4000x2000 pixel image without downsampling. Either we could downsample the image to a size more digestible for a model, like 800x800, or we can slice up the larger image into smaller tiles. We will do the former because downsampling the image would make the targets way too small. 

Let's slice up our larger image into out two different categories, target and background.

```python 

```
