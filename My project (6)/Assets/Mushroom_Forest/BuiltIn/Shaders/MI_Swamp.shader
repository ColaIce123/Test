Shader "Unreal/MI_Swamp"
{
	Properties
	{
		_MainTex("MainTex (RGB)", 2D) = "white" {}
		Material_Texture2D_0( "Normal Texture 1", 2D ) = "white" {}
		Material_Texture2D_1( "Normal Texture 2", 2D ) = "white" {}
		Material_Texture2D_2( "Normal Set2 Texture 1", 2D ) = "white" {}
		Material_Texture2D_3( "Normal Set2 Texture 2", 2D ) = "white" {}
		Material_Texture2D_4( "Distortion 1 Texture", 2D ) = "white" {}
		Material_Texture2D_5( "Distortion 2 Texture", 2D ) = "white" {}
		Material_Texture2D_6( "Color 1 Texture", 2D ) = "white" {}
		Material_Texture2D_7( "Color 2 Texture", 2D ) = "white" {}

		View_BufferSizeAndInvSize( "View_BufferSizeAndInvSize", Vector ) = ( 1920,1080,0.00052, 0.00092 )//1920,1080,1/1920, 1/1080
		LocalObjectBoundsMin( "LocalObjectBoundsMin", Vector ) = ( 0, 0, 0, 0 )
		LocalObjectBoundsMax( "LocalObjectBoundsMax", Vector ) = ( 100, 100, 100, 0 )
	}
	SubShader 
	{
		 Tags { "RenderType" = "Opaque" }
		//BLEND_ON Tags { "RenderType" = "Transparent"  "Queue" = "Transparent" }
		
		//Blend SrcAlpha OneMinusSrcAlpha
		//Cull Off

		CGPROGRAM

		#include "UnityPBSLighting.cginc"
		 #pragma surface surf Standard vertex:vert addshadow
		//BLEND_ON #pragma surface surf Standard vertex:vert alpha:fade addshadow
		
		#pragma target 5.0

		#define NUM_TEX_COORD_INTERPOLATORS 1
		#define NUM_MATERIAL_TEXCOORDS_VERTEX 1
		#define NUM_CUSTOM_VERTEX_INTERPOLATORS 0

		struct Input
		{
			//float3 Normal;
			float2 uv_MainTex : TEXCOORD0;
			float2 uv2_Material_Texture2D_0 : TEXCOORD1;
			//float2 uv2_MainTex : TEXCOORD1;
			float4 color : COLOR;
			float4 tangent;
			//float4 normal;
			float3 viewDir;
			float4 screenPos;
			float3 worldPos;
			//float3 worldNormal;
			float3 normal2;
			INTERNAL_DATA
		};
		void vert( inout appdata_full i, out Input o )
		{
			float3 p_normal = mul( float4( i.normal, 0.0f ), unity_WorldToObject );
			//half4 p_tangent = mul( unity_ObjectToWorld,i.tangent );

			//half3 normal_input = normalize( p_normal.xyz );
			//half3 tangent_input = normalize( p_tangent.xyz );
			//half3 binormal_input = cross( p_normal.xyz,tangent_input.xyz ) * i.tangent.w;
			UNITY_INITIALIZE_OUTPUT( Input, o );

			//o.worldNormal = p_normal;
			o.normal2 = p_normal;
			o.tangent = i.tangent;
			//o.binormal_input = binormal_input;
		}
		uniform sampler2D _MainTex;
		/*
		struct SurfaceOutputStandard
		{
		fixed3 Albedo;		// base (diffuse or specular) color
		fixed3 Normal;		// tangent space normal, if written
		half3 Emission;
		half Metallic;		// 0=non-metal, 1=metal
		// Smoothness is the user facing name, it should be perceptual smoothness but user should not have to deal with it.
		// Everywhere in the code you meet smoothness it is perceptual smoothness
		half Smoothness;	// 0=rough, 1=smooth
		half Occlusion;		// occlusion (default 1)
		fixed Alpha;		// alpha for transparencies
		};
		*/


		#define Texture2D sampler2D
		#define TextureCube samplerCUBE
		#define SamplerState int

		#define UE5
		#define MATERIAL_TANGENTSPACENORMAL 1
		//struct Material
		//{
			//samplers start
			uniform sampler2D    Material_Texture2D_0;
			uniform SamplerState Material_Texture2D_0Sampler;
			uniform sampler2D    Material_Texture2D_1;
			uniform SamplerState Material_Texture2D_1Sampler;
			uniform sampler2D    Material_Texture2D_2;
			uniform SamplerState Material_Texture2D_2Sampler;
			uniform sampler2D    Material_Texture2D_3;
			uniform SamplerState Material_Texture2D_3Sampler;
			uniform sampler2D    Material_Texture2D_4;
			uniform SamplerState Material_Texture2D_4Sampler;
			uniform sampler2D    Material_Texture2D_5;
			uniform SamplerState Material_Texture2D_5Sampler;
			uniform sampler2D    Material_Texture2D_6;
			uniform SamplerState Material_Texture2D_6Sampler;
			uniform sampler2D    Material_Texture2D_7;
			uniform SamplerState Material_Texture2D_7Sampler;
			
		//};

		#ifdef UE5
			#define UE_LWC_RENDER_TILE_SIZE			2097152.0
			#define UE_LWC_RENDER_TILE_SIZE_SQRT	1448.15466
			#define UE_LWC_RENDER_TILE_SIZE_RSQRT	0.000690533954
			#define UE_LWC_RENDER_TILE_SIZE_RCP		4.76837158e-07
			#define UE_LWC_RENDER_TILE_SIZE_FMOD_PI		0.673652053
			#define UE_LWC_RENDER_TILE_SIZE_FMOD_2PI	0.673652053
			#define INVARIANT(X) X
			#define PI 					(3.1415926535897932)

			#include "LargeWorldCoordinates.hlsl"
		#endif
		struct MaterialStruct
		{
			float4 PreshaderBuffer[55];
			float4 ScalarExpressions[1];
			float VTPackedPageTableUniform[2];
			float VTPackedUniform[1];
		};
		struct ViewStruct
		{
			float GameTime;
			float RealTime;
			float DeltaTime;
			float PrevFrameGameTime;
			float PrevFrameRealTime;
			float MaterialTextureMipBias;
			SamplerState MaterialTextureBilinearWrapedSampler;
			SamplerState MaterialTextureBilinearClampedSampler;
			float4 PrimitiveSceneData[ 40 ];
			float4 TemporalAAParams;
			float2 ViewRectMin;
			float4 ViewSizeAndInvSize;
			float MaterialTextureDerivativeMultiply;
			uint StateFrameIndexMod8;
			float FrameNumber;
			float2 FieldOfViewWideAngles;
			float4 RuntimeVirtualTextureMipLevel;
			float PreExposure;
			float4 BufferBilinearUVMinMax;
		};
		struct ResolvedViewStruct
		{
		#ifdef UE5
			FLWCVector3 WorldCameraOrigin;
			FLWCVector3 PrevWorldCameraOrigin;
			FLWCVector3 PreViewTranslation;
			FLWCVector3 WorldViewOrigin;
		#else
			float3 WorldCameraOrigin;
			float3 PrevWorldCameraOrigin;
			float3 PreViewTranslation;
			float3 WorldViewOrigin;
		#endif
			float4 ScreenPositionScaleBias;
			float4x4 TranslatedWorldToView;
			float4x4 TranslatedWorldToCameraView;
			float4x4 TranslatedWorldToClip;
			float4x4 ViewToTranslatedWorld;
			float4x4 PrevViewToTranslatedWorld;
			float4x4 CameraViewToTranslatedWorld;
			float4 BufferBilinearUVMinMax;
			float4 XRPassthroughCameraUVs[ 2 ];
		};
		struct PrimitiveStruct
		{
			float4x4 WorldToLocal;
			float4x4 LocalToWorld;
		};

		ViewStruct View;
		ResolvedViewStruct ResolvedView;
		PrimitiveStruct Primitive;
		uniform float4 View_BufferSizeAndInvSize;
		uniform float4 LocalObjectBoundsMin;
		uniform float4 LocalObjectBoundsMax;
		uniform SamplerState Material_Wrap_WorldGroupSettings;
		uniform SamplerState Material_Clamp_WorldGroupSettings;
		
		#define PI UNITY_PI
		#include "UnrealCommon.cginc"

		MaterialStruct Material;
void InitializeExpressions()
{
	Material.PreshaderBuffer[0] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[1] = float4(0.100000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.010000,-0.100000,-0.010000,-0.150000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(-0.100000,0.010000,0.010000,-0.100000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.010000,-0.100000,3.000000,5.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(5.000000,3.000000,30.000000,0.033333);//(Unknown)
	Material.PreshaderBuffer[6] = float4(2.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.100000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.100000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.100000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.250000,0.750000,-0.150000,-0.010000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(-0.010000,-0.150000,-0.010000,-0.150000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(0.250000,0.750000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(0.010000,0.250000,-0.010000,0.350000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.250000,0.010000,0.010000,0.250000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(0.010000,0.250000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(-0.800000,-1.000000,-1.000000,-2.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(-1.000000,-0.800000,-0.800000,-1.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(0.250000,0.750000,0.350000,-0.010000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(-0.010000,0.350000,-0.010000,0.350000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(-2.000000,-1.000000,-1.000000,-2.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(0.250000,0.750000,2.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(0.010000,-0.100000,-0.010000,-0.120000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(-0.100000,0.010000,0.010000,-0.100000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.010000,-0.100000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(1.000000,1.000000,-2.000000,2.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(0.010000,-0.300000,-0.010000,-0.400000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(-0.300000,0.010000,0.010000,-0.300000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(0.010000,-0.300000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(2.000000,2.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[34] = float4(2.000000,2.000000,2.000000,2.000000);//(Unknown)
	Material.PreshaderBuffer[35] = float4(0.500000,0.500000,-0.400000,-0.010000);//(Unknown)
	Material.PreshaderBuffer[36] = float4(-0.010000,-0.400000,-0.010000,-0.400000);//(Unknown)
	Material.PreshaderBuffer[37] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[38] = float4(0.200000,0.800000,0.050000,-0.120000);//(Unknown)
	Material.PreshaderBuffer[39] = float4(-0.010000,-0.010000,-0.120000,-0.010000);//(Unknown)
	Material.PreshaderBuffer[40] = float4(-0.120000,2.000000,-2.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[41] = float4(-2.000000,2.000000,1.000000,3.000000);//(Unknown)
	Material.PreshaderBuffer[42] = float4(100.000000,100.000000,100.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[43] = float4(100.000000,100.000000,100.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[44] = float4(0.023529,0.027451,0.023529,1.000000);//(Unknown)
	Material.PreshaderBuffer[45] = float4(0.023529,0.027451,0.023529,0.000000);//(Unknown)
	Material.PreshaderBuffer[46] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[47] = float4(0.255000,0.050000,0.750000,0.000000);//(Unknown)
	Material.PreshaderBuffer[48] = float4(1.050000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[49] = float4(0.000000,0.255208,0.255208,0.010000);//(Unknown)
	Material.PreshaderBuffer[50] = float4(0.010000,0.000000,0.255208,0.255208);//(Unknown)
	Material.PreshaderBuffer[51] = float4(0.000000,0.002552,0.002552,0.000000);//(Unknown)
	Material.PreshaderBuffer[52] = float4(0.046875,0.000000,0.000000,0.030000);//(Unknown)
	Material.PreshaderBuffer[53] = float4(0.030000,0.046875,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[54] = float4(0.001406,0.000000,0.000000,1.000000);//(Unknown)
}float3 GetMaterialWorldPositionOffset(FMaterialVertexParameters Parameters)
{
#if IS_NANITE_PASS
	BRANCH
		if (!Parameters.bEvaluateWorldPositionOffset)
		{
			return float3(0, 0, 0);
		}
#endif

#if USE_INSTANCING || USE_INSTANCE_CULLING
	// skip if this instance is hidden
	if (Parameters.PerInstanceParams.y < 1.f)
	{
		return float3(0, 0, 0);
	}
#endif

	if ((GetPrimitiveData(Parameters).Flags & PRIMITIVE_SCENE_DATA_FLAG_EVALUATE_WORLD_POSITION_OFFSET) == 0)
	{
		return float3(0, 0, 0);
	}

	return MaterialFloat3(0.00000000,0.00000000,0.00000000);;
}
void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat Local0 = (View.GameTime * Material.PreshaderBuffer[1].x);
	MaterialFloat Local1 = (Local0 * Material.PreshaderBuffer[4].x);
	MaterialFloat Local2 = (Local0 * Material.PreshaderBuffer[4].y);
	MaterialFloat2 Local3 = Parameters.TexCoords[0].xy;
	MaterialFloat2 Local4 = (DERIV_BASE_VALUE(Local3) * Material.PreshaderBuffer[5].xy);
	FLWCVector3 Local5 = GetWorldPosition(Parameters);
	MaterialFloat3 Local6 = GetDistanceFieldGradientGlobal(LWCToFloat(DERIV_BASE_VALUE(Local5)));
	MaterialFloat3 Local7 = normalize(Local6);
	MaterialFloat3 Local8 = mul((MaterialFloat3x3)(Parameters.TangentToWorld), Local7);
	MaterialFloat2 Local9 = (Local8.rg * MaterialFloat2(-1.00000000,1.00000000));
	MaterialFloat Local10 = GetDistanceToNearestSurfaceGlobal(LWCToFloat(DERIV_BASE_VALUE(Local5)));
	MaterialFloat Local11 = (Local10 * Material.PreshaderBuffer[5].w);
	MaterialFloat Local12 = saturate(Local11);
	MaterialFloat Local13 = (1.00000000 - Local12);
	MaterialFloat Local14 = PositiveClampedPow(Local13,Material.PreshaderBuffer[6].x);
	MaterialFloat2 Local15 = (Local9 * ((MaterialFloat2)Local14));
	MaterialFloat2 Local16 = (Local15 * Material.PreshaderBuffer[9].xy);
	MaterialFloat2 Local17 = (DERIV_BASE_VALUE(Local4) + Local16);
	MaterialFloat2 Local18 = (Local17 * Material.PreshaderBuffer[11].zw);
	MaterialFloat2 Local19 = (MaterialFloat2(Local1,Local2) + Local18);
	MaterialFloat Local20 = MaterialStoreTexCoordScale(Parameters, Local19, 0);
	MaterialFloat4 Local21 = UnpackNormalMap(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(Material_Texture2D_0Sampler,View.MaterialTextureBilinearWrapedSampler),Local19));
	MaterialFloat Local22 = MaterialStoreTexSample(Parameters, Local21, 0);
	MaterialFloat3 Local23 = lerp(Local21.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[12].y);
	MaterialFloat Local24 = (Local23.b + 1.00000000);
	MaterialFloat Local25 = (Local0 * Material.PreshaderBuffer[13].z);
	MaterialFloat Local26 = (Local0 * Material.PreshaderBuffer[13].w);
	MaterialFloat2 Local27 = (Local17 * Material.PreshaderBuffer[14].zw);
	MaterialFloat2 Local28 = (MaterialFloat2(Local25,Local26) + Local27);
	MaterialFloat Local29 = MaterialStoreTexCoordScale(Parameters, Local28, 0);
	MaterialFloat4 Local30 = UnpackNormalMap(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(Material_Texture2D_1Sampler,View.MaterialTextureBilinearWrapedSampler),Local28));
	MaterialFloat Local31 = MaterialStoreTexSample(Parameters, Local30, 0);
	MaterialFloat3 Local32 = lerp(Local30.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[15].y);
	MaterialFloat2 Local33 = (Local32.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local34 = dot(MaterialFloat3(Local23.rg,Local24),MaterialFloat3(Local33,Local32.b));
	MaterialFloat3 Local35 = (MaterialFloat3(Local23.rg,Local24) * ((MaterialFloat3)Local34));
	MaterialFloat3 Local36 = (((MaterialFloat3)Local24) * MaterialFloat3(Local33,Local32.b));
	MaterialFloat3 Local37 = (Local35 - Local36);
	MaterialFloat Local38 = (Local37.b + 1.00000000);
	MaterialFloat Local39 = (Local0 * Material.PreshaderBuffer[18].x);
	MaterialFloat Local40 = (Local0 * Material.PreshaderBuffer[18].y);
	MaterialFloat2 Local41 = (Local17 * Material.PreshaderBuffer[20].zw);
	MaterialFloat2 Local42 = (MaterialFloat2(Local39,Local40) + Local41);
	MaterialFloat Local43 = MaterialStoreTexCoordScale(Parameters, Local42, 0);
	MaterialFloat4 Local44 = UnpackNormalMap(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(Material_Texture2D_2Sampler,View.MaterialTextureBilinearWrapedSampler),Local42));
	MaterialFloat Local45 = MaterialStoreTexSample(Parameters, Local44, 0);
	MaterialFloat3 Local46 = lerp(Local44.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[21].y);
	MaterialFloat Local47 = (Local46.b + 1.00000000);
	MaterialFloat Local48 = (Local0 * Material.PreshaderBuffer[22].z);
	MaterialFloat Local49 = (Local0 * Material.PreshaderBuffer[22].w);
	MaterialFloat2 Local50 = (Local17 * Material.PreshaderBuffer[23].zw);
	MaterialFloat2 Local51 = (MaterialFloat2(Local48,Local49) + Local50);
	MaterialFloat Local52 = MaterialStoreTexCoordScale(Parameters, Local51, 0);
	MaterialFloat4 Local53 = UnpackNormalMap(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(Material_Texture2D_3Sampler,View.MaterialTextureBilinearWrapedSampler),Local51));
	MaterialFloat Local54 = MaterialStoreTexSample(Parameters, Local53, 0);
	MaterialFloat3 Local55 = lerp(Local53.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[24].y);
	MaterialFloat2 Local56 = (Local55.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local57 = dot(MaterialFloat3(Local46.rg,Local47),MaterialFloat3(Local56,Local55.b));
	MaterialFloat3 Local58 = (MaterialFloat3(Local46.rg,Local47) * ((MaterialFloat3)Local57));
	MaterialFloat3 Local59 = (((MaterialFloat3)Local47) * MaterialFloat3(Local56,Local55.b));
	MaterialFloat3 Local60 = (Local58 - Local59);
	MaterialFloat2 Local61 = (Local60.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local62 = dot(MaterialFloat3(Local37.rg,Local38),MaterialFloat3(Local61,Local60.b));
	MaterialFloat3 Local63 = (MaterialFloat3(Local37.rg,Local38) * ((MaterialFloat3)Local62));
	MaterialFloat3 Local64 = (((MaterialFloat3)Local38) * MaterialFloat3(Local61,Local60.b));
	MaterialFloat3 Local65 = (Local63 - Local64);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local65;


#if TEMPLATE_USES_STRATA
	Parameters.StrataPixelFootprint = StrataGetPixelFootprint(Parameters.WorldPosition_CamRelative);
	Parameters.SharedLocalBases = StrataInitialiseSharedLocalBases();
	Parameters.StrataTree = GetInitialisedStrataTree();
#endif

	// Note that here MaterialNormal can be in world space or tangent space
	float3 MaterialNormal = GetMaterialNormal(Parameters, PixelMaterialInputs);

#if MATERIAL_TANGENTSPACENORMAL

#if FEATURE_LEVEL >= FEATURE_LEVEL_SM4
	// Mobile will rely on only the final normalize for performance
	MaterialNormal = normalize(MaterialNormal);
#endif

	// normalizing after the tangent space to world space conversion improves quality with sheared bases (UV layout to WS causes shrearing)
	// use full precision normalize to avoid overflows
	Parameters.WorldNormal = TransformTangentNormalToWorld(Parameters.TangentToWorld, MaterialNormal);

#else //MATERIAL_TANGENTSPACENORMAL

	Parameters.WorldNormal = normalize(MaterialNormal);

#endif //MATERIAL_TANGENTSPACENORMAL

#if MATERIAL_TANGENTSPACENORMAL
	// flip the normal for backfaces being rendered with a two-sided material
	Parameters.WorldNormal *= Parameters.TwoSidedSign;
#endif

	Parameters.ReflectionVector = ReflectionAboutCustomWorldNormal(Parameters, Parameters.WorldNormal, false);

#if !PARTICLE_SPRITE_FACTORY
	Parameters.Particle.MotionBlurFade = 1.0f;
#endif // !PARTICLE_SPRITE_FACTORY

	// Now the rest of the inputs
	MaterialFloat Local66 = (Local0 * Material.PreshaderBuffer[24].z);
	MaterialFloat Local67 = (Local66 * Material.PreshaderBuffer[27].x);
	MaterialFloat Local68 = (Local66 * Material.PreshaderBuffer[27].y);
	MaterialFloat2 Local69 = (Local17 * Material.PreshaderBuffer[29].zw);
	MaterialFloat2 Local70 = (MaterialFloat2(Local67,Local68) + Local69);
	MaterialFloat Local71 = (Local0 * Material.PreshaderBuffer[32].x);
	MaterialFloat Local72 = (Local0 * Material.PreshaderBuffer[32].y);
	MaterialFloat2 Local73 = (Local17 * Material.PreshaderBuffer[34].zw);
	MaterialFloat2 Local74 = (MaterialFloat2(Local71,Local72) + Local73);
	MaterialFloat Local75 = MaterialStoreTexCoordScale(Parameters, Local74, 1);
	MaterialFloat4 Local76 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_4,GetMaterialSharedSampler(Material_Texture2D_4Sampler,View.MaterialTextureBilinearWrapedSampler),Local74));
	MaterialFloat Local77 = MaterialStoreTexSample(Parameters, Local76, 1);
	MaterialFloat3 Local78 = lerp(Local76.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[35].y);
	MaterialFloat Local79 = (Local78.b + 1.00000000);
	MaterialFloat Local80 = (Local0 * Material.PreshaderBuffer[36].z);
	MaterialFloat Local81 = (Local0 * Material.PreshaderBuffer[36].w);
	MaterialFloat2 Local82 = (Local17 * Material.PreshaderBuffer[37].zw);
	MaterialFloat2 Local83 = (MaterialFloat2(Local80,Local81) + Local82);
	MaterialFloat Local84 = MaterialStoreTexCoordScale(Parameters, Local83, 1);
	MaterialFloat4 Local85 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(Material_Texture2D_5Sampler,View.MaterialTextureBilinearWrapedSampler),Local83));
	MaterialFloat Local86 = MaterialStoreTexSample(Parameters, Local85, 1);
	MaterialFloat3 Local87 = lerp(Local85.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[38].y);
	MaterialFloat2 Local88 = (Local87.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local89 = dot(MaterialFloat3(Local78.rg,Local79),MaterialFloat3(Local88,Local87.b));
	MaterialFloat3 Local90 = (MaterialFloat3(Local78.rg,Local79) * ((MaterialFloat3)Local89));
	MaterialFloat3 Local91 = (((MaterialFloat3)Local79) * MaterialFloat3(Local88,Local87.b));
	MaterialFloat3 Local92 = (Local90 - Local91);
	MaterialFloat2 Local93 = (Local92.rg * ((MaterialFloat2)Material.PreshaderBuffer[38].z));
	MaterialFloat2 Local94 = (Local70 + Local93);
	MaterialFloat Local95 = MaterialStoreTexCoordScale(Parameters, Local94, 2);
	MaterialFloat4 Local96 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(Material_Texture2D_6Sampler,View.MaterialTextureBilinearWrapedSampler),Local94));
	MaterialFloat Local97 = MaterialStoreTexSample(Parameters, Local96, 2);
	MaterialFloat Local98 = (Local66 * Material.PreshaderBuffer[39].w);
	MaterialFloat Local99 = (Local66 * Material.PreshaderBuffer[40].x);
	MaterialFloat2 Local100 = (Local17 * Material.PreshaderBuffer[41].xy);
	MaterialFloat2 Local101 = (MaterialFloat2(Local98,Local99) + Local100);
	MaterialFloat2 Local102 = (Local101 + Local93);
	MaterialFloat Local103 = MaterialStoreTexCoordScale(Parameters, Local102, 2);
	MaterialFloat4 Local104 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(Material_Texture2D_7Sampler,View.MaterialTextureBilinearWrapedSampler),Local102));
	MaterialFloat Local105 = MaterialStoreTexSample(Parameters, Local104, 2);
	MaterialFloat3 Local106 = (Local96.rgb + Local104.rgb);
	MaterialFloat3 Local107 = (Local106 / ((MaterialFloat3)2.00000000));
	MaterialFloat Local108 = dot(Local107,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local109 = lerp(Local107,((MaterialFloat3)Local108),Material.PreshaderBuffer[41].z);
	MaterialFloat3 Local110 = PositiveClampedPow(Local109,((MaterialFloat3)Material.PreshaderBuffer[41].w));
	MaterialFloat4 Local111 = Parameters.VertexColor;
	MaterialFloat Local112 = DERIV_BASE_VALUE(Local111).r;
	MaterialFloat Local113 = (Local14 + DERIV_BASE_VALUE(Local112));
	MaterialFloat Local114 = DERIV_BASE_VALUE(Local111).g;
	MaterialFloat Local115 = (Local113 - DERIV_BASE_VALUE(Local114));
	MaterialFloat Local116 = saturate(Local115);
	MaterialFloat3 Local117 = (Local110 * ((MaterialFloat3)Local116));
	MaterialFloat3 Local118 = (Local117 * Material.PreshaderBuffer[43].xyz);
	MaterialFloat3 Local119 = (Local118 + Material.PreshaderBuffer[45].xyz);
	MaterialFloat3 Local120 = (Local119 * ((MaterialFloat3)Material.PreshaderBuffer[45].w));
	MaterialFloat3 Local121 = lerp(Local120,Material.PreshaderBuffer[46].yzw,Material.PreshaderBuffer[46].x);
	MaterialFloat Local122 = (Local117.r * Material.PreshaderBuffer[47].z);
	MaterialFloat Local123 = (Local122 + Material.PreshaderBuffer[47].w);

	PixelMaterialInputs.EmissiveColor = Local121;
	PixelMaterialInputs.Opacity = Local123;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local119;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = Material.PreshaderBuffer[47].x;
	PixelMaterialInputs.Roughness = Material.PreshaderBuffer[47].y;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local65;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = 1.00000000;
	PixelMaterialInputs.Refraction = MaterialFloat2(Material.PreshaderBuffer[48].x,Material.PreshaderBuffer[48].y);
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 10;
	PixelMaterialInputs.FrontMaterial = GetInitialisedStrataData();


#if MATERIAL_USES_ANISOTROPY
	Parameters.WorldTangent = CalculateAnisotropyTangent(Parameters, PixelMaterialInputs);
#else
	Parameters.WorldTangent = 0;
#endif
}
		void surf( Input In, inout SurfaceOutputStandard o )
		{
			InitializeExpressions();

			float3 Z3 = float3( 0, 0, 0 );
			float4 Z4 = float4( 0, 0, 0, 0 );

			float3 UnrealWorldPos = float3( In.worldPos.x, In.worldPos.y, In.worldPos.z );
			
			float3 UnrealNormal = In.normal2;

			FMaterialPixelParameters Parameters = (FMaterialPixelParameters)0;
			#if NUM_TEX_COORD_INTERPOLATORS > 0			
				Parameters.TexCoords[ 0 ] = float2( In.uv_MainTex.x, 1.0 - In.uv_MainTex.y );
			#endif
			#if NUM_TEX_COORD_INTERPOLATORS > 1
				Parameters.TexCoords[ 1 ] = float2( In.uv2_Material_Texture2D_0.x, 1.0 - In.uv2_Material_Texture2D_0.y );
			#endif
			#if NUM_TEX_COORD_INTERPOLATORS > 2
			for( int i = 2; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
			{
				Parameters.TexCoords[ i ] = float2( In.uv_MainTex.x, 1.0 - In.uv_MainTex.y );
			}
			#endif
			Parameters.VertexColor = In.color;
			Parameters.WorldNormal = UnrealNormal;
			Parameters.ReflectionVector = half3( 0, 0, 1 );
			Parameters.CameraVector = normalize( _WorldSpaceCameraPos.xyz - UnrealWorldPos.xyz );
			//Parameters.CameraVector = mul( ( float3x3 )unity_CameraToWorld, float3( 0, 0, 1 ) ) * -1;
			Parameters.LightVector = half3( 0, 0, 0 );
			float4 screenpos = In.screenPos;
			screenpos /= screenpos.w;
			//screenpos.y = 1 - screenpos.y;
			Parameters.SvPosition = float4( screenpos.x, screenpos.y, 0, 0 );
			Parameters.ScreenPosition = Parameters.SvPosition;

			Parameters.UnMirrored = 1;

			Parameters.TwoSidedSign = 1;
			

			float3 InWorldNormal = UnrealNormal;
			float4 InTangent = In.tangent;
			float4 tangentWorld = float4( UnityObjectToWorldDir( InTangent.xyz ), InTangent.w );
			tangentWorld.xyz = normalize( tangentWorld.xyz );
			float3x3 OriginalTangentToWorld = CreateTangentToWorldPerVertex( InWorldNormal, tangentWorld.xyz, tangentWorld.w );
			Parameters.TangentToWorld = OriginalTangentToWorld;

			//WorldAlignedTexturing in UE relies on the fact that coords there are 100x larger, prepare values for that
			//but watch out for any computation that might get skewed as a side effect
			UnrealWorldPos = ToUnrealPos( UnrealWorldPos );
			
			Parameters.AbsoluteWorldPosition = UnrealWorldPos;
			Parameters.WorldPosition_CamRelative = UnrealWorldPos;
			Parameters.WorldPosition_NoOffsets = UnrealWorldPos;

			Parameters.WorldPosition_NoOffsets_CamRelative = Parameters.WorldPosition_CamRelative;
			Parameters.LightingPositionOffset = float3( 0, 0, 0 );

			Parameters.AOMaterialMask = 0;

			Parameters.Particle.RelativeTime = 0;
			Parameters.Particle.MotionBlurFade;
			Parameters.Particle.Random = 0;
			Parameters.Particle.Velocity = half4( 1, 1, 1, 1 );
			Parameters.Particle.Color = half4( 1, 1, 1, 1 );
			Parameters.Particle.TranslatedWorldPositionAndSize = float4( UnrealWorldPos, 0 );
			Parameters.Particle.MacroUV = half4(0,0,1,1);
			Parameters.Particle.DynamicParameter = half4(0,0,0,0);
			Parameters.Particle.LocalToWorld = float4x4( Z4, Z4, Z4, Z4 );
			Parameters.Particle.Size = float2(1,1);
			Parameters.Particle.SubUVCoords[ 0 ] = Parameters.Particle.SubUVCoords[ 1 ] = float2( 0, 0 );
			Parameters.Particle.SubUVLerp = 0.0;
			Parameters.TexCoordScalesParams = float2( 0, 0 );
			Parameters.PrimitiveId = 0;
			Parameters.VirtualTextureFeedback = 0;

			FPixelMaterialInputs PixelMaterialInputs = ( FPixelMaterialInputs)0;
			PixelMaterialInputs.Normal = float3( 0, 0, 1 );
			PixelMaterialInputs.ShadingModel = 0;
			PixelMaterialInputs.FrontMaterial = 0;

			View.GameTime = View.RealTime = _Time.y;// _Time is (t/20, t, t*2, t*3)
			View.PrevFrameGameTime = View.GameTime - unity_DeltaTime.x;//(dt, 1/dt, smoothDt, 1/smoothDt)
			View.PrevFrameRealTime = View.RealTime;
			View.DeltaTime = unity_DeltaTime.x;
			View.MaterialTextureMipBias = 0.0;
			View.TemporalAAParams = float4( 0, 0, 0, 0 );
			View.ViewRectMin = float2( 0, 0 );
			View.ViewSizeAndInvSize = View_BufferSizeAndInvSize;
			View.MaterialTextureDerivativeMultiply = 1.0f;
			View.StateFrameIndexMod8 = 0;
			View.FrameNumber = (int)_Time.y;
			View.FieldOfViewWideAngles = float2( PI * 0.42f, PI * 0.42f );//75degrees, default unity
			View.RuntimeVirtualTextureMipLevel = float4( 0, 0, 0, 0 );
			View.PreExposure = 0;
			View.BufferBilinearUVMinMax = float4(
				View_BufferSizeAndInvSize.z * ( 0 + 0.5 ),//EffectiveViewRect.Min.X
				View_BufferSizeAndInvSize.w * ( 0 + 0.5 ),//EffectiveViewRect.Min.Y
				View_BufferSizeAndInvSize.z * ( View_BufferSizeAndInvSize.x - 0.5 ),//EffectiveViewRect.Max.X
				View_BufferSizeAndInvSize.w * ( View_BufferSizeAndInvSize.y - 0.5 ) );//EffectiveViewRect.Max.Y

			for( int i2 = 0; i2 < 40; i2++ )
				View.PrimitiveSceneData[ i2 ] = float4( 0, 0, 0, 0 );

			float4x4 ViewMatrix = transpose( unity_MatrixV );
			float4x4 InverseViewMatrix = transpose( unity_MatrixInvV );
			float4x4 ViewProjectionMatrix = transpose( unity_MatrixVP );

			uint PrimitiveBaseOffset = Parameters.PrimitiveId * PRIMITIVE_SCENE_DATA_STRIDE;
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 0 ] = unity_ObjectToWorld[ 0 ];//LocalToWorld
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 1 ] = unity_ObjectToWorld[ 1 ];//LocalToWorld
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 2 ] = unity_ObjectToWorld[ 2 ];//LocalToWorld
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 3 ] = unity_ObjectToWorld[ 3 ];//LocalToWorld
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 6 ] = unity_WorldToObject[ 0 ];//WorldToLocal
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 7 ] = unity_WorldToObject[ 1 ];//WorldToLocal
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 8 ] = unity_WorldToObject[ 2 ];//WorldToLocal
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 9 ] = unity_WorldToObject[ 3 ];//WorldToLocal
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 10 ] = unity_WorldToObject[ 0 ];//PreviousLocalToWorld
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 11 ] = unity_WorldToObject[ 1 ];//PreviousLocalToWorld
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 12 ] = unity_WorldToObject[ 2 ];//PreviousLocalToWorld
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 13 ] = unity_WorldToObject[ 3 ];//PreviousLocalToWorld
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 18 ] = float4( ToUnrealPos( UNITY_MATRIX_M[ 3 ] ), 0 );//ActorWorldPosition
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 19 ] = LocalObjectBoundsMax - LocalObjectBoundsMin;//ObjectBounds
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 21 ] = mul( unity_ObjectToWorld, float3( 1, 0, 0 ) );//ObjectOrientation
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 23 ] = LocalObjectBoundsMin;//LocalObjectBoundsMin
			View.PrimitiveSceneData[ PrimitiveBaseOffset + 24 ] = LocalObjectBoundsMax;//LocalObjectBoundsMax

			#ifdef UE5
				ResolvedView.WorldCameraOrigin = LWCPromote( ToUnrealPos( _WorldSpaceCameraPos.xyz ) );
				ResolvedView.PreViewTranslation = LWCPromote( float3( 0, 0, 0 ) );
				ResolvedView.WorldViewOrigin = LWCPromote( float3( 0, 0, 0 ) );
			#else
				ResolvedView.WorldCameraOrigin = ToUnrealPos( _WorldSpaceCameraPos.xyz );
				ResolvedView.PreViewTranslation = float3( 0, 0, 0 );
				ResolvedView.WorldViewOrigin = float3( 0, 0, 0 );
			#endif
			ResolvedView.PrevWorldCameraOrigin = ResolvedView.WorldCameraOrigin;
			ResolvedView.ScreenPositionScaleBias = float4( 1, 1, 0, 0 );
			ResolvedView.TranslatedWorldToView = ViewMatrix;
			ResolvedView.TranslatedWorldToCameraView = ViewMatrix;
			ResolvedView.TranslatedWorldToClip = ViewProjectionMatrix;
			ResolvedView.ViewToTranslatedWorld = InverseViewMatrix;
			ResolvedView.PrevViewToTranslatedWorld = ResolvedView.ViewToTranslatedWorld;
			ResolvedView.CameraViewToTranslatedWorld = InverseViewMatrix;
			ResolvedView.BufferBilinearUVMinMax = View.BufferBilinearUVMinMax;
			ResolvedView.XRPassthroughCameraUVs[ 0 ] = ResolvedView.XRPassthroughCameraUVs[ 1 ] = float4( 0, 0, 1, 1 );
			Primitive.WorldToLocal = unity_WorldToObject;
			Primitive.LocalToWorld = unity_ObjectToWorld;
			CalcPixelMaterialInputs( Parameters, PixelMaterialInputs );

			#define HAS_WORLDSPACE_NORMAL 0
			#if HAS_WORLDSPACE_NORMAL
				PixelMaterialInputs.Normal = mul( PixelMaterialInputs.Normal, (MaterialFloat3x3)( transpose( OriginalTangentToWorld ) ) );
			#endif

			o.Albedo = PixelMaterialInputs.BaseColor.rgb;
			o.Alpha = PixelMaterialInputs.Opacity;
			//if( PixelMaterialInputs.OpacityMask < 0.333 ) discard;

			o.Metallic = PixelMaterialInputs.Metallic;
			o.Smoothness = 1.0 - PixelMaterialInputs.Roughness;
			o.Normal = normalize( PixelMaterialInputs.Normal );
			o.Emission = PixelMaterialInputs.EmissiveColor.rgb;
			o.Occlusion = PixelMaterialInputs.AmbientOcclusion;

			//BLEND_ADDITIVE o.Alpha = ( o.Emission.r + o.Emission.g + o.Emission.b ) / 3;
		}
		ENDCG
	}
	Fallback "Diffuse"
}