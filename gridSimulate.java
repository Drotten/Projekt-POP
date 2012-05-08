
public class gridSimulate
{
	public static void main(String[] args)
	{
		World newWorld = new World();
		newWorld.makeGrid();
		run(newWorld);
	}

	private static void run(World world)
	{
		boolean run = true;
		world.createCowboy();
		while (run)
		{
			world.move();
			world.paint();
			try
			{
				Thread.sleep(500);
			} catch (InterruptedException e)
			{
				System.out.println("D:");
			}
		}
	}
}