package engine
{
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.system.System;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	//import starling.display.Shape;
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
		//[Embed( source = "/assets/Marble.png" )]
		//private var MarbleBMP		:Class;
		
		// Embed the Atlas XML
		[Embed(source="../assets/tiles.xml", mimeType="application/octet-stream")]
		public static const AtlasXml2:Class;
		
		// Embed the Atlas Texture:
		[Embed(source="../assets/tiles.png")]
		public static const AtlasTexture2:Class;
		
		//private var btn:Button;
		//private var btn2:Button;
		private var img:Image;
		
		//private var marbleBMP		:Bitmap;
		//private var marbleTexture	:Texture;
		
		private var mMovie:MovieClip;
		private var player:FrameSprite;
		private var player_blue:MovieClip;
		private var player_red:MovieClip;
		
		private var movie:MovieClip;
		
		private var currentTile:String = 'empty';
		
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
			var texture:Texture = Texture.fromEmbeddedAsset(AtlasTexture2);
			var xml:XML = XML(new AtlasXml2());
			var atlas:TextureAtlas = new TextureAtlas(texture, xml);
			
			player = new FrameSprite(40);
			player.x = player.y = 0;
			//player.width = player.height = 40;
			
			
			//
			var setEmpty:MovieClip = new MovieClip(atlas.getTextures("setEmpty"), 10);
			setEmpty.loop = false;
			Starling.juggler.add(setEmpty);
			
			//
			var Hint2Empty:MovieClip = new MovieClip(atlas.getTextures("Hint2Empty"), 10);
			Hint2Empty.loop = false;
			Starling.juggler.add(Hint2Empty);
			
			//
			var Empty2Hint:MovieClip = new MovieClip(atlas.getTextures("Empty2Hint"), 10);
			Empty2Hint.loop = false;
			Starling.juggler.add(Empty2Hint);
			
			//
			var setB:MovieClip = new MovieClip(atlas.getTextures("setB"), 10);
			setB.loop = false;
			Starling.juggler.add(setB);
			
			//
			var setW:MovieClip = new MovieClip(atlas.getTextures("setW"), 10);
			setW.loop = false;
			Starling.juggler.add(setW);
			
			//
			var flip2B:MovieClip = new MovieClip(atlas.getTextures("flip2B"), 10);
			flip2B.loop = false;
			Starling.juggler.add(flip2B);
			
			//
			var flip2W:MovieClip = new MovieClip(atlas.getTextures("flip2W"), 10);
			flip2W.loop = false;
			Starling.juggler.add(flip2W);
			
			//we add the player sprite to the stage
			addChild(player);
			
			player.addFrame("setEmpty");
			player.addChildToFrame(setEmpty, 1);
			
			player.addFrame("Hint2Empty");
			player.addChildToFrame(Hint2Empty, 2);
			
			player.addFrame("Empty2Hint");
			player.addChildToFrame(Empty2Hint, 3);
			
			player.addFrame("setB");
			player.addChildToFrame(setB, 4);
			
			player.addFrame("setW");
			player.addChildToFrame(setW, 5);
			
			player.addFrame("flip2B");
			player.addChildToFrame(flip2B, 6);
			
			player.addFrame("flip2W");
			player.addChildToFrame(flip2W, 7);
			
			//with the gotoAndStop functie you can give a frame label or the frame number, both work.
			player.gotoAndStop(setEmpty);
			//player.nextFrame();
		}
		
		public function setEmpty():void{
			switch(this.currentTile){
				case 'empty':
					//player.gotoAndStop('setEmpty');
					break;
				
				case 'hint':
					player.gotoAndStop('Hint2Empty');
					break;
			}
			this.currentTile = 'empty';
		}
		
		public function setHint():void{
			switch(this.currentTile){
				case 'empty':
					player.gotoAndStop('Empty2Hint');
					break;
			}
			this.currentTile = 'hint';
		}
		
		public function setBW(BW:String):void{
			if (this.currentTile == 'empty' || this.currentTile == 'hint'){
				player.gotoAndStop('set'+BW);
			} else if (this.currentTile != BW){
				player.gotoAndStop('flip2'+BW);
			}
			
			this.currentTile = BW;
		}
		
	}
}