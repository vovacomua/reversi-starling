package engine
{
	import engine.tileStates.StateContext;
	
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.system.System;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	public class Tile extends Sprite
	{	
		// Embed the Atlas XML
		[Embed(source="../assets/tiles.xml", mimeType="application/octet-stream")]
		public static const AtlasXml:Class;
		
		// Embed the Atlas Texture:
		[Embed(source="../assets/tiles.png")]
		public static const AtlasTexture:Class;
		
		private var atlas:TextureAtlas;
		
		private var player:FrameSprite;
		public var stateContext:StateContext;
		
		public function Tile()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded ( e:Event ):void
		{
			//addButtons();
			//this.addEventListener(Event.TRIGGERED, onClick);
			
			// create atlas
			var texture:Texture = Texture.fromEmbeddedAsset(AtlasTexture);
			var xml:XML = XML(new AtlasXml());
			atlas = new TextureAtlas(texture, xml);
			
			player = new FrameSprite(40);
			player.x = player.y = 0;
			//player.width = player.height = 40;
			
			//add player sprite to the stage
			addChild(player);
			
			pushToFrameSprite("setEmpty", 1);
			pushToFrameSprite("Hint2Empty", 2);
			pushToFrameSprite("Empty2Hint", 3);
			pushToFrameSprite("setB", 4);
			pushToFrameSprite("setW", 5);
			pushToFrameSprite("flip2B", 6);
			pushToFrameSprite("flip2W", 7);
			
			stateContext = new StateContext(player);
			stateContext.setEmpty(0);
		}
		
		private function pushToFrameSprite(frameName:String, pos:int):void{
			
			var mc:MovieClip = new MovieClip(atlas.getTextures(frameName), 10);
			mc.loop = false;
			Starling.juggler.add(mc);
			
			player.addFrame(frameName);
			player.addChildToFrame(mc, pos);	
			
		}	
	}
}