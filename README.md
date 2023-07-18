# MobileNetV3 Swift Package


## Description

Swift Package allowing to use the MobileNet V3 model.


## How to use the package

### Step 1: Add the package in XCode

* Open the Swift Package window using the menu `File > Add Packages...`
* In the search field located in the upper right corner, enter the package's URL: `https://github.com/vincentfpgarcia/mobilenet-v3-package`
* Then click on `Add packages`

### Step 2: Initialize the model

First, the package needs to be imported:

```swift
import MobileNetV3Package
```

Then, initialize the model:

```swift
let model = MobileNetV3Package()
```

### Step 3: Use the model

To use the model, we need an input image of size 224x224 pixels. Bellow, as a placeholder, we load an image from the asset collection:

```swift
let input = UIImage(named: "some_image")
```

Finally, we can use the model with the loaded image to know its class:

```swift
let output = model.predict(input: input)
```


## Related paper

* [Searching for MobileNetV3](https://arxiv.org/abs/1905.02244)


## Paper authors

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
