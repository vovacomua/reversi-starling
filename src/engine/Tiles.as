package engine
{
	import starling.display.Sprite;
	
	public class Tiles extends Sprite
	{
		public function Tiles()
		{
			super();
		}
		
		public function getTile (i:uint, j:uint):Tile {
			return Tile(this.getChildByName('t_'+ i.toString() + '_' + j.toString()));
		}
	}
}