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
* On the upper right, in the `Search or Enter Package URL` search field, enter the package URL: `https://github.com/vincentfpgarcia/mobilenet-v3-package`


### Step 2: Initialize the model

Use the following Swift code to initilize the model. This line needs be called only once:

```swift
let model = MobileNetV3Package()
```

Make sure `model` is available where you want to use the package.

### Step 3: Use the model

Model inference is done using the following code:

```swift
let input = UIImage(named: "some_image")
let output = model.predict(input: input)
```

Here, we read an image from the assets and pass it to the model as its input. The image reading used here is only used for explanation purpose. In an actual code, one would probably already have an image available.