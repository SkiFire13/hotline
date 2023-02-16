struct vs_input_3d {
    float3 position : POSITION;
    float4 colour: TEXCOORD;
};

struct vs_output {
    float4 position : SV_POSITION0;
    float4 colour: TEXCOORD;
};

struct ps_output {
    float4 colour : SV_Target;
};

cbuffer view_push_constants : register(b0) {
    float4x4 projection_matrix;
};

cbuffer draw_push_constants : register(b1) {
    float4x4 world_matrix;
};

struct vs_input_mesh {
    float3 position : POSITION;
    float2 texcoord: TEXCOORD0;
    float3 normal : TEXCOORD1;
    float3 tangent : TEXCOORD2;
    float3 bitangent : TEXCOORD3;
};

ps_output ps_main( vs_output input ) {
    ps_output output;
    
    output.colour = input.colour;

    return output;
}

vs_output vs_mesh(vs_input_mesh input)
{
    vs_output output;

	float4 pos = float4(input.position.xyz, 1.0);
    
    (world_matrix);
    pos = mul(pos, world_matrix);
    output.position = mul(pos, projection_matrix);

    output.colour = float4(input.normal.xyz, 1.0);
    //output.colour = float4(0.0, 1.0, 1.0, 1.0);
    
    return output;
}