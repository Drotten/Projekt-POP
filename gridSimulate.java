public class gridSimulate extends Thread
{
	public static void main(String[] args)
	{
		World world = new World();
		world.makeGrid();
		world.createCowboy();
		
		try {
			ErlController erlListener = new ErlController();
			Thread t = new Thread(erlListener.run());
			t.start();
			//erlListener.run();
		} catch(Exception e)
		{
			System.out.println(e);
		}
                System.out.println("WOO!");
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