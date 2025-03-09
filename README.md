# RioToon URP Shader (DEMO)

![Unity Version](https://img.shields.io/badge/Unity-2021.3%2B-blue.svg)
![URP](https://img.shields.io/badge/URP-Required-brightgreen.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

Anime-style cel-shading character system for Unity URP.

## Demo vs. Full Version

### Demo Version
<img src="https://i.ibb.co/d4wmrr67/222.png" alt="Demo Version" style="width: 100%; height: auto;">
<img src="https://i.ibb.co/7xLhXM4H/115.png" alt="Demo Version" style="width: 100%; height: auto;">

### Full Version
![Full Version](https://i.ibb.co/RGXzs95P/3333.png)

## Installation

1. Import package
2. Verify URP settings
3. Check sample materials

## Requirements

- Unity 2021.3+
- Universal Render Pipeline
- Shader Model 4.5+

## Texture Setup

| Texture | Channel Configuration | Purpose |
|---------|----------------------|---------|
| Main Texture | RGB | Base color |
| LightMap | R: AO, G: Shadow, B: Spec, A: Rim | Main lighting control |
| Normal Map | RGB | Surface normals |
| ID Map | R | Outline/area control |
| Hair Flow Map | RG: Direction, B: Length | Hair highlight control |
| Cloth Map | R: Silk, G: Metal, B: Leather | Clothing material control |

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

## Optimization Tips

- Mobile: Shadow Cel Steps 2-3, reduce sampling
- Console/PC: Shadow Cel Steps 3-5, default sampling
- Multiple characters: Reduce outline sampling

## Usage Examples

```csharp
// Change shadow steps at runtime
material.SetFloat("_ShadowCelSteps", 4);

// Adjust highlight sharpness
material.SetFloat("_SpecularSharpness", 25);

// Modify outline width
material.SetFloat("_OutlineWidth", 0.002f);
```

## FAQ

**Q: Can I use this with Built-in Render Pipeline?**  
A: No, it uses URP-specific features.

**Q: Does it support transparency?**  
A: The base version only supports opaque rendering.

**Q: Are there performance issues on mobile?**  
A: Follow optimization tips to adjust parameters accordingly.
