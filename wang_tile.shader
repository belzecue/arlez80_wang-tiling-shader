/*
	王のタイル for Godot Engine by あるる（きのもと 結衣）
	Wang tiles for Godot Engine by Yui Kinomoto @arlez80

	MIT License
*/
shader_type spatial;

uniform float scale = 20.0;
uniform vec2 seed = vec2( 0.0, 0.0 );
uniform float factor : hint_range( 0.0, 1.0 ) = 0.0;
uniform sampler2D tiles_tex : hint_albedo;

vec2 random( vec2 pos )
{ 
	return clamp( fract(
		sin(
			vec2(
				dot(pos, vec2(12.9898,78.233))
			,	dot(pos, vec2(-148.998,-65.233))
			) + seed
		) * 43758.5453
	) - vec2( factor ), vec2( 0.0 ), vec2( 1.0 ) );
}

void fragment( )
{
	vec2 origin_uv = floor( UV * scale );
	vec2 right_uv = origin_uv + vec2( 1.0, 0.0 );
	vec2 down_uv = origin_uv + vec2( 0.0, 1.0 );

	vec2 origin_tile = step( 0.5, random( origin_uv ) );
	vec2 right_tile = step( 0.5, random( right_uv ) );
	vec2 down_tile = step( 0.5, random( down_uv ) );

	vec2 tile_uv = vec2(
		mix( right_tile.x, 3.0 - right_tile.x, origin_tile.x )
	,	3.0 + mix( down_tile.y, 3.0 - down_tile.y, origin_tile.y )
	) * 0.25 + ( fract( UV * scale ) * 0.25 );

	ALBEDO = textureLod( tiles_tex, tile_uv, 0.0 ).rgb;
}
