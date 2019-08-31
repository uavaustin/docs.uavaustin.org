# Detector Data
For the YOLO object detector, training data consists of training images and corresponding txt files detailing the objects' class and normalized center x and y, width, and height. We'll start by defining the basic constants.

```python
# Project imports
import glob
import os
from PIL import Image

# Define crop sizes
CROP_WIDTH = 416
CROP_HEIGHT = 416

# Define detection image size
DET_WIDTH = 608
DET_HEIGHT = 608

# Amount of overlap between image slices
OVERLAP = 50

# This ratio will help with maintaining aspect ratio
RATIO = DET_WIDTH / CROP_WIDTH

# Define our shape classes
CLASSES = os.environ.get(
    'SHAPE_TYPES',
    'circle,cross,pentagon,quarter-circle,rectangle,semicircle,square,star,'
    'trapezoid,triangle'
).split(',')
```
Our original txt file has the target information in terms of the full image size. We need to make a function that can adjust those coordinates for the image crops. This function will also check if a target is contained in the image slice.

```python
def get_converted_bboxes(x1, y1, x2, y2, data):
    """Find bboxes in coords and convert them to yolo format"""
    bboxes = []

    for shape_desc, bx, by, bw, bh in data:

        if x1 < bx < bx + bw < x2 and y1 < by < by + bh < y2:

            # Yolo3 Format
            # class_idx center_x/im_w center_y/im_h w/im_w h/im_h
            shape_class_idx = CLASSES.index(shape_desc)
            center_x = (bx - x1 + bw / 2) * RATIO / DET_WIDTH
            center_y = (by - y1 + bh / 2) * RATIO / DET_HEIGHT
            width = bw * RATIO / DET_WIDTH
            height = bh * RATIO / DET_HEIGHT

            bboxes.append((shape_class_idx,
                          center_x, center_y,
                          width, height))

    return bboxes
```
Next, we need to crop the original image and create the training data. This function slices the image, checks for targets, and then saves the target txts. We do not save slices without targets because and object detector must have a class in the image.
```python
def create_detector_data(dataset_name, dataset_path, image_name, image, data):
    """Generate data for the detector model"""
    full_width, full_height = image.size

    k = 0

    for y1 in range(0, full_height - CROP_HEIGHT, CROP_HEIGHT - OVERLAP):

        for x1 in range(0, full_width - CROP_WIDTH, CROP_WIDTH - OVERLAP):

            y2 = y1 + CROP_HEIGHT
            x2 = x1 + CROP_WIDTH

            cropped_bboxes = get_converted_bboxes(x1, y1, x2, y2, data)

            if len(cropped_bboxes) == 0:
                # discard crop b/c no shape
                continue

            k += 1

            cropped_img = image.crop((x1, y1, x2, y2))
            cropped_img = cropped_img.resize((DET_WIDTH, DET_HEIGHT))

            name = '{}_crop{}'.format(image_name, k)
            bbox_fn = os.path.join(dataset_path, name + '.txt')
            image_fn = os.path.join(os.getcwd(), dataset_path, name + '.png')
            list_fn = '{}_list.txt'.format(dataset_name)
            list_path = os.path.join(dataset_path, list_fn)

            cropped_img.save(image_fn)

            with open(bbox_fn, 'w') as label_file:
                for bbox in cropped_bboxes:
                    label_file.write('{} {} {} {} {}\n'.format(*bbox))

            with open(list_path, 'a') as list_file:
                list_file.write(image_fn + "\n")

```
Lastly, a function to create the cropped data folders, read in the image data, and call the function above.
```python
def convert_data(img_path):

    # Get paths to new images and image dir
    new_dataset = os.path.join(os.getcwd(),'imgs')
    new_images_path = os.path.join(os.getcwd(), new_dataset, 'detector_imgs')

    os.makedirs(new_images_path, exist_ok=True)

    label_fn = img_path.replace('.jpg', '.txt')

    image_data = []
 
    with open(label_fn, 'r') as label_file:
        for line in label_file.readlines():
            shape_desc, x, y, w, h = line.strip().split(' ')
            x, y, w, h = int(x), int(y), int(w), int(h)
            image_data.append((shape_desc, x, y, w, h))

    image_name = os.path.basename(img_path).replace('.jpg', '')

    create_detector_data(new_dataset,
                            new_images_path,
                            image_name,
                            Image.open(img_path),
                            image_data)
```
We can run the script by placing the following line in the script:

```python
if __name__ == "__main__":
    convert_data('/path/to/img')
```
