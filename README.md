# RoiToon

![Unity Version](https://img.shields.io/badge/Unity-2021.3%2B-blue.svg)
![URP](https://img.shields.io/badge/URP-Required-brightgreen.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

RoiToon is a __high-quality cel-shading character shader for Unity URP.__ Inspired by modern animation-style games, it provides crisp shadows, anime-style highlights, and customizable outlines.

RoiToonは __Unity URP向けの高品質セルシェーディングキャラクターシェーダーです__。現代のアニメスタイルゲームにインスパイアされ、鮮明な影、アニメスタイルのハイライト、カスタマイズ可能なアウトラインを提供します。

### Preview
<img src="https://i.ibb.co/d4wmrr67/222.png" alt="Demo Version" style="width: 100%; height: auto;">
<img src="https://i.ibb.co/7xLhXM4H/115.png" alt="Demo Version" style="width: 100%; height: auto;">

## Requirements

- Unity 2021.3+
- Universal Render Pipeline
- Shader Model 4.5+

## Feature

- **Material Type System**: Specialized rendering for Face, Hair, and Clothing
- **Advanced Cel-Shading**: Multi-step shading with customizable boundaries and color
- **Normal Mapping**: Full support for normal maps with adjustable intensity
- **ID Map System**: Control outlines and other effects via ID maps
- **High-Performance**: Optimized for mobile and desktop platforms
- **Custom Shadow Direction**: Override default light direction
- **Shadow Anisotropy**: Direction-based shadow filtering
- **Multi-step Shadows**: Two-level shadow system with adjustable boundaries
- **Shadow Hardness Control**: Adjustable shadow edge softness
- **Ambient Light Integration**: Environment lighting affects shadow colors
- **Blush System**: Texture-based blush with adjustable color and intensity
- **Sub-Surface Scattering**: Simulated light penetration for realistic skin
- **Face Highlights**: Special highlight system for facial features
- **Anisotropic Specular**: Direction-based highlights using flow maps
- **Hair Translucency**: Back-lighting effect for realistic hair rendering
- **Customizable Hair Width**: Control the width of hair highlights
- **Multi-Material System**: Specialized rendering for silk, metal, and leather
- **Detail Normal Mapping**: Add fine details with secondary normal maps
- **Metallic and Smoothness Control**: Adjustable material properties
- **Adaptive Outline System**: Width varies based on depth and viewing angle
- **Outline Color Control**: Customizable outline color with per-material variations
- **ID Map Integration**: Control outline width using ID maps
- **Super-Sampling Anti-Aliasing**: High-quality outlines with reduced artifacts
- **View-Based Outline Width**: Outlines adapt to camera angle
- **Rim Lighting**: Customizable back-light effect with ambient influence
- **SSAA for Effects**: Super-sampling for high-quality rim and outline effects
- **Environment Integration**: Scene lighting affects all shader aspects
- **URP Compatible**: Fully integrated with Unity's Universal Render Pipeline
- **SRP Batcher Support**: Optimized for Single-Pass Rendering
- **Shadow Casting**: Proper shadow casting and receiving

## FAQ

**Q: Can I use this with Built-in Render Pipeline?**  
A: No, it uses URP-specific features.

**Q: Does it support transparency?**  
A: Yes, Only support transparency Render Quene

**Q: Are there performance issues on mobile?**  
A: Follow optimization tips to adjust parameters accordingly.


## Star History

<a href="https://www.star-history.com/#Pyohya/RoiToon&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=Pyohya/RoiToon&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=Pyohya/RoiToon&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=Pyohya/RoiToon&type=Date" />
 </picture>
</a>
