#include <metal_stdlib>
using namespace metal;
#include <SceneKit/scn_metal>

struct NodeBuffer {
  float4x4 modelTransform;
  float4x4 modelViewProjectionTransform;
  float4x4 modelViewTransform;
  float4x4 normalTransform;
  float2x3 boundingBox;
  int time;
};

struct VertexInput {
  float3 position  [[attribute(SCNVertexSemanticPosition)]];
  float2 uv [[attribute(SCNVertexSemanticTexcoord0)]];
};

struct VertexOut {
  float4 position [[position]];
  float2 uv;
};

vertex VertexOut myVertexShaderFunction(VertexInput in [[ stage_in ]], constant NodeBuffer& scn_node [[buffer(1)]]) {
  VertexOut out;
  out.position = scn_node.modelViewProjectionTransform * float4(in.position, 1.0);
  out.uv = in.uv;
  return out;
}

fragment float4 myFragmentShaderFunction(VertexOut out [[ stage_in ]], constant SCNSceneBuffer& scn_frame [[buffer(0)]]) {
//    float4 outputColor = float4(out.uv.x, out.uv.y, 0.0, 1.0);
//    return outputColor;
//    xlatMtlShaderOutput _mtl_o;
  float3 col_1 = 0;
  float2 uv_2 = 0;
  float2 tmpvar_3 = 0;
  float2 iResolution = float2(16.0, 9.0);
  tmpvar_3 = (((2.0 *
    (iResolution * out.uv)
  ) - iResolution) / iResolution.y);
  uv_2 = tmpvar_3;
  float tmpvar_4 = 0;
  float tmpvar_5 = 0;
  tmpvar_5 = clamp (((
    abs((tmpvar_3.y + 0.2))
   - 0.1) / -0.12), 0.0, 1.0);
  tmpvar_4 = (tmpvar_5 * (tmpvar_5 * (3.0 -
    (2.0 * tmpvar_5)
  )));
  col_1 = float3(0.0, 0.1, 0.2);
  if ((tmpvar_3.y < -0.2)) {
    uv_2.y = (3.0 / (abs(
      (tmpvar_3.y + 0.2)
    ) + 0.05));
    uv_2.x = (tmpvar_3.x * uv_2.y);
    float2 uv_6 = 0;
    float2 lines_7 = 0;
    float2 tmpvar_8 = 0;
    tmpvar_8.x = uv_2.y;
    tmpvar_8.y = ((uv_2.y * uv_2.y) * 0.2);
    float2 tmpvar_9 = 0;
    tmpvar_9 = (tmpvar_8 * 0.01);
    float2 tmpvar_10 = 0;
    tmpvar_10.x = 0.0;
    tmpvar_10.y = (4.2 * scn_frame.time);
    uv_6 = (uv_2 + tmpvar_10);
    float2 tmpvar_11 = 0;
    tmpvar_11 = abs((fract(uv_6) - 0.5));
    uv_6 = tmpvar_11;
    float2 tmpvar_12 = 0;
    tmpvar_12 = clamp (((tmpvar_11 - tmpvar_9) / -(tmpvar_9)), 0.0, 1.0);
    float2 edge0_13 = 0;
    edge0_13 = (tmpvar_9 * 5.0);
    float2 tmpvar_14 = 0;
    tmpvar_14 = clamp (((tmpvar_11 - edge0_13) / -(edge0_13)), 0.0, 1.0);
    lines_7 = ((tmpvar_12 * (tmpvar_12 *
      (3.0 - (2.0 * tmpvar_12))
    )) + ((tmpvar_14 *
      (tmpvar_14 * (3.0 - (2.0 * tmpvar_14)))
    ) * 0.4));
    col_1 = mix (float3(0.0, 0.1, 0.2), float3(1.0, 0.5, 1.0), clamp ((lines_7.x + lines_7.y), 0.0, 3.0));
  } else {
    float2 cloudUV_15 = 0;
    float2 sunUV_16 = 0;
    float tmpvar_17 = 0;
    tmpvar_17 = min (((uv_2.y * 4.5) - 0.5), 1.0);
    uv_2.y = (uv_2.y - 0.59);
    sunUV_16 = (uv_2 + float2(0.75, 0.2));
    float tmpvar_18 = 0;
    tmpvar_18 = clamp (((
      sqrt(dot (sunUV_16, sunUV_16))
     - 0.3) / -0.01000002), 0.0, 1.0);
    float tmpvar_19 = 0;
    tmpvar_19 = clamp (((
      sqrt(dot (sunUV_16, sunUV_16))
     - 0.7) / -0.7), 0.0, 1.0);
    float3 tmpvar_20 = 0;
    tmpvar_20 = (mix (float3(1.0, 0.2, 1.0), float3(1.0, 0.4, 0.1), (
      (sunUV_16.y * 2.0)
     + 0.2)) * (clamp (
      ((tmpvar_18 * (tmpvar_18 * (3.0 -
        (2.0 * tmpvar_18)
      ))) * clamp (((3.0 *
        sin(((sunUV_16.y + (0.204 * scn_frame.time)) * 100.0))
      ) + clamp (
        ((sunUV_16.y * 14.0) + 1.0)
      , -6.0, 6.0)), 0.0, 1.0))
    , 0.0, 1.0) + (
      (tmpvar_19 * (tmpvar_19 * (3.0 - (2.0 * tmpvar_19))))
     * 0.6)));
    col_1 = tmpvar_20;
    float tmpvar_21 = 0;
    float2 p_22 = 0;
    p_22 = (uv_2 + float2(-0.75, 0.5));
    float r1_23 = 0;
    r1_23 = (1.75 + pow ((uv_2.y * uv_2.y), 2.1));
    float2 tmpvar_24 = 0;
    tmpvar_24.x = (0.2 - r1_23);
    tmpvar_24.y = 1.0;
    p_22.x = abs(p_22.x);
    float tmpvar_25 = 0;
    if ((p_22.y < 0.0)) {
      tmpvar_25 = r1_23;
    } else {
      tmpvar_25 = 0.2;
    };
    float2 tmpvar_26 = 0;
    tmpvar_26.x = (p_22.x - min (p_22.x, tmpvar_25));
    tmpvar_26.y = (abs(p_22.y) - 0.5);
    float2 tmpvar_27 = 0;
    tmpvar_27 = ((p_22 - float2(0.2, 0.5)) + (tmpvar_24 * clamp (
      (dot ((float2(0.2, 0.5) - p_22), tmpvar_24) / dot (tmpvar_24, tmpvar_24))
    , 0.0, 1.0)));
    float tmpvar_28 = 0;
    if (((tmpvar_27.x < 0.0) && (tmpvar_26.y < 0.0))) {
      tmpvar_28 = -1.0;
    } else {
      tmpvar_28 = 1.0;
    };
    tmpvar_21 = (tmpvar_28 * sqrt(min (
      dot (tmpvar_26, tmpvar_26)
    ,
      dot (tmpvar_27, tmpvar_27)
    )));
    float tmpvar_29 = 0;
    tmpvar_29 = clamp (((
      (uv_2.y + (sin((
        (uv_2.x * 20.0)
       +
        (scn_frame.time * 2.0)
      )) * 0.05))
     + 0.2) / 0.01), 0.0, 1.0);
    float tmpvar_30 = 0;
    tmpvar_30 = clamp ((abs(tmpvar_21) / 0.01), 0.0, 1.0);
    float3 tmpvar_31 = 0;
    tmpvar_31 = mix (mix (mix (tmpvar_20,
      mix (float3(0.0, 0.0, 0.25), float3(1.0, 0.0, 0.5), tmpvar_17)
    ,
      float((0.0 >= tmpvar_21))
    ), float3(1.0, 0.5, 1.0), (
      (tmpvar_29 * (tmpvar_29 * (3.0 - (2.0 * tmpvar_29))))
     *
      float((0.0 >= tmpvar_21))
    )), float3(1.0, 0.5, 1.0), (1.0 - (tmpvar_30 *
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )));
    col_1 = (tmpvar_31 + mix (tmpvar_31, mix (float3(1.0, 0.12, 0.8), float3(0.0, 0.0, 0.2),
      clamp (((uv_2.y * 3.5) + 3.0), 0.0, 1.0)
    ), float(
      (tmpvar_21 >= 0.0)
    )));
    cloudUV_15.y = uv_2.y;
    cloudUV_15.x = ((float(fmod ((uv_2.x +
      (scn_frame.time * 0.1)
    ), 4.0))) - 2.0);
    float tmpvar_32 = 0;
    tmpvar_32 = (scn_frame.time * 0.5);
    float2 tmpvar_33 = 0;
    tmpvar_33.x = (0.1 + (sin(
      (tmpvar_32 + 140.5)
    ) * 0.1));
    tmpvar_33.y = -0.5;
    float2 tmpvar_34 = 0;
    tmpvar_34.x = (1.05 + (cos(
      ((tmpvar_32 * 0.9) - 36.56)
    ) * 0.1));
    tmpvar_34.y = -0.5;
    float2 tmpvar_35 = 0;
    tmpvar_35.x = (0.2 + (cos(
      ((tmpvar_32 * 0.867) + 387.165)
    ) * 0.1));
    tmpvar_35.y = -0.25;
    float2 tmpvar_36 = 0;
    tmpvar_36.x = (0.5 + (cos(
      ((tmpvar_32 * 0.9675) - 15.162)
    ) * 0.09));
    tmpvar_36.y = -0.25;
    float2 tmpvar_37 = 0;
    tmpvar_37 = (cloudUV_15 - tmpvar_33);
    float2 tmpvar_38 = 0;
    tmpvar_38 = (tmpvar_34 - tmpvar_33);
    float tmpvar_39 = 0;
    float2 x_40 = 0;
    x_40 = (tmpvar_37 - (tmpvar_38 * clamp (
      (dot (tmpvar_37, tmpvar_38) / dot (tmpvar_38, tmpvar_38))
    , 0.0, 1.0)));
    tmpvar_39 = sqrt(dot (x_40, x_40));
    float2 tmpvar_41 = 0;
    tmpvar_41 = (cloudUV_15 - tmpvar_35);
    float2 tmpvar_42 = 0;
    tmpvar_42 = (tmpvar_36 - tmpvar_35);
    float tmpvar_43 = 0;
    float2 x_44 = 0;
    x_44 = (tmpvar_41 - (tmpvar_42 * clamp (
      (dot (tmpvar_41, tmpvar_42) / dot (tmpvar_42, tmpvar_42))
    , 0.0, 1.0)));
    tmpvar_43 = sqrt(dot (x_44, x_44));
    float2 tmpvar_45 = 0;
    tmpvar_45 = (abs((cloudUV_15 -
      ((max ((tmpvar_33 + float2(0.1125, 0.0)), (tmpvar_35 + float2(0.1125, 0.0))) + min ((tmpvar_34 - float2(0.1125, 0.0)), (tmpvar_36 - float2(0.1125, 0.0)))) * 0.5)
    )) - float2(0.04, 0.125));
    float2 tmpvar_46 = 0;
    tmpvar_46 = max (tmpvar_45, float2(0.0, 0.0));
    float tmpvar_47 = 0;
    tmpvar_47 = ((sqrt(
      dot (tmpvar_46, tmpvar_46)
    ) + min (
      max (tmpvar_45.x, tmpvar_45.y)
    , 0.0)) + 0.075);
    float tmpvar_48 = 0;
    tmpvar_48 = clamp ((0.5 + (
      (0.5 * (tmpvar_47 - tmpvar_39))
     / 0.05)), 0.0, 1.0);
    float tmpvar_49 = 0;
    tmpvar_49 = clamp ((0.5 + (
      (0.5 * (tmpvar_47 - tmpvar_43))
     / 0.05)), 0.0, 1.0);
    float2 tmpvar_50 = 0;
    tmpvar_50.x = (-0.9 + (cos(
      ((tmpvar_32 * 1.02) + 541.75)
    ) * 0.1));
    tmpvar_50.y = -0.6;
    float2 tmpvar_51 = 0;
    tmpvar_51.x = (-0.5 + (sin(
      ((tmpvar_32 * 0.9) - 316.56)
    ) * 0.1));
    tmpvar_51.y = -0.6;
    float2 tmpvar_52 = 0;
    tmpvar_52.x = (-1.5 + (cos(
      ((tmpvar_32 * 0.867) + 37.165)
    ) * 0.1));
    tmpvar_52.y = -0.35;
    float2 tmpvar_53 = 0;
    tmpvar_53.x = (-0.6 + (sin(
      ((tmpvar_32 * 0.9675) + 665.162)
    ) * 0.09));
    tmpvar_53.y = -0.35;
    float2 tmpvar_54 = 0;
    tmpvar_54 = (cloudUV_15 - tmpvar_50);
    float2 tmpvar_55 = 0;
    tmpvar_55 = (tmpvar_51 - tmpvar_50);
    float tmpvar_56 = 0;
    float2 x_57 = 0;
    x_57 = (tmpvar_54 - (tmpvar_55 * clamp (
      (dot (tmpvar_54, tmpvar_55) / dot (tmpvar_55, tmpvar_55))
    , 0.0, 1.0)));
    tmpvar_56 = sqrt(dot (x_57, x_57));
    float2 tmpvar_58 = 0;
    tmpvar_58 = (cloudUV_15 - tmpvar_52);
    float2 tmpvar_59 = 0;
    tmpvar_59 = (tmpvar_53 - tmpvar_52);
    float tmpvar_60 = 0;
    float2 x_61 = 0;
    x_61 = (tmpvar_58 - (tmpvar_59 * clamp (
      (dot (tmpvar_58, tmpvar_59) / dot (tmpvar_59, tmpvar_59))
    , 0.0, 1.0)));
    tmpvar_60 = sqrt(dot (x_61, x_61));
    float2 tmpvar_62 = 0;
    tmpvar_62 = (abs((cloudUV_15 -
      ((max ((tmpvar_50 + float2(0.1125, 0.0)), (tmpvar_52 + float2(0.1125, 0.0))) + min ((tmpvar_51 - float2(0.1125, 0.0)), (tmpvar_53 - float2(0.1125, 0.0)))) * 0.5)
    )) - float2(0.04, 0.125));
    float2 tmpvar_63 = 0;
    tmpvar_63 = max (tmpvar_62, float2(0.0, 0.0));
    float tmpvar_64 = 0;
    tmpvar_64 = ((sqrt(
      dot (tmpvar_63, tmpvar_63)
    ) + min (
      max (tmpvar_62.x, tmpvar_62.y)
    , 0.0)) + 0.075);
    float tmpvar_65 = 0;
    tmpvar_65 = clamp ((0.5 + (
      (0.5 * (tmpvar_64 - tmpvar_56))
     / 0.05)), 0.0, 1.0);
    float tmpvar_66 = 0;
    tmpvar_66 = clamp ((0.5 + (
      (0.5 * (tmpvar_64 - tmpvar_60))
     / 0.05)), 0.0, 1.0);
    float tmpvar_67 = 0;
    tmpvar_67 = min (min ((
      mix (tmpvar_47, tmpvar_39, tmpvar_48)
     -
      ((0.05 * tmpvar_48) * (1.0 - tmpvar_48))
    ), (
      mix (tmpvar_47, tmpvar_43, tmpvar_49)
     -
      ((0.05 * tmpvar_49) * (1.0 - tmpvar_49))
    )), min ((
      mix (tmpvar_64, tmpvar_56, tmpvar_65)
     -
      ((0.05 * tmpvar_65) * (1.0 - tmpvar_65))
    ), (
      mix (tmpvar_64, tmpvar_60, tmpvar_66)
     -
      ((0.05 * tmpvar_66) * (1.0 - tmpvar_66))
    )));
    float tmpvar_68 = 0;
    tmpvar_68 = clamp (((tmpvar_67 - 0.0749) / 0.0001000017), 0.0, 1.0);
    float tmpvar_69 = 0;
    tmpvar_69 = clamp ((abs(
      (tmpvar_67 - 0.075)
    ) / 0.01), 0.0, 1.0);
    col_1 = (mix (col_1, float3(0.0, 0.0, 0.2), (1.0 -
      (tmpvar_68 * (tmpvar_68 * (3.0 - (2.0 * tmpvar_68))))
    )) + float3((1.0 - (tmpvar_69 *
      (tmpvar_69 * (3.0 - (2.0 * tmpvar_69)))
    ))));
  };
  col_1 = (col_1 + ((tmpvar_4 * tmpvar_4) * tmpvar_4));
  float3 tmpvar_70 = 0;
  tmpvar_70 = mix ((col_1.xxx * 0.5), col_1, 0.7);
  col_1 = tmpvar_70;
  float4 tmpvar_71 = 0;
  tmpvar_71.w = 1.0;
  tmpvar_71.xyz = tmpvar_70;
  return tmpvar_71;
}
