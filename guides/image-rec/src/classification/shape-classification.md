# Shape Classification

Now that we've learned about preprocessing and retraining Inception-V3, shape classification is actually a very simply task.
Every contour our edge detection picks up gets checked for arc length and area.
If the contour fits within our defined range of what is "significant", it's sent trimmed and sent to a function for classification.
The function will check our cropped image against the Inception-V3 model and return a number of predictions.
If the top prediction is not "NaS" and has a confidence greater than 85%, we deem it to be a shape and send it through for color classification.

![Triangle](../img/triangle.png)