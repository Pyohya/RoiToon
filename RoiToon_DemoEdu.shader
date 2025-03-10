/*
=== RoiToon - Demo Version ===

ENGLISH:
This demo version of RoiToon Character Shader is provided for evaluation purposes. You are permitted to:
- Use this shader in personal or commercial projects
- Modify the shader for your own use

You are NOT permitted to:
- Redistribute modified versions of this shader
- Rebrand or resell this shader or derivatives
- Remove this license notice

The full version with advanced features will be available for purchase starting April 2025.
For licensing inquiries or to purchase the full version when available: [Close]

JAPANESE:
このデモ版のRoiToonキャラクターシェーダーは評価目的で提供されています。

許可されていること:
- 個人または商用プロジェクトでこのシェーダーを使用すること
- 自分の用途に合わせてシェーダーを改変すること

許可されていないこと:
- 改変したバージョンを再配布すること
- このシェーダーや派生物を別の名前で販売または再販すること
- 本ライセンス通知を削除すること

高度な機能を備えた完全版は、2025年4月より販売開始予定です。
ライセンスに関するお問い合わせや、完全版の購入については [Close] までご連絡ください。

KOREAN:
RoiToon 캐릭터 셰이더 데모 버전은 평가 목적으로 제공됩니다. 다음과 같은 사용이 허용됩니다:
- 개인 또는 상업 프로젝트에서 이 셰이더 사용
- 개인 사용을 위한 셰이더 수정

다음과 같은 사용은 허용되지 않습니다:
- 수정된 버전의 셰이더 재배포
- 이 셰이더 또는 파생물의 리브랜딩 또는 재판매
- 이 라이센스 고지 제거

고급 기능이 포함된 전체 버전은 2025년 4월부터 구매 가능합니다.
라이센스 문의 또는 전체 버전 구매: [Close]

CHINESE:
RoiToon角色着色器演示版本仅供评估目的。您可以：
- 在个人或商业项目中使用此着色器
- 为个人使用修改着色器

您不得：
- 重新分发修改后的着色器版本
- 重新品牌化或转售此着色器或其衍生品
- 删除此许可声明

包含高级功能的完整版本将从2025年4月开始销售。
如需许可证咨询或购买完整版本：[Close]

© 2025 RoiToon Studios (Pyohya) - All Rights Reserved
*/
Shader "RoiToonDemo/CharacterShader"
{
    Properties
    {
        [Header(Material Type)]
        [Enum(Face,0,Hair,1,Clothing,2)] _MaterialType ("Material Type", Int) = 2
        
        [Header(Base Maps)]
        _MainTex ("Albedo", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _LightMap ("LightMap (R:AO G:Shadow B:Spec A:Rim)", 2D) = "white" {}
        _IDMap ("ID Map", 2D) = "black" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _NormalScale ("Normal Scale", Range(0, 1)) = 0.8
        
        [Header(Cel Shading)]
        _BrightColor ("Bright Color", Color) = (1,1,1,1)
        _ShadowColor ("Shadow Color", Color) = (0.85,0.85,0.95,1)
        _DarkShadowColor ("Dark Shadow Color", Color) = (0.75,0.75,0.85,1)
        _ShadowBoundary1 ("Primary Shadow Boundary", Range(0, 1)) = 0.55
        _ShadowBoundary2 ("Secondary Shadow Boundary", Range(0, 1)) = 0.35
        _ShadowHardness ("Shadow Edge Hardness", Range(0, 1)) = 0.6
        _ShadowIntensity1 ("Primary Shadow Intensity", Range(0, 1)) = 0.7
        _ShadowIntensity2 ("Secondary Shadow Intensity", Range(0, 1)) = 0.6
        _ShadowAmbientInfluence ("Shadow Ambient Influence", Range(0, 1)) = 0.3
        
        [Header(Shadow Direction)]
        [Toggle(_CUSTOM_SHADOW_DIR)] _UseCustomShadowDir ("Use Custom Shadow Direction", Float) = 0
        _ShadowDir ("Shadow Direction", Vector) = (0, 1, 0, 0)
        _ShadowDirInfluence ("Custom Direction Influence", Range(0, 1)) = 0.7
        _AnisotropicFilter ("Shadow Anisotropic Filter", Range(0, 1)) = 0.7
        _ShadowSteps ("Shadow Steps", Range(1, 10)) = 2
        _ShadowBlur ("Shadow Blur", Range(0, 1)) = 0.4
        
        [Header(Face Features)]
        [Toggle(_FACE_FEATURES)] _UseFaceFeatures ("Enable Face Features", Float) = 0
        _BlushMap ("Blush Map", 2D) = "black" {}
        _BlushColor ("Blush Color", Color) = (1,0.6,0.6,1)
        _BlushIntensity ("Blush Intensity", Range(0, 1)) = 0.5
        _SSSMap ("SSS Map", 2D) = "black" {}
        _SSSColor ("SSS Color", Color) = (1,0.6,0.6,1)
        _SSSIntensity ("SSS Intensity", Range(0, 1)) = 0.6
        _SSSScale ("SSS Scale", Range(0, 10)) = 6
        _HighlightBrightness ("Highlight Brightness", Range(0, 2)) = 1.2
        
        [Header(Hair Features)]
        [Toggle(_HAIR_FEATURES)] _UseHairFeatures ("Enable Hair Features", Float) = 0
        _HairFlowMap ("Hair Flow Map (RG: Direction B: Length)", 2D) = "black" {}
        _HairSpecColor ("Hair Specular Color", Color) = (1,1,1,1)
        _HairSpecIntensity ("Hair Specular Intensity", Range(0, 10)) = 2.5
        _HairSpecWidth ("Hair Specular Width", Range(0.1, 10)) = 2.5
        _HairSpecularOffset ("Hair Specular Offset", Range(-1, 1)) = 0
        _HairTranslucency ("Hair Translucency", Range(0, 1)) = 0.6
        
        [Header(Clothing Features)]
        [Toggle(_CLOTH_FEATURES)] _UseClothFeatures ("Enable Clothing Features", Float) = 0
        _ClothMap ("Cloth Map (R: Silk G: Metal B: Leather)", 2D) = "black" {}
        _DetailNormalMap ("Detail Normal Map", 2D) = "bump" {}
        _DetailNormalScale ("Detail Normal Scale", Range(0, 1)) = 0.4
        _DetailTiling ("Detail Tiling", Float) = 8
        _MetallicIntensity ("Metallic Intensity", Range(0, 1)) = 0.5
        _SmoothnessIntensity ("Smoothness Intensity", Range(0, 1)) = 0.6
        
        [Header(Back Rim Light)]
        _RimColor ("Rim Base Color", Color) = (1,1,1,1)
        _RimPower ("Rim Power", Range(1, 20)) = 6
        _RimIntensity ("Rim Intensity", Range(0, 10)) = 2.5
        _RimThreshold ("Rim Threshold", Range(0, 1)) = 0.4
        _RimLightAlign ("Rim Light Alignment", Range(0, 1)) = 0.6
        _RimAmbientInfluence ("Rim Ambient Influence", Range(0, 1)) = 0.4
        _RimSampleCount ("Rim SSAA Sample Count", Range(1, 16)) = 10
        _RimSampleRadius ("Rim SSAA Sample Radius", Range(0.1, 3.0)) = 1.5
        
        [Header(Environment)]
        _EnvInfluence ("Environment Influence", Range(0, 1)) = 0.85
        _DarknessThreshold ("Darkness Threshold", Range(0, 0.5)) = 0.35
        
        [Header(Outline)]
        _OutlineColor ("Outline Color", Color) = (0.15,0.15,0.2,1)
        _OutlineWidth ("Outline Base Width", Range(0, 0.01)) = 0.0015
        _OutlineDepthFactor ("Outline Depth Scale", Range(0, 1)) = 0.4
        _OutlineIDInfluence ("ID Map Outline Influence", Range(0, 1)) = 0.4
        _OutlineViewScale ("View-Based Scale", Range(0, 1)) = 0.4
        _OutlineSampleCount ("Outline SSAA Samples", Range(1, 16)) = 10
        _OutlineSampleRadius ("Outline SSAA Radius", Range(0.1, 2.0)) = 1.5
        _OutlineSmoothness ("Outline Smoothness", Range(0, 1)) = 0.7
    }
    
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry" "RenderPipeline"="UniversalPipeline" }
        
        Pass
        {
            Name "ForwardLit"
            Tags { "LightMode"="UniversalForward" }
            
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma shader_feature_local _CUSTOM_SHADOW_DIR
            #pragma shader_feature_local _FACE_FEATURES
            #pragma shader_feature_local _HAIR_FEATURES
            #pragma shader_feature_local _CLOTH_FEATURES
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            
            struct Attributes {
                float4 positionOS : POSITION;
                float3 normalOS   : NORMAL;
                float4 tangentOS  : TANGENT;
                float2 uv         : TEXCOORD0;
                float4 color      : COLOR;
            };
            
            struct Varyings {
                float4 positionCS   : SV_POSITION;
                float2 uv           : TEXCOORD0;
                float3 positionWS   : TEXCOORD1;
                float3 normalWS     : TEXCOORD2;
                float3 tangentWS    : TEXCOORD3;
                float3 bitangentWS  : TEXCOORD4;
                float3 viewDirWS    : TEXCOORD5;
                float4 shadowCoord  : TEXCOORD6;
                float4 color        : TEXCOORD7;
                float4 screenPos    : TEXCOORD8;
            };
            
            TEXTURE2D(_MainTex);            SAMPLER(sampler_MainTex);
            TEXTURE2D(_LightMap);           SAMPLER(sampler_LightMap);
            TEXTURE2D(_IDMap);              SAMPLER(sampler_IDMap);
            TEXTURE2D(_NormalMap);          SAMPLER(sampler_NormalMap);
            TEXTURE2D(_BlushMap);           SAMPLER(sampler_BlushMap);
            TEXTURE2D(_SSSMap);             SAMPLER(sampler_SSSMap);
            TEXTURE2D(_HairFlowMap);        SAMPLER(sampler_HairFlowMap);
            TEXTURE2D(_ClothMap);           SAMPLER(sampler_ClothMap);
            TEXTURE2D(_DetailNormalMap);    SAMPLER(sampler_DetailNormalMap);
            
            CBUFFER_START(UnityPerMaterial)
                float4 _MainTex_ST;
                float4 _DetailNormalMap_ST;
                float4 _Color;
                float _MaterialType;
                float _NormalScale;
                
                float4 _BrightColor;
                float4 _ShadowColor;
                float4 _DarkShadowColor;
                float _ShadowBoundary1;
                float _ShadowBoundary2;
                float _ShadowHardness;
                float _ShadowIntensity1;
                float _ShadowIntensity2;
                float _ShadowAmbientInfluence;
                
                float4 _ShadowDir;
                float _ShadowDirInfluence;
                float _AnisotropicFilter;
                float _ShadowSteps;
                float _ShadowBlur;
                
                float4 _BlushColor;
                float _BlushIntensity;
                float4 _SSSColor;
                float _SSSIntensity;
                float _SSSScale;
                float _HighlightBrightness;
                
                float4 _HairSpecColor;
                float _HairSpecIntensity;
                float _HairSpecWidth;
                float _HairSpecularOffset;
                float _HairTranslucency;
                
                float _DetailNormalScale;
                float _DetailTiling;
                float _MetallicIntensity;
                float _SmoothnessIntensity;
                
                float4 _RimColor;
                float _RimPower;
                float _RimIntensity;
                float _RimThreshold;
                float _RimLightAlign;
                float _RimAmbientInfluence;
                float _RimSampleCount;
                float _RimSampleRadius;
                
                float _EnvInfluence;
                float _DarknessThreshold;
                
                float4 _OutlineColor;
                float _OutlineWidth;
                float _OutlineDepthFactor;
                float _OutlineIDInfluence;
                float _OutlineViewScale;
                float _OutlineSampleCount;
                float _OutlineSampleRadius;
                float _OutlineSmoothness;
            CBUFFER_END
            
            static const float2 POISSON_DISK_16[16] = {
                float2(-0.94201624, -0.39906216),
                float2(0.94558609, -0.76890725),
                float2(-0.09418410, -0.92938870),
                float2(0.34495938, 0.29387760),
                float2(-0.91588581, 0.45771432),
                float2(-0.81544232, -0.87912464),
                float2(-0.38277543, 0.27676845),
                float2(0.97484398, 0.75648379),
                float2(0.44323325, -0.97511554),
                float2(0.53742981, -0.47373420),
                float2(-0.26496911, -0.41893023),
                float2(0.79197514, 0.19090188),
                float2(-0.24188840, 0.99706507),
                float2(-0.81409955, 0.91437590),
                float2(0.19984126, 0.78641367),
                float2(0.14383161, -0.14100790)
            };
            
            float2 rotateUV(float2 uv, float rotation) {
                float s = sin(rotation);
                float c = cos(rotation);
                float2x2 rotMatrix = float2x2(c, -s, s, c);
                uv -= 0.5;
                uv = mul(rotMatrix, uv);
                uv += 0.5;
                return uv;
            }
            
            float3 calculateSoftenedAnisotropicSpecular(float3 normalWS, float3 tangentWS, float3 bitangentWS, 
                                               float3 viewDirWS, float3 lightDirWS, float2 flowDir, 
                                               float specWidth, float specOffset) {
                float3 B = normalize(bitangentWS + flowDir.x * tangentWS + flowDir.y * normalWS);
                float3 T = normalize(cross(B, normalWS));
                
                float3 H = normalize(lightDirWS + viewDirWS);
                float TdotH = dot(T, H) + specOffset;
                float BdotH = dot(B, H);
                float NdotH = dot(normalWS, H);
                
                float spec = exp(-TdotH * TdotH / max(0.001, specWidth)) * exp(-BdotH * BdotH / 1.5);
                return spec * smoothstep(0.05, 0.45, NdotH);
            }
            
            float3 blendDetailNormal(float3 baseNormal, float3 detailNormal) {
                float3 newNormal = normalize(float3(baseNormal.xy + detailNormal.xy * 0.8, baseNormal.z));
                return newNormal;
            }
            
            float softShadowStep(float value, float boundary, float hardness) {
                float halfWidth = (1.0 - hardness) * 0.65;
                return smoothstep(boundary - halfWidth, boundary + halfWidth, value);
            }
            
            float superSampleRimEffect(float3 normalWS, float3 viewDirWS, float3 lightDirWS, float threshold, 
                                        float2 screenPos, float rimMask, float sampleCount, float sampleRadius) {
                float totalRim = 0.0;
                float weight = 1.0 / max(1.0, sampleCount);
                
                float2 pixelSize = 1.0 / _ScreenParams.xy;
                float aspectRatio = _ScreenParams.x / _ScreenParams.y;
                
                for (int i = 0; i < sampleCount; i++) {
                    float angle = i * (6.28318 / sampleCount);
                    float2 offset = float2(cos(angle), sin(angle)) * pixelSize * sampleRadius;
                    offset.x /= aspectRatio;
                    
                    float3 offsetNormal = normalWS;
                    float3 offsetViewDir = normalize(viewDirWS + float3(offset.x, offset.y, 0) * 0.15);
                    
                    float rimDot = 1.0 - saturate(dot(offsetNormal, offsetViewDir));
                    float LdotV = dot(lightDirWS, -offsetViewDir);
                    float backlight = saturate(LdotV * 0.5 + 0.5);
                    float alignmentFactor = lerp(1.0, backlight, _RimLightAlign);
                    
                    float rimFactor = smoothstep(threshold - 0.15, threshold + 0.15, rimDot);
                    rimFactor = pow(rimFactor, _RimPower - 0.5) * alignmentFactor;
                    
                    totalRim += rimFactor * weight;
                }
                
                return totalRim * rimMask;
            }
            
            Varyings vert(Attributes input) {
                Varyings output;
                output.positionWS = TransformObjectToWorld(input.positionOS.xyz);
                output.positionCS = TransformWorldToHClip(output.positionWS);
                
                VertexNormalInputs normalInputs = GetVertexNormalInputs(input.normalOS, input.tangentOS);
                output.normalWS = normalInputs.normalWS;
                output.tangentWS = normalInputs.tangentWS;
                output.bitangentWS = normalInputs.bitangentWS;
                
                output.viewDirWS = GetWorldSpaceViewDir(output.positionWS);
                output.uv = TRANSFORM_TEX(input.uv, _MainTex);
                output.shadowCoord = TransformWorldToShadowCoord(output.positionWS);
                output.color = input.color;
                output.screenPos = ComputeScreenPos(output.positionCS);
                
                return output;
            }
            
            half4 frag(Varyings input) : SV_Target {
                float2 screenUV = input.screenPos.xy / input.screenPos.w;
                float2 screenPos = screenUV * _ScreenParams.xy;
                
                float4 albedo = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv) * _Color;
                float4 lightMap = SAMPLE_TEXTURE2D(_LightMap, sampler_LightMap, input.uv);
                float4 idMap = SAMPLE_TEXTURE2D(_IDMap, sampler_IDMap, input.uv);
                float ao = lightMap.r;
                float shadowMask = lightMap.g;
                float specularMask = lightMap.b;
                float rimMask = lightMap.a;
                
                float3 normalTS = UnpackNormalScale(SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, input.uv), _NormalScale * 0.85);
                
                #if defined(_CLOTH_FEATURES)
                if (_MaterialType == 2) {
                    float2 detailUV = input.uv * _DetailTiling;
                    float3 detailNormalTS = UnpackNormalScale(SAMPLE_TEXTURE2D(_DetailNormalMap, sampler_DetailNormalMap, detailUV), _DetailNormalScale * 0.85);
                    normalTS = blendDetailNormal(normalTS, detailNormalTS);
                }
                #endif
                
                float3x3 TBN = float3x3(normalize(input.tangentWS),
                                        normalize(input.bitangentWS),
                                        normalize(input.normalWS));
                float3 normalWS = normalize(mul(normalTS, TBN));
                float3 viewDirWS = normalize(input.viewDirWS);
                
                float3 ambientLight = SampleSH(float3(0,1,0));
                float ambientIntensity = dot(ambientLight, float3(0.299, 0.587, 0.114));
                
                Light mainLight = GetMainLight(input.shadowCoord);
                float3 lightDir = normalize(mainLight.direction);
                float3 lightColor = mainLight.color;
                float attenuation = mainLight.shadowAttenuation;
                
                float3 shadowDir = lightDir;
                #if defined(_CUSTOM_SHADOW_DIR)
                    float3 customDir = normalize(_ShadowDir.xyz);
                    shadowDir = lerp(shadowDir, customDir, _ShadowDirInfluence);
                #endif
                
                float NdotL = dot(normalWS, shadowDir);
                
                float3 anisoBitangent = normalize(cross(normalWS, float3(0, 1, 0)));
                float anisoFactor = dot(anisoBitangent, shadowDir);
                anisoFactor = abs(anisoFactor) * _AnisotropicFilter;
                
                float halfLambert = NdotL * 0.5 + 0.5;
                halfLambert = lerp(halfLambert, pow(halfLambert, 0.8), _ShadowBlur);
                float shadowValue = halfLambert * attenuation * shadowMask;
                
                float shadow1 = softShadowStep(shadowValue, _ShadowBoundary1, _ShadowHardness);
                float shadow2 = softShadowStep(shadowValue, _ShadowBoundary2, _ShadowHardness);
                
                float noise = frac(sin(dot(screenPos, float2(12.9898, 78.233))) * 43758.5453) * 0.015;
                shadow1 += noise;
                shadow2 += noise;
                
                float3 ambientShadowTint = lerp(float3(1,1,1), normalize(ambientLight), _ShadowAmbientInfluence);
                float3 shadowColor1 = _ShadowColor.rgb * ambientShadowTint;
                float3 shadowColor2 = _DarkShadowColor.rgb * ambientShadowTint;
                
                shadowColor1 = lerp(albedo.rgb, albedo.rgb * shadowColor1, _ShadowIntensity1);
                shadowColor2 = lerp(albedo.rgb, albedo.rgb * shadowColor2, _ShadowIntensity2);
                
                float3 finalShading = lerp(
                    lerp(shadowColor2, shadowColor1, smoothstep(0.0, 1.0, shadow2)),
                    albedo.rgb * _BrightColor.rgb,
                    smoothstep(0.0, 1.0, shadow1)
                );
                
                float3 materialSpecificEffects = float3(0,0,0);
                
                #if defined(_FACE_FEATURES)
                if (_MaterialType == 0) {
                    float4 blushMap = SAMPLE_TEXTURE2D(_BlushMap, sampler_BlushMap, input.uv);
                    float4 sssMap = SAMPLE_TEXTURE2D(_SSSMap, sampler_SSSMap, input.uv);
                    
                    float3 blushEffect = blushMap.rgb * _BlushColor.rgb * _BlushIntensity;
                    
                    float3 H = normalize(lightDir + normalWS * _SSSScale);
                    float VdotH = pow(saturate(dot(viewDirWS, -H)), 12.0) * _SSSIntensity;
                    float3 sssEffect = sssMap.r * _SSSColor.rgb * VdotH;
                    
                    float faceHighlight = pow(max(0, dot(normalWS, lightDir)), 6) * specularMask * _HighlightBrightness;
                    
                    materialSpecificEffects = blushEffect + sssEffect + faceHighlight * _BrightColor.rgb;
                    
                    finalShading = lerp(
                        lerp(shadowColor2 * 1.05, shadowColor1 * 1.02, smoothstep(0.1, 0.9, shadow2)),
                        albedo.rgb * _BrightColor.rgb * _HighlightBrightness,
                        smoothstep(0.1, 0.9, shadow1)
                    );
                }
                #endif
                
                #if defined(_HAIR_FEATURES)
                if (_MaterialType == 1) {
                    float4 hairFlowMap = SAMPLE_TEXTURE2D(_HairFlowMap, sampler_HairFlowMap, input.uv);
                    float2 flowDir = hairFlowMap.rg * 2.0 - 1.0;
                    float hairLength = hairFlowMap.b;
                    
                    float hairSpec = calculateSoftenedAnisotropicSpecular(
                        normalWS, 
                        input.tangentWS,
                        input.bitangentWS,
                        viewDirWS,
                        lightDir,
                        flowDir,
                        _HairSpecWidth,
                        _HairSpecularOffset
                    );
                    
                    float3 hairSpecColor = _HairSpecColor.rgb * hairSpec * _HairSpecIntensity * specularMask;
                    
                    float translucency = pow(saturate(dot(viewDirWS, -lightDir)), 2.5) * _HairTranslucency * hairLength;
                    float3 translucencyColor = albedo.rgb * translucency * _BrightColor.rgb;
                    
                    materialSpecificEffects = hairSpecColor + translucencyColor;
                    
                    finalShading = lerp(
                        lerp(shadowColor2, shadowColor1, smoothstep(0.1, 0.9, shadow2)),
                        albedo.rgb * _BrightColor.rgb,
                        saturate(smoothstep(0.1, 0.9, shadow1) + hairSpec * 0.25)
                    );
                }
                #endif
                
                #if defined(_CLOTH_FEATURES)
                if (_MaterialType == 2) {
                    float4 clothMap = SAMPLE_TEXTURE2D(_ClothMap, sampler_ClothMap, input.uv);
                    float silkFactor = clothMap.r;
                    float metalFactor = clothMap.g;
                    float leatherFactor = clothMap.b;
                    
                    float silkSpecular = pow(saturate(dot(reflect(-lightDir, normalWS), viewDirWS)), 6) * silkFactor;
                    
                    float metalSpecular = pow(saturate(dot(reflect(-lightDir, normalWS), viewDirWS)), 16) * metalFactor;
                    float3 metalSpecColor = lerp(albedo.rgb, _BrightColor.rgb, 0.6) * metalSpecular * _MetallicIntensity;
                    
                    float leatherSpecular = pow(saturate(dot(normalWS, normalize(lightDir + viewDirWS))), 3) * leatherFactor * _SmoothnessIntensity;
                    
                    materialSpecificEffects = silkSpecular * _BrightColor.rgb * _SmoothnessIntensity * 2.0 + 
                                             metalSpecColor + 
                                             leatherSpecular * _BrightColor.rgb * 0.5;
                }
                #endif
                
                float rimContribution = 0.0;
                float3 rimColorFinal = _RimColor.rgb;
                
                if (_RimIntensity > 0.001 && attenuation > 0.001) {
                    int sampleCount = max(1, (int)_RimSampleCount);
                    float rimFactor = superSampleRimEffect(
                        normalWS, viewDirWS, lightDir, _RimThreshold, 
                        screenPos, rimMask, sampleCount, _RimSampleRadius
                    );
                    
                    rimColorFinal = lerp(rimColorFinal, rimColorFinal * normalize(ambientLight), _RimAmbientInfluence);
                    rimContribution = rimFactor * _RimIntensity;
                }
                
                float envFactor = lerp(1.0, ambientIntensity, _EnvInfluence);
                float3 finalColor = finalShading * lightColor * envFactor;
                
                finalColor = max(finalColor, shadowColor2 * ambientLight * _DarknessThreshold);
                finalColor += materialSpecificEffects * attenuation * envFactor;
                finalColor += rimColorFinal * rimContribution * envFactor;
                finalColor += albedo.rgb * ao * ambientLight * 0.15;
                
                int additionalLightsCount = GetAdditionalLightsCount();
                for (int i = 0; i < additionalLightsCount; i++) {
                    Light addLight = GetAdditionalLight(i, input.positionWS);
                    float addNdotL = max(0, dot(normalWS, normalize(addLight.direction)));
                    float lightIntensity = addNdotL * addLight.distanceAttenuation * addLight.shadowAttenuation;
                    
                    lightIntensity = pow(lightIntensity, 0.85);
                    
                    if (_RimIntensity > 0.001 && lightIntensity > 0.001) {
                        int sampleCount = max(1, (int)(_RimSampleCount * 0.5));
                        float addRimFactor = superSampleRimEffect(
                            normalWS, viewDirWS, normalize(addLight.direction), _RimThreshold, 
                            screenPos, rimMask, sampleCount, _RimSampleRadius * 0.75
                        );
                        
                        finalColor += rimColorFinal * addRimFactor * _RimIntensity * 0.5 * addLight.color;
                    }
                    
                    finalColor += albedo.rgb * addLight.color * lightIntensity * 0.5;
                    
                    #if defined(_HAIR_FEATURES)
                    if (_MaterialType == 1) {
                        float4 hairFlowMap = SAMPLE_TEXTURE2D(_HairFlowMap, sampler_HairFlowMap, input.uv);
                        float2 flowDir = hairFlowMap.rg * 2.0 - 1.0;
                        
                        float addHairSpec = calculateSoftenedAnisotropicSpecular(
                            normalWS, 
                            input.tangentWS,
                            input.bitangentWS,
                            viewDirWS,
                            normalize(addLight.direction),
                            flowDir,
                            _HairSpecWidth,
                            _HairSpecularOffset
                        ) * 0.5;
                        
                        finalColor += _HairSpecColor.rgb * addHairSpec * _HairSpecIntensity * 
                                     specularMask * addLight.color * lightIntensity;
                    }
                    #endif
                }
                
                return half4(finalColor, albedo.a);
            }
            ENDHLSL
        }
        
        // Forward Pass 시작점
        Pass
        {
            Name "Outline"
            Tags { }
            Cull Front
            
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            
            struct Attributes {
                float4 positionOS : POSITION;
                float3 normalOS   : NORMAL;
                float4 tangentOS  : TANGENT;
                float2 uv         : TEXCOORD0;
                float4 color      : COLOR;
            };
            
            struct Varyings {
                float4 positionCS : SV_POSITION;
                float2 uv         : TEXCOORD0;
                float4 screenPos  : TEXCOORD1;
                float3 normalWS   : TEXCOORD2;
                float3 viewDirWS  : TEXCOORD3;
                float3 positionWS : TEXCOORD4;
                float4 positionNDC: TEXCOORD5;
            };
            
            TEXTURE2D(_MainTex);    SAMPLER(sampler_MainTex);
            TEXTURE2D(_IDMap);      SAMPLER(sampler_IDMap);
            
            CBUFFER_START(UnityPerMaterial)
                float4 _MainTex_ST;
                float _MaterialType;
                float4 _OutlineColor;
                float _OutlineWidth;
                float _OutlineDepthFactor;
                float _OutlineIDInfluence;
                float _OutlineViewScale;
                float _OutlineSampleCount;
                float _OutlineSampleRadius;
                float _OutlineSmoothness;
            CBUFFER_END
            
            static const float2 POISSON_DISK_12[12] = {
                float2(0.7373868, 0.5757253),
                float2(-0.5757253, 0.7373868),
                float2(-0.7373868, -0.5757253),
                float2(0.5757253, -0.7373868),
                float2(0.3678179, 0.2455328),
                float2(-0.2455328, 0.3678179),
                float2(-0.3678179, -0.2455328),
                float2(0.2455328, -0.3678179),
                float2(0.1159148, 0.6977284),
                float2(-0.6977284, 0.1159148),
                float2(-0.1159148, -0.6977284),
                float2(0.6977284, -0.1159148)
            };
            
            float superSampleOutline(float2 screenPos, float originalValue, float sampleCount, float sampleRadius) {
                float totalValue = originalValue;
                float weights = 1.0;
                
                float2 pixelSize = 1.0 / _ScreenParams.xy;
                float aspectRatio = _ScreenParams.x / _ScreenParams.y;
                
                float2 poissonScale = pixelSize * sampleRadius;
                poissonScale.x /= aspectRatio;
                
                for (int i = 0; i < min(sampleCount, 12); i++) {
                    float2 offset = POISSON_DISK_12[i] * poissonScale;
                    totalValue += originalValue * (1.0 - length(offset) * 4.0);
                    weights += (1.0 - length(offset) * 4.0);
                }
                
                return totalValue / max(0.001, weights);
            }
            
            Varyings vert(Attributes input) {
                Varyings output;
                
                VertexPositionInputs positionInputs = GetVertexPositionInputs(input.positionOS.xyz);
                VertexNormalInputs normalInputs = GetVertexNormalInputs(input.normalOS, input.tangentOS);
                
                float3 posWS = positionInputs.positionWS;
                float3 normalWS = normalInputs.normalWS;
                
                output.normalWS = normalWS;
                output.viewDirWS = normalize(GetWorldSpaceViewDir(posWS));
                output.positionWS = posWS;
                
                float3 posVS = TransformWorldToView(posWS);
                float3 normalVS = TransformWorldToViewDir(normalWS);
                
                output.uv = TRANSFORM_TEX(input.uv, _MainTex);
                float idFactor = SAMPLE_TEXTURE2D_LOD(_IDMap, sampler_IDMap, output.uv, 0).r;
                
                float viewFactor = 1.0 - abs(dot(normalWS, output.viewDirWS));
                viewFactor = lerp(1.0, smoothstep(0.0, 0.8, viewFactor), _OutlineViewScale);
                
                float distanceToCamera = length(posVS);
                float distanceFactor = smoothstep(1.0, 8.0, distanceToCamera);
                distanceFactor = 1.0 - distanceFactor * _OutlineDepthFactor;
                
                float vertexWidthFactor = input.color.r;
                
                float outlineWidth = _OutlineWidth;
                
                if (_MaterialType == 0) outlineWidth *= 0.65;
                else if (_MaterialType == 1) outlineWidth *= 1.1;
                
                outlineWidth *= lerp(1.0, idFactor, _OutlineIDInfluence);
                outlineWidth *= lerp(1.0, vertexWidthFactor, 0.4);
                outlineWidth *= viewFactor;
                outlineWidth *= distanceFactor;
                
                float4 clipPos = positionInputs.positionCS;
                float4 nearUpperRight = mul(unity_CameraInvProjection, float4(1, 1, UNITY_NEAR_CLIP_VALUE, _ProjectionParams.y));
                float aspect = abs(nearUpperRight.y / nearUpperRight.x);
                
                normalVS.xy *= float2(aspect, 1.0);
                normalVS = normalize(normalVS);
                
                posVS += normalVS * outlineWidth;
                output.positionCS = TransformWViewToHClip(posVS);
                output.screenPos = ComputeScreenPos(output.positionCS);
                output.positionNDC = output.positionCS * 0.5f;
                output.positionNDC.xy = float2(output.positionNDC.x, output.positionNDC.y * _ProjectionParams.x) + output.positionNDC.w;
                output.positionNDC.zw = output.positionCS.zw;
                
                return output;
            }
            
            half4 frag(Varyings input) : SV_Target {
                float2 screenUV = input.screenPos.xy / input.screenPos.w;
                float2 screenPos = screenUV * _ScreenParams.xy;
                
                half4 outlineColorFinal = _OutlineColor;
                
                if (_MaterialType == 0) {
                    outlineColorFinal.rgb = lerp(outlineColorFinal.rgb, float3(0.12, 0.06, 0.06), 0.25);
                } else if (_MaterialType == 1) {
                    outlineColorFinal.rgb = lerp(outlineColorFinal.rgb, float3(0.06, 0.04, 0.12), 0.15);
                }
                
                float viewDotNormal = abs(dot(normalize(input.normalWS), normalize(input.viewDirWS)));
                float outlineAlpha = 1.0 - viewDotNormal;
                outlineAlpha = smoothstep(0.0, _OutlineSmoothness, outlineAlpha);
                
                float2 ndcPos = input.positionNDC.xy / input.positionNDC.w;
                
                float alphaSamples = superSampleOutline(screenPos, outlineAlpha, _OutlineSampleCount, _OutlineSampleRadius);
                alphaSamples = smoothstep(0.05, 0.85, alphaSamples);
                
                outlineColorFinal.a *= alphaSamples;
                
                float camDist = length(input.positionWS - _WorldSpaceCameraPos);
                float distAtten = 1.0 - saturate((camDist - 1.0) * 0.08);
                
                outlineColorFinal.a *= distAtten;
                
                return outlineColorFinal;
            }
            ENDHLSL
        }
        
        UsePass "Universal Render Pipeline/Lit/ShadowCaster"
        UsePass "Universal Render Pipeline/Lit/DepthOnly"
    }
    
    CustomEditor "CharacterShaderGUI"
}
