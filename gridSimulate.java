public class gridSimulate
{
	public static void main(String[] args)
	{
		World world = new World();
		world.makeGrid();
		world.createCowboy();
		
		try {
			ErlController erlListener = new ErlController();
			erlListener.run();
		} catch(Exception e)
		{
			System.out.println(":/");
		}
		boolean run = true;
		while (run)
		{
			
			//world.move();
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