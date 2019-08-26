# Introduction

The UAVA Image Rec pipeline operates as follows:

- Aerial imagery is captured from the drone

- The image is sliced into smaller tiles 

- These tiles are sent to a classification network which determines wether an image tiles has a target or not

- Tiles classified with targets are sent to a YOLO object detection model which detects which shape and alphanumeric (A-Z, 0-9 is present

- Detected targets are analyzed for most prominent colors to determine shape and alphanumeric color



The UAVA software stack consists of two main projects, target-finder-model and target-finder.

#### Target-Finder-Model

This portion consists of scripts used to generate data that is used to train our classifier and object detector

#### Target-Finder

This base contains an API used to inference on immages rercieved from the drone-mounted camera.