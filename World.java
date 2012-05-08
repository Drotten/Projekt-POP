import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.ImageIcon;
import java.awt.*;
import java.util.Map;
import java.util.Random;

public class World extends JFrame {
	private final int MAXCOWBOYS = 10;
	private int numberOfCowboys = 0;
    private Cowboy[] cowboys = new Cowboy[MAXCOWBOYS];

    private int gridX = 15;
    private int gridY = 15;
    private JFrame frame = new JFrame();
    private JPanel[][] grid = new JPanel[gridX][gridY];

    Random gen = new Random();

    public void setGridX(int x) 
    {
		gridX = x;
    }

    public void setGridY(int y) 
    {
		gridY = y;
    }
    protected static ImageIcon createImageIcon(String path) {
        java.net.URL imgURL = World.class.getResource(path);
        if (imgURL != null) {
            return new ImageIcon(imgURL);
        } else {
            System.err.println("Couldn't find file: " + path);
            return null;
        }
    }

    public void makeGrid() {
		//JFrame frame = new JFrame();
		frame.setLayout(new GridLayout(gridX, gridY));
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.pack();
		frame.setSize(800, 640);
		frame.setVisible(true);

		//JPanel[][] grid = new JPanel[gridX][gridY];
		for (int x=0; x<gridX; x++) {
	    	for (int y=0; y<gridY; y++) {
				grid[x][y] = new JPanel();
				frame.add(grid[x][y]);
	    	}
		}
		//grid[5][10].add(new JLabel(createImageIcon("cb.jpg")));	
    }

    public void paint()
    {
    	frame.repaint();
		for (int x=0; x<gridX; x++) {
	    	for (int y=0; y<gridY; y++) {
				grid[x][y].revalidate();
	    	}
		}
    }

    public void createCowboy() 
    {
    	if (numberOfCowboys == MAXCOWBOYS)
    	{
    		System.out.println("Too many cowboys already!!");
    		return;
    	}
    	int x = gen.nextInt(gridX);
    	int y = gen.nextInt(gridY);
    	ImageIcon image = createImageIcon("cb.jpg");

    	Cowboy cb = new Cowboy(x, y, image);
    	grid[x][y].add(new JLabel(image));

    	cowboys[numberOfCowboys] = cb;
    	numberOfCowboys++;
    }

    public void move()
    {
    	Cowboy cb = cowboys[0];
    	int x = cb.getX();
    	int y = cb.getY();
    	grid[x][y].removeAll();
    	//grid[x][y].add(new JPanel());

    	int newX = gen.nextInt(gridX);
    	int newY = gen.nextInt(gridY);
    	cb.setX(newX);
    	cb.setY(newY);
    	ImageIcon image = cb.getImage();
    	grid[newX][newY].add(new JLabel(image));

    	//System.out.println(cb);
    }
}