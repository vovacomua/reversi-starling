package engine
{
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.system.System;
	
	import screens.ScreenState;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;
	
	import utils.CustomButton;
	
	public class BoardManager extends Sprite
	{
		[Embed( source = "../assets/board.png" )]
		private var BoardBMP			:Class;
		
		private var boardBMP			:Bitmap;
		
		private var boardTexture		:Texture;
		
		public var board:Image;
		
		public var buttonWhite:CustomButton;
		public var buttonBlack:CustomButton;
		public var scores:CustomButton;
		
		//private var tiles			:Shape;
		private var tiles:Tiles;
		//private var tile:Tile;
		
		private var pieces:uint = 8;
		public var boardOffset:uint = 50;
		public var boardSize:uint = 320;
		private var stoneSize:int = boardSize / pieces;
		
		private var maxDelay:Number = 0;
		
		public function BoardManager()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded ( e:Event ):void
		{
			var filterShadow:BlurFilter = BlurFilter.createDropShadow(7,1.0, 0x0, 0.5, 1, 0.5);
			
			
			boardBMP = new BoardBMP();
			boardTexture = Texture.fromBitmap( boardBMP, false );
			board = new Image(boardTexture);
			board.x = board.y = boardOffset;
			board.filter = filterShadow;
			this.addChild(board);
			
			/*tiles = new Shape();
			tiles.x = tiles.y = boardOffset;
			tiles.touchable = false;
			tiles.filter = filterShadow;
			this.addChild(tiles);*/
			
			tiles = new Tiles();
			tiles.x = tiles.y = boardOffset;
			//tiles.filter = filterShadow;
			this.addChild(tiles);
			addTiles();
			
			buttonWhite = new CustomButton('WHITE');
			buttonWhite.x = 60;
			buttonWhite.y = 130;
			this.addChild(buttonWhite);
			
			buttonBlack = new CustomButton('BLACK');
			buttonBlack.x = 60;
			buttonBlack.y = 250;
			this.addChild(buttonBlack);
			
			scores = new CustomButton('2|2');
			scores.x = 60;
			scores.y = 420;
			scores.touchable = false;
			this.addChild(scores);
			
			
		}
		
		private function addTiles():void
		{
			var filterShadow:BlurFilter = BlurFilter.createDropShadow(1,0.78, 0x0, 0.5, 1, 0.5);
			
			for (var i:uint = 0; i <= 7; ++i)
			{
				for (var j:uint = 0; j <= 7; ++j)
				{
					var tile:Tile = new Tile();
					tile.x = stoneSize*i ; 
					tile.y = stoneSize*j;
					tile.name = 't_'+ i.toString() + '_' + j.toString();
					tile.touchable = false;
					tile.filter = filterShadow;
					tiles.addChild(tile);
				}
			}
		}
		
		public function switchView(view:String):void
		{
			switch(view){
				case ScreenState.GAME_SHOW_BUTTONS:
					board.visible = false;
					//tiles.visible = false; 
					tiles.visible = false;
					buttonWhite.visible = true;
					buttonBlack.visible = true;
					scores.visible = false;
					break;
				
				case ScreenState.GAME_INIT_GAME:
					board.visible = true;					
					//tiles.visible = false; 
					tiles.visible = true;
					buttonWhite.visible = false;
					buttonBlack.visible = false;
					scores.visible = true;
					scores.text = "2/2";
					break;
			}
			
		}
		
		public function drawTiles (map:Array, move:Array):void
		{	
			for (var i:uint = 0; i <= 7; ++i)
			{
				for (var j:uint = 0; j <= 7; ++j)
				{
					switch(map[i][j]){
						case "X":
							//drawStone(0x000000, i, j, stoneSize/2 - 4);
							//tiles2.getTile(i, j).setBW("B"); //setBlack
							tiles.getTile(i, j).stateContext.setBlack(delay(i, j, move));
							break;
						
						case "O":
							tiles.getTile(i, j).stateContext.setWhite(delay(i, j, move));
							break;
						
						case "h":
							tiles.getTile(i, j).stateContext.setHint(delay(i, j, move));
							break;
						
						case " ":
							tiles.getTile(i, j).stateContext.setEmpty(delay(i, j, move));
							break;						
					}
				}
			}
			//onComplete 
			Starling.juggler.delayCall(complete, maxDelay);
			maxDelay = 0;

		}
		
		private function delay(i:uint, j:uint, move:Array):Number {
			if (! move) return 0;
			
			var _delay:Number = Math.abs(i - move[0]) + Math.abs(j - move[1]);
			
			if (!(i == move[0] || j == move[1])){
				_delay = (_delay / 2) - .5;
			}
			
			_delay *= 0.2;
			
			if (_delay > maxDelay) maxDelay = _delay;
				
			return _delay;
		}
		
		private function complete():void{
			dispatchEvent(new Event(Event.COMPLETE)); //OK!
		}
		
	}
}