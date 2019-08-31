# Classifier Data
So now we have our background image with an artificial target on it. We need to generate the data to train our classifier. Darknet needs the training images to be labeled as follows: ```//path//to//image//index_classid.ext```. For our purposes we have two classification classes, target (index = 0) and background (index = 1).

Our models cannot look at an approximatly 4000x2000 pixel image without downsampling. Either we could downsample the image to a size more digestible for a model, like 800x800, or we can slice up the larger image into smaller tiles. We will do the former because downsampling the image would make the targets way too small. 

Let's slice up our larger image into out two different categories, target and background. If the slice contains the target, then we want that image to be separated as a target-containing image and the others background.

We need to define some constansts that we will use to create the training data:

```python
# Program imports
import os
import random
from PIL import Image

# Define crop sizes
CROP_WIDTH = 416
CROP_HEIGHT = 416

# Size of the classification data
CLF_WIDTH = 416
CLF_HEIGHT = 416

# Amount of overlap between image slices
OVERLAP = 50

# Set the two classification types
CLASSES = ['background', 'shape_target']
```

First, let's make a function to check wether or not a target is inside the image slice or not. This function needs to take in the target and tile dimensions.

```python 
def contains_shape(x1, y1, x2, y2, data):

    for shape_desc, bx, by, bw, bh in data:

        if x1 < bx < bx + bw < x2 and y1 < by < by + bh < y2:
            return True

    return False
```

Second, we need a function to slice up the image and also call the ``` contains_shape``` function we made.

```python
def create_clf_data(dataset_name, dataset_path, image_name, image, data):
    """Generate data for the classifier model"""
    full_width, full_height = image.size
    # Empty list to store background and shape crops
    backgrounds = []
    shapes = []
    # Cycle through ccrops
    for y1 in range(0, full_height - CROP_HEIGHT, CROP_HEIGHT - OVERLAP):

        for x1 in range(0, full_width - CROP_WIDTH, CROP_WIDTH - OVERLAP):

            y2 = y1 + CROP_HEIGHT
            x2 = x1 + CROP_WIDTH
            # Crop
            cropped_img = image.crop((x1, y1, x2, y2))
            # Resize for classification size
            cropped_img = cropped_img.resize((CLF_WIDTH, CLF_HEIGHT))
            # Check if shape inside crop
            if contains_shape(x1, y1, x2, y2, data):
                shapes.append(cropped_img) 
            else:
                backgrounds.append(cropped_img)
                
    # Keep classes balanced and randomize data
    num_data = min(len(backgrounds), len(shapes))
    random.shuffle(backgrounds)
    random.shuffle(shapes)
    # Path where we will write path to image crops
    list_fn = os.path.join(dataset_path,
                            '{}_list.txt'.format(dataset_name))

    for i in range(num_data):

        shape_fn = '{}_{}_{}.png'.format(CLASSES[1], image_name, i)
        shape_path = os.path.join(os.getcwd(), dataset_path, shape_fn)

        bg_fn = '{}_{}_{}.png'.format(CLASSES[0], image_name, i)
        bg_path = os.path.join(os.getcwd(), dataset_path, bg_fn)

        shapes[i].save(shape_path)
        backgrounds[i].save(bg_path)

        with open(list_fn, 'a') as list_file:
            list_file.write(shape_path + "\n")
            list_file.write(bg_path + "\n")
```
Third, let's make a function to do a couple things:

 - Create folders to save our image slices
 - Collect the target information in the image from the txt
 - Pass all aforementioned information into our ```create_clf_data``` function

```python
def convert_data(img_path):
    # Get paths to new images and image dir
    new_dataset = os.path.join(os.getcwd(),'imgs')
    new_images_path = os.path.join(os.getcwd(), new_dataset, 'clf_imgs')

    os.makedirs(new_images_path, exist_ok=True)
    # Get txt for image
    label_fn = img_path.replace('.jpg', '.txt')

    image_data = []
    # Read in target information for this image
    with open(label_fn, 'r') as label_file:
        for line in label_file.readlines():
            shape_desc, x, y, w, h = line.strip().split(' ')
            x, y, w, h = int(x), int(y), int(w), int(h)
            image_data.append((shape_desc, x, y, w, h))

    image_name = os.path.basename(img_path).replace('.jpg', '')
    # Create the data!
    create_clf_data(new_dataset,
                    new_images_path,
                    image_name,
                    Image.open(img_path),
                    image_data)
```
These three functions constitute our classification data generation script. We can tell the python interpreter to run```convert_data(img)``` by the following:

```python 
if __name__ == '__main__':
    convert_data('/path/to/img')
```

If we run this script, the python interpreter sets the global variable ```__name__``` to ```__main__```, therefore we can control how the file executes with the lines above. 
