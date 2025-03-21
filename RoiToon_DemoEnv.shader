//   Verrrryyy Simple EnvironmentShader

Shader "RoiToonDemo/EnvironmentShader"
{
    Properties
    {
        _BaseMap("Base Map", 2D) = "white" {}
        _BaseColor("Base Color", Color) = (1,1,1,1)
        _NormalMap("Normal Map", 2D) = "bump" {}
        _AOMap("Ambient Occlusion", 2D) = "white" {}
        
        [Header(Toon Settings)]
        _ToonRamp("Toon Ramp", Range(1, 10)) = 3
        _ToonEffect("Toon Effect", Range(0, 1)) = 0.5
        _Softness("Edge Softness", Range(0, 0.5)) = 0.1
        
        [Header(Outline)]
        [Toggle(_OUTLINE)]_OutlineEnabled("Enable Outline", Float) = 1
        _OutlineColor("Outline Color", Color) = (0.1, 0.1, 0.1, 1)
        _OutlineWidth("Outline Width", Range(0, 5)) = 1
        
        [Header(Environment)]
        _EnvTint("Environment Tint", Color) = (0.99, 0.96, 0.9, 1)
        _EnvIntensity("Environment Intensity", Range(0, 2)) = 0.8
        
        [Header(Noise)]
        _NoiseTexture("Noise Texture", 2D) = "white" {}
        _NoiseIntensity("Noise Intensity", Range(0, 0.2)) = 0.03
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry" "RenderPipeline"="UniversalPipeline" }
        LOD 300

        // Main pass
        Pass
        {
            Name "ForwardLit"
            Tags { "LightMode"="UniversalForward" }

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _ADDITIONAL_LIGHTS
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma shader_feature_local _OUTLINE

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            struct Attributes
            {
                float4 positionOS   : POSITION;
                float3 normalOS     : NORMAL;
                float4 tangentOS    : TANGENT;
                float2 uv           : TEXCOORD0;
                float2 lightmapUV   : TEXCOORD1;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct Varyings
            {
                float4 positionCS   : SV_POSITION;
                float2 uv           : TEXCOORD0;
                float3 positionWS   : TEXCOORD1;
                float3 normalWS     : TEXCOORD2;
                float3 tangentWS    : TEXCOORD3;
                float3 bitangentWS  : TEXCOORD4;
                float4 shadowCoord  : TEXCOORD5;
                DECLARE_LIGHTMAP_OR_SH(lightmapUV, vertexSH, 6);
                float3 viewDirWS    : TEXCOORD7;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            TEXTURE2D(_BaseMap);
            SAMPLER(sampler_BaseMap);
            TEXTURE2D(_NormalMap);
            SAMPLER(sampler_NormalMap);
            TEXTURE2D(_AOMap);
            SAMPLER(sampler_AOMap);
            TEXTURE2D(_NoiseTexture);
            SAMPLER(sampler_NoiseTexture);

            CBUFFER_START(UnityPerMaterial)
                float4 _BaseMap_ST;
                float4 _BaseColor;
                float4 _OutlineColor;
                float _OutlineWidth;
                float _ToonRamp;
                float _ToonEffect;
                float _Softness;
                float4 _EnvTint;
                float _EnvIntensity;
                float _NoiseIntensity;
                float4 _NoiseTexture_ST;
            CBUFFER_END

            Varyings vert(Attributes input)
            {
                Varyings output = (Varyings)0;
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_TRANSFER_INSTANCE_ID(input, output);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

                VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
                VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS, input.tangentOS);

                output.positionCS = vertexInput.positionCS;
                output.positionWS = vertexInput.positionWS;
                output.uv = TRANSFORM_TEX(input.uv, _BaseMap);
                
                output.normalWS = normalInput.normalWS;
                output.tangentWS = normalInput.tangentWS;
                output.bitangentWS = normalInput.bitangentWS;
                
                output.viewDirWS = GetWorldSpaceViewDir(vertexInput.positionWS);
                output.shadowCoord = GetShadowCoord(vertexInput);

                OUTPUT_LIGHTMAP_UV(input.lightmapUV, unity_LightmapST, output.lightmapUV);
                OUTPUT_SH(output.normalWS.xyz, output.vertexSH);

                return output;
            }

            half3 ToonShading(half NdotL, half3 baseColor, half3 lightColor)
            {
                half toonRamp = _ToonRamp;
                half toonEffect = _ToonEffect;
                half edgeSoftness = _Softness;
                
                half toon = smoothstep(0, edgeSoftness, NdotL);
                toon = pow(toon, toonRamp);
                
                half3 diffuseToon = lerp(baseColor * lightColor, baseColor * lightColor * toon, toonEffect);
                return diffuseToon;
            }

            half4 frag(Varyings input) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

                float2 noiseUV = input.uv * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
                half noise = SAMPLE_TEXTURE2D(_NoiseTexture, sampler_NoiseTexture, noiseUV).r;
                
                half4 baseMap = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, input.uv);
                half3 baseColor = baseMap.rgb * _BaseColor.rgb;
                baseColor += (noise - 0.5) * _NoiseIntensity;
                
                half3 normalTS = UnpackNormal(SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, input.uv));
                float3x3 tangentToWorld = float3x3(input.tangentWS, input.bitangentWS, input.normalWS);
                half3 normalWS = normalize(mul(normalTS, tangentToWorld));
                
                half ao = SAMPLE_TEXTURE2D(_AOMap, sampler_AOMap, input.uv).r;
                
                Light mainLight = GetMainLight(input.shadowCoord);
                half3 lightDir = mainLight.direction;
                half3 lightColor = mainLight.color;
                half shadowAtten = mainLight.shadowAttenuation;
                
                half NdotL = dot(normalWS, lightDir);
                NdotL = NdotL * 0.5 + 0.5;
                
                half3 toonColor = ToonShading(NdotL * shadowAtten, baseColor, lightColor);
                
                half3 bakedGI = SAMPLE_GI(input.lightmapUV, input.vertexSH, normalWS);
                bakedGI *= _EnvTint.rgb * _EnvIntensity * ao;
                
                half3 finalColor = toonColor + bakedGI * baseColor;
                
                return half4(finalColor, 1);
            }
            ENDHLSL
        }
        
        // Outline pass
        Pass
        {
            Name "Outline"
            Tags { }
            Cull Front
            
            HLSLPROGRAM
            #pragma vertex OutlineVert
            #pragma fragment OutlineFrag
            #pragma shader_feature_local _OUTLINE
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            
            struct Attributes
            {
                float4 positionOS   : POSITION;
                float3 normalOS     : NORMAL;
                float2 uv           : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct Varyings
            {
                float4 positionCS   : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };
            
            CBUFFER_START(UnityPerMaterial)
                float4 _BaseMap_ST;
                float4 _BaseColor;
                float4 _OutlineColor;
                float _OutlineWidth;
                float _ToonRamp;
                float _ToonEffect;
                float _Softness;
                float4 _EnvTint;
                float _EnvIntensity;
                float _NoiseIntensity;
                float4 _NoiseTexture_ST;
            CBUFFER_END
            
            Varyings OutlineVert(Attributes input)
            {
                Varyings output = (Varyings)0;
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_TRANSFER_INSTANCE_ID(input, output);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);
                
                #ifdef _OUTLINE
                    float3 normalOS = normalize(input.normalOS);
                    float3 posOS = input.positionOS.xyz + normalOS * (_OutlineWidth * 0.001);
                    output.positionCS = TransformObjectToHClip(posOS);
                #else
                    output.positionCS = TransformObjectToHClip(input.positionOS.xyz);
                #endif
                
                return output;
            }
            
            half4 OutlineFrag(Varyings input) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);
                
                return _OutlineColor;
            }
            ENDHLSL
        }
        
        Pass
        {
            Name "ShadowCaster"
            Tags{"LightMode" = "ShadowCaster"}

            ZWrite On
            ZTest LEqual
            ColorMask 0

            HLSLPROGRAM
            #pragma vertex ShadowPassVertex
            #pragma fragment ShadowPassFragment
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            
            CBUFFER_START(UnityPerMaterial)
                float4 _BaseMap_ST;
                float4 _BaseColor;
                float4 _OutlineColor;
                float _OutlineWidth;
                float _ToonRamp;
                float _ToonEffect;
                float _Softness;
                float4 _EnvTint;
                float _EnvIntensity;
                float _NoiseIntensity;
                float4 _NoiseTexture_ST;
            CBUFFER_END
            
            struct Attributes
            {
                float4 positionOS   : POSITION;
                float3 normalOS     : NORMAL;
                float2 texcoord     : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct Varyings
            {
                float4 positionCS   : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            float4 GetShadowPositionHClip(Attributes input)
            {
                float3 positionWS = TransformObjectToWorld(input.positionOS.xyz);
                float3 normalWS = TransformObjectToWorldNormal(input.normalOS);
                float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, _MainLightPosition.xyz));
                
                #if UNITY_REVERSED_Z
                    positionCS.z = min(positionCS.z, positionCS.w * UNITY_NEAR_CLIP_VALUE);
                #else
                    positionCS.z = max(positionCS.z, positionCS.w * UNITY_NEAR_CLIP_VALUE);
                #endif
                
                return positionCS;
            }

            Varyings ShadowPassVertex(Attributes input)
            {
                Varyings output;
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_TRANSFER_INSTANCE_ID(input, output);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);
                
                output.positionCS = GetShadowPositionHClip(input);
                return output;
            }

            half4 ShadowPassFragment(Varyings input) : SV_TARGET
            {
                return 0;
            }
            ENDHLSL
        }
    }
}
