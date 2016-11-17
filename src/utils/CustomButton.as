package utils
{
    import flash.geom.Point;
    import flash.geom.Rectangle;
	import flash.display.Bitmap;
    
    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.textures.Texture;
    
    public class CustomButton extends Button
    {
		[Embed( source = "../assets/bg.png" )]
		private var BG				:Class;
		
		private var bgBMP			:Bitmap;
		private var bgTexture		:Texture;
		
		
        public function CustomButton(text:String="")
        {
			bgBMP = new BG();
			bgTexture = Texture.fromBitmap( bgBMP, false );
			
            //super(bgTexture, text, bgTexture);
			super(bgTexture, text);
			this.fontSize = 25;
        }
        
        
    }
}