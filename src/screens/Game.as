package screens
{
	import engine.*;
	
	import events.NavigationEvent;
	
	import flash.geom.Point;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import utils.CustomButton;
	
	public class Game extends AScreen
	{
		private var button:CustomButton;
		private var boardView:BoardView;
		
		private var playerTile:String;
		private var otherTile:String;
		
		private var map:Map = new Map();
		
		public function Game(param:String = null)
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {		
			trace ("Game initialized");
			
			showButtons();
			
			addEventListener(Event.TRIGGERED, onEventTriggered);
		}
		
		private function showButtons():void{
			if (boardView == null){ //init view
				boardView = new BoardView();
				this.addChild(boardView);
				boardView.board.addEventListener(TouchEvent.TOUCH, onTouch);
				
			}
			boardView.switchView(ScreenState.GAME_SHOW_BUTTONS); // show buttons 
		}
		
		private function initGame(player:String = null, other:String = null):void{	
		
			playerTile = player;
			otherTile = other;
			
			map.init(); //new clear board array
			
			boardView.switchView(ScreenState.GAME_INIT_GAME); //show game board and scores
			boardView.drawTiles(map.getBoardWithValidMoves(playerTile)); //show tiles
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				var localPos:Point = touch.getLocation(this);
				trace("Touched object at position: " + localPos);
				
				var scaleFactor:uint = this.boardView.boardSize / 8; //get clicked tile coordinates
				var x:uint = (localPos.x - boardView.boardOffset) / scaleFactor;
				var y:uint = (localPos.y - boardView.boardOffset) / scaleFactor;
				
				trace(x, ' ', y);
				
				userMove(x, y);
			}
			
		}
		
		
		private function userMove(x:uint, y:uint):void
		{
			if (map.isAvailableMove(this.playerTile, x, y)){ // is this tile available
				var nextMoveAvailable:Boolean = map.makeMove(map.board, this.playerTile, x, y); //make move and get computer can make next move
				boardView.drawTiles(map.getBoardWithValidMoves(this.playerTile));
				
				if (nextMoveAvailable){
					this.botMove();	//computer move
				} else{ //as computed can't move - can user move again?
					if ((map.getAllValidMoves(this.playerTile) as Array).length > 0){ 
						trace('plr move again');
						boardView.drawTiles(map.getBoardWithValidMoves(this.playerTile)); 
						boardView.scores.text = map.getScore(map.board, this.playerTile, this.otherTile, true)[0];
						return;
					} else{
						//_finish
						trace('finish');
						finish();
					}	
				}
			}
		}
		
		//computer move 
		private function botMove():void{
			var availableMoves:Array = new Array();	
			availableMoves = map.getAllValidMoves(this.otherTile);
			
			if (availableMoves.length > 0){ 
				var move:uint = Math.floor( Math.random() * (availableMoves.length - 1) ); //primitive bot -  choose random move
				var nextMoveAvailable:Boolean = map.makeMove(map.board, this.otherTile, availableMoves[move].x, availableMoves[move].y);
				
				boardView.drawTiles(map.getBoardWithValidMoves(this.playerTile)); // get baord with hints and redraw view
				boardView.scores.text = map.getScore(map.board, this.playerTile, this.otherTile, true)[0]; //show scores
				
				if (nextMoveAvailable){
					//trace('you move');	
				} else{ //as user can't move - can computer move again?
					if ((map.getAllValidMoves(this.otherTile) as Array).length > 0){
						trace('bot move again');
						botMove();
						return;
					}else{
						//_finish
						trace('finish');
						finish();	
					}
				}
			}
		}
		
		private function finish():void{		
			if (map.getScore(map.board, this.playerTile, this.otherTile, false)[0] >= map.getScore(map.board, this.playerTile, this.otherTile, false)[1]){
				Map.winner = "You Won! Replay?";
			} else {
				Map.winner = "You Lose. Replay?";
			}
			
			showButtons();
			//this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, ScreenState.FINISH, true, s));
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, ScreenState.FINISH, true));
		}
		
		private function onEventTriggered(event:Event):void
		{
			trace("CLICK");
			
			var b:CustomButton = event.target as CustomButton;
			
			switch(b){
				case button:
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, ScreenState.FINISH, true));
					break;
				
				case boardView.buttonWhite:
					initGame("O", "X");
					break;
				
				case boardView.buttonBlack:	
					initGame("X", "O");
					break;
				
			}
		
		}
	}
}