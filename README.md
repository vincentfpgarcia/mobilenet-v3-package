# MobileNetV3 Swift Package

Swift Package allowing to use the MobileNet V3 model.

## Authors

* Andrew Howard
* Mark Sandler
* Grace Chu
* Liang-Chieh Chen
* Bo Chen
* Mingxing Tan
* Weijun Wang
* Yukun Zhu
* Ruoming Pang
* Vijay Vasudevan
* Quoc V. Le
* Hartwig Adam


## Publication

* [Searching for MobileNetV3](https://arxiv.org/abs/1905.02244)


## Integration

### Step 1: Add the package in XCode

* Open the Swift Package window using the menu `File > Add Packages...`
* In the upper right corner, in the `Search or Enter Package URL` search field, enter the package URL: `https://github.com/vincentfpgarcia/mobilenet-v3-package`
* Wait so that the package is found and click on `Add packages`


### Step 2: Initialize the model

First, the package needs to be imported in the Swift file:

```swift
import MobileNetV3Package
```

Then, the model can be initilized:

```swift
let model = MobileNetV3Package()
```

### Step 3: Use the model

To use the model, we need an input image of size 224x224 pixels. Here, we'll simply open an image from our asset collection: 

```swift
let input = UIImage(named: "some_image")
```

Finally, we can use the model inference with the loaded image to know its class:

```swift
let output = model.predict(input: input)
```
