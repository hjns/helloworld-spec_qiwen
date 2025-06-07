## A brief analysis of the concepts of YUV and RGB in video encoding and decoding

### Preface

The emergence of YUV is to solve the compatibility problem between black and white TV and color TV. In the past, black and white TV only had Y (grayscale value), and UV was regarded as chromaticity. Adding UV signal made it a color TV.

### 1. RGB color space

RGB is the three primary colors of red, green and blue. Any color can be mixed with these three primary colors in different proportions. The range of the three components is usually 8 bits. When all three components are 0, it means pure black; when all three components are 255, it means white.

### 2. YUV color space

YUV is a color representation method used in television systems. Y represents brightness; U and V represent two aspects of color chromaticity, which are signals sampled from red and blue respectively; YUV color sampling representation is a sampling representation method for motion image coding

### 3. Conversion between RGB and YUV

Both color representations can represent colors, and they can be converted to each other. They can be converted through certain formulas
```
Y =  0.299R  + 0.587G  + 0.114B
U = -0.1687R - 0.3313G + 0.5B    + 128
V =  0.5R    - 0.4187G - 0.0813B + 128
```

### IV. Video sampling and loss

From the perspective of video acquisition and processing, the code stream output by general video acquisition chips is generally in the form of YUV data stream, and from the perspective of video processing (such as H.264, MPEG video codec), it is also encoded and parsed in the original YUV code stream; if the acquired resource is RGB, it also needs to be converted to YUV. There are two major types of YUV formats: planar and packed

Difference: planar format: first store the Y of all pixels continuously, then store all U and V

packed format: the YUV of all pixels is stored continuously and crosswise

### 5. YUV sampling format

Reduce the sampling rate of UV, but will not reduce the visual quality, because the human eye is highly sensitive to brightness and less sensitive to color information, so the sampling of UV can be reduced

#### YUV 4:4:4 sampling

It means that the sampling ratio of the three components is the same. In the generated image, each component of the pixel is 8 bits, and the size of each pixel is 24 bits

```
Assuming the image sample is: [Y0 U0 V0][Y1 U1 V1][Y2 U2 V2]
Then the sampled byte stream is: Y0 U0 V0 Y1 U1 V1 Y2 U2 V2
```

#### YUV 4:2:2 sampling

```
Each time a pixel is sampled, its Y component will be sampled, and the U and V components will be sampled one by one.
Assuming the image sample is: [Y0 U0 V0][Y1 U1 V1][Y2 U2 V2]
Then the sampled byte stream is: Y0 U0 Y1 V1 Y2 U2
```

#### YUV 4:2:0 sampling

```
YUV 4:2:0 sampling does not mean sampling only the U component or the V component. Instead, it means that when scanning each line, only one chroma component (U or V) is scanned, and the Y component is sampled in a 1:2 manner. For example, in the first line, the Y component and the U component are sampled, and the ratio is 2:1, and the V component is not sampled; the second line samples the Y component and the V component, and the ratio is 2:1, and the U component is not sampled. Repeat the following, and so on.
Assume that the image pixels are
[Y0 U0 V0][Y1 U1 V1][Y2 U2 V2][Y3 U3 V3]
[Y4 U4 V4][Y5 U5 V5][Y6 U6 V6][Y7 U7 V7]
Then the sampled code stream is:
Y0 U0 Y1 Y2 U2 Y3 Y4 Y5 Y6 V6 Y7
```

