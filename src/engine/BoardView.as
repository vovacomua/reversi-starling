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
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;
	
	import utils.CustomButton;
	
	public class BoardView extends Sprite
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
		private var tiles2:Tiles;
		//private var tile:Tile;
		
		private var pieces:uint = 8;
		public var boardOffset:uint = 50;
		public var boardSize:uint = 320;
		private var stoneSize:int = boardSize / pieces;
		
		
		public function BoardView()
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
			
			tiles2 = new Tiles();
			tiles2.x = tiles2.y = boardOffset;
			//tiles.filter = filterShadow;
			this.addChild(tiles2);
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
					tiles2.addChild(tile);
				}
			}
		}
		
		public function switchView(view:String):void
		{
			switch(view){
				case ScreenState.GAME_SHOW_BUTTONS:
					board.visible = false;
					//tiles.visible = false; 
					tiles2.visible = false;
					buttonWhite.visible = true;
					buttonBlack.visible = true;
					scores.visible = false;
					break;
				
				case ScreenState.GAME_INIT_GAME:
					board.visible = true;					
					//tiles.visible = false; 
					tiles2.visible = true;
					buttonWhite.visible = false;
					buttonBlack.visible = false;
					scores.visible = true;
					scores.text = "2/2";
					break;
			}
			
		}
		
		public function drawTiles (map:Array):void
		{
			//tiles.graphics.clear();
			
			for (var i:uint = 0; i <= 7; ++i)
			{
				for (var j:uint = 0; j <= 7; ++j)
				{
					switch(map[i][j]){
						case "X":
							//drawStone(0x000000, i, j, stoneSize/2 - 4);
							tiles2.getTile(i, j).setBW("B");
							break;
						
						case "O":
							tiles2.getTile(i, j).setBW("W");
							break;
						
						case "h":
							tiles2.getTile(i, j).setHint();
							break;
						
						case " ":
							tiles2.getTile(i, j).setEmpty();
							break;						
					}
				}
			}
		}
		
		private function drawStone(color:uint, i:uint, j:uint, size:uint):void
		{
			/*tiles.graphics.beginFill(color, .9);
			tiles.graphics.drawCircle(stoneSize*i + stoneSize/2, stoneSize*j + stoneSize/2, size);
			tiles.graphics.endFill();*/
		}
	}
}