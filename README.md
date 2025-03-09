# RoiToon (DEMO)

![Unity Version](https://img.shields.io/badge/Unity-2021.3%2B-blue.svg)
![URP](https://img.shields.io/badge/URP-Required-brightgreen.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

RoiToon is a __high-quality cel-shading character shader for Unity URP.__ Inspired by modern animation-style games, it provides crisp shadows, anime-style highlights, and customizable outlines.

RoiToonは __Unity URP向けの高品質セルシェーディングキャラクターシェーダーです__。現代のアニメスタイルゲームにインスパイアされ、鮮明な影、アニメスタイルのハイライト、カスタマイズ可能なアウトラインを提供します。

__HomePage :__ https://roitoon.com

## Demo vs. Full Version

### Demo Version
<img src="https://i.ibb.co/d4wmrr67/222.png" alt="Demo Version" style="width: 100%; height: auto;">
<img src="https://i.ibb.co/7xLhXM4H/115.png" alt="Demo Version" style="width: 100%; height: auto;">

### Full Version
![Full Version](https://i.ibb.co/RGXzs95P/3333.png)

## Requirements

- Unity 2021.3+
- Universal Render Pipeline
- Shader Model 4.5+

## Key Parameters

### Base Settings
- `Material Type`: Face(0), Hair(1), Clothing(2)
- `Color`: Overall color adjustment
- `Normal Scale`: Normal map intensity

### Shadow Control
- `Shadow Cel Steps`: Number of shadow steps (1-6)
- `Shadow Boundary`: Shadow boundary position
- `Shadow Hardness`: Shadow edge sharpness
- `Shadow Intensity`: Shadow strength

### Highlights
- `Hair Spec Width`: Hair highlight width
- `Hair Spec Sharpness`: Hair highlight definition
- `Specular Sharpness`: Clothing highlight definition
- `Highlight Sharpness`: Face highlight definition

### Outlines
- `Outline Width`: Outline thickness
- `Outline Color`: Outline color
- `Outline View Scale`: View-based thickness adjustment

## FAQ

**Q: Can I use this with Built-in Render Pipeline?**  
A: No, it uses URP-specific features.

**Q: Does it support transparency?**  
A: Yes

**Q: Are there performance issues on mobile?**  
A: Follow optimization tips to adjust parameters accordingly.
