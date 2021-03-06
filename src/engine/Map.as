package engine
{
	public class Map
	{
		public var board:Array = new Array();	
		
		public function Map()
		{
			//init();
		}
		
		public function getBestMove(_board:Array, playerTile:String, botTile:String):Array{
			
			var availableMoves:Array = this.getAllValidMoves(this.copyBoard(_board), botTile);
			
			var bestMove:Array = new Array();
			var bestScore:uint = 0;
			
			for (var n:uint = 0; n < availableMoves.length; n++) { 
				
				var boardCopy:Array = this.copyBoard(_board);
				
				this.makeMove(boardCopy, botTile, availableMoves[n].x, availableMoves[n].y);
				var score:uint = this.getScore(boardCopy, playerTile, botTile, false)[1]; 
				
				if (score > bestScore){
					bestScore = score;
					bestMove = [availableMoves[n].x, availableMoves[n].y];
				}

			}
			
			return bestMove;
			
		}
		
		//get user's and computes's scores
		public function getScore(_board:Array, playerTile:String, botTile:String, forLabel:Boolean):Array{
			var scorePlayer:uint = 0;
			var scoreBot:uint = 0;
			var s:String;
			
			for (var i:uint = 0; i <= 7; ++i)
			{
				for (var j:uint = 0; j <= 7; ++j)
				{
					if (_board[i][j] == playerTile){
						scorePlayer += 1;
					}
					if (_board[i][j] == botTile){
						scoreBot += 1;
					}
				}
			}
			
			if (forLabel){
				return [(scorePlayer.toString() + "/" + scoreBot.toString())];
			} else {
				return [scorePlayer , scoreBot];
			}
			
		}
		
		//check if tile is available to make move
		public function isAvailableMove(_board:Array, tile:String, x:uint, y:uint):Boolean{
			if ((isValidMove(_board, tile, x, y) as Array).length > 0){
				//trace("available");
				return true;
			} else {
				//trace("not available");
				return false;
			}
			
		}
		
		//make move, flip captured stones and check if opponent's next move is available
		public function makeMove(_board:Array, tile:String, x:uint, y:uint):Boolean{
			//trace("makeMove", tile, x, y);
			var botTile:String;
			
			//flip all
			var tilesToFlip:Array = new Array();
			tilesToFlip = isValidMove(_board, tile, x, y);
			
			for (var n:uint = 0; n < tilesToFlip.length; n++) { 
				var tx:String = tilesToFlip[n].x;
				var ty:String = tilesToFlip[n].y;
				//trace("t", tx);
				_board[tx][ty] = tile;
			}
			
			//put stone to clicked tile
			_board[x][y] = tile;
			
			//check opponents next move
			if (tile == "X"){botTile = "O";} else{botTile = "X";}
			
			if ((getAllValidMoves(_board, botTile) as Array).length > 0){
				return true;
			} else {
				return false;
			}
			return true; //clean up - delete!
			
		}
		
		//get board array with hints
		public function getBoardWithValidMoves(_board:Array, playerTile:String):Array{
			var boardHints:Array = new Array();
			
			boardHints = copyBoard(_board);
			var allValidMoves:Array = new Array();
			//available moves
			allValidMoves = getAllValidMoves(_board, playerTile);
			
			for (var n:uint = 0; n < allValidMoves.length; n++) { 
				var tx:String = allValidMoves[n].x;
				var ty:String = allValidMoves[n].y;
				boardHints[tx][ty] = 'h';
			}	
			return boardHints;
		}
		
		//get array with all tiles available to make move
		public function getAllValidMoves(_board:Array, tile:String):Array{
			var list:Array = new Array();
			var turns:uint;
			for (var i:uint = 0; i <= 7; ++i)
			{
				for (var j:uint = 0; j <= 7; ++j)
				{
					if (isAvailableMove(_board, tile, i, j)) {
						list.push({x: i, y: j});
					}
				}
			}
			return list;
		}
		
		//get all stones to be flipped if moved to certain tile
		public function isValidMove(_board:Array, tile:String, xstart:int, ystart:int):Array{
			var tilesToFlip:Array = new Array();
			
			var botTile:String; 
			var traversalDir:Array = [[0,1], [1,1], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1]];
			var x:int; var y:int;
			
			if (!isOnBoard(xstart, ystart) || _board[xstart][ystart] != " "){
				return tilesToFlip;
			}
			
			_board[xstart][ystart] = tile;
			
			if (tile == "X"){botTile = "O";} else{botTile = "X";}
			////
			
			for each (var dir:Array in traversalDir){
				x = xstart; y = ystart;
				x += dir[0]; 
				y += dir[1]; //first step in the direction
				
				if (!isOnBoard(x, y)){
					continue;
				}
				
				if (isOnBoard(x, y) && _board[x][y] == botTile){ //first proven botTile
					x += dir[0]; 
					y += dir[1];
					
					if (!isOnBoard(x, y)){
						continue;
					}
					
					while (_board[x][y] == botTile){
						x += dir[0]; 
						y += dir[1];
						if (!isOnBoard(x, y)){ // break out WHILE loop, then continue in FOR loop
							break;
						}	
					}
					if (!isOnBoard(x, y)){ //recheck
						continue;
					}
					
					if (_board[x][y] == tile){ //there are pieces to flip over. Go reverse
						while (true){
							x -= dir[0]; 
							y -= dir[1];
							if (x == xstart && y == ystart){
								break;
							}
							tilesToFlip.push({x: x, y: y});
						}
					}
				}
			} // END for
			
			_board[xstart][ystart] = " ";
			return tilesToFlip;
		}
		
		private function isOnBoard(x:int, y:int):Boolean{
			return (x >= 0 && x <= 7 && y >= 0 && y <= 7);
		}
		
		private function getNewBoard():Array{
			var a:Array = new Array();
			a.push([" "," "," "," "," "," "," "," "]);
			a.push([" "," "," "," "," "," "," "," "]);
			a.push([" "," "," "," "," "," "," "," "]);
			a.push([" "," "," "," "," "," "," "," "]);
			a.push([" "," "," "," "," "," "," "," "]);
			a.push([" "," "," "," "," "," "," "," "]);
			a.push([" "," "," "," "," "," "," "," "]);
			a.push([" "," "," "," "," "," "," "," "]);
			
			return a;
		}
		
		private function copyBoard(_board:Array):Array {
			var a:Array = new Array();
			for (var n:uint = 0; n < _board.length; n++) {
				a[n] = _board[n].concat();
			}
			return a;
		}
		
		public function init():void{
			//clear board
			board = getNewBoard();
			
			//initial stones
			board[3][3] = "X";
			board[3][4] = "O";
			board[4][3] = "O";
			board[4][4] = "X";	
		}
	}
}