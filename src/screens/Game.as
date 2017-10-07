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
		private var botTile:String;
		//private var currentTile:String = null;
		private var _currentTile:String = null;
		private var otherTile:String;
		private var nextMove:Function;
		private var repeatMove:Function;
		
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
			botTile = other;
			
			map.init(); //new clear board array
			
			boardView.switchView(ScreenState.GAME_INIT_GAME); //show game board and scores
			boardView.addEventListener(Event.COMPLETE, onUpdateViewComplete);
			updateView();
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
		
		
		private function userMove(x:int = -1, y:int = -1):void
		{
			if (x < 0) {trace('userMove'); return;};
			
			if (map.isAvailableMove(map.board, this.playerTile, x, y)){ // is this tile available
				currentTile = playerTile;
				var nextMoveAvailable:Boolean = map.makeMove(map.board, this.playerTile, x, y); //make move and get computer can make next move
				//boardView.drawTiles(map.getBoardWithValidMoves(map.board, this.playerTile));
				updateView();
				
			}
		}
		
		//computer move 
		private function botMove():void{
			
			var bestMove:Array = map.getBestMove(map.board, this.playerTile, this.botTile);
			
			if (bestMove){ 
				currentTile = botTile;
				var nextMoveAvailable:Boolean = map.makeMove(map.board, this.botTile, bestMove[0], bestMove[1]);
				
				updateView();
				
			}
		}
		
		public function get currentTile():String { return _currentTile; }
		public function set currentTile(_val:String):void
		{
			_currentTile = _val;
			if (_val == "X"){otherTile = "O";} else{otherTile = "X";}
			
			if (_val == playerTile){
				nextMove = botMove;
				repeatMove = userMove;
			} else { //botTile
				nextMove = userMove;
				repeatMove = botMove;
			}
		}
		
		private function updateView():void{
			
			boardView.drawTiles(map.getBoardWithValidMoves(map.board, this.playerTile)); 
			boardView.scores.text = map.getScore(map.board, this.playerTile, this.botTile, true)[0];
			
		}
		
		private function onUpdateViewComplete(e:Event):void {
			trace("UPD view complete");
			
			if (currentTile){
				
				if ((map.getAllValidMoves(map.board, this.otherTile) as Array).length > 0){
					nextMove();	
					return;
				} else{ 
					if ((map.getAllValidMoves(map.board, this.currentTile) as Array).length > 0){ 
						repeatMove();
						return;
					} else{
						//_finish
						trace('finish');
						finish();
					}	
				}
				
			} else {
				
				currentTile = playerTile;
			}
			
		}
		
		private function finish():void{		
			if (map.getScore(map.board, this.playerTile, this.botTile, false)[0] >= map.getScore(map.board, this.playerTile, this.botTile, false)[1]){
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