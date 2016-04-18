using System;
using UnityEngine;

namespace UnityStandardAssets.ImageEffects
{
    [ExecuteInEditMode]
    [AddComponentMenu("Image Effects/Color Adjustments/GrayscaleCardboard")]
    public class GrayscaleCardboard : ImageEffectBase {
        public Texture  textureRamp;
		public bool flag_left;

        [Range(-1.0f,1.0f)]
        public float    rampOffset;

        // Called by camera to apply image effect
        void OnRenderImage (RenderTexture source, RenderTexture destination) {
            material.SetTexture("_RampTex", textureRamp);
            material.SetFloat("_RampOffset", rampOffset);
			material.SetFloat ("_XOffset", flag_left ? 0 : 1);
            Graphics.Blit (source, destination, material);
        }
    }
}
