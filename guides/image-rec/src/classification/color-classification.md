# Color Classification

If we were able to apply a mask to the original image, we should have a cropped image with no background colors to mess with color detection.
If the contour wasn't closed, we need to crop the image tightly to try and remove as much of the background as possible.
The edited image is run through a k-means clustering algorithm to find the three most prominent colors.
This algorithm finds _K_ significant RGB values in an image; In this case, K is three.
Once we have the to most significant RGB values, we compare them against a list of colors we have defined to see which one they are closest to.
If any of the colors come back as pure black, they are part of the mask and are removed.
The top result of the remaining colors is classified as the shape color, and the second result is classified as the alpha color.