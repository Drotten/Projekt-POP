import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import java.awt.*;
import java.awt.GridLayout;
import java.util.Map;
import javax.swing.ImageIcon;

public class World {
    private int gridX = 15;
    private int gridY = 15;
    
    public void setGridX(int x) {
	gridX = x;
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
	JFrame frame = new JFrame();
	frame.setLayout(new GridLayout(gridX, gridY));
	frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	frame.pack();
	frame.setSize(800, 640);
	frame.setVisible(true);

	JPanel[][] grid;
	grid = new JPanel[gridX][gridY];
	for (int x=0; x<gridX; x++) {
	    for (int y=0; y<gridY; y++) {
		grid[x][y] = new JPanel();
		frame.add(grid[x][y]);
	    }
	}
	grid[5][10].add(new JLabel(createImageIcon("cb.jpg")));	
	grid[2][5].add(new JLabel(createImageIcon("cb.jpg")));	
	grid[8][1].add(new JLabel(createImageIcon("cb.jpg")));	
	frame.repaint();
    }

    

    public static void main(String[] args) {
	World world = new World();
	world.makeGrid();
    }
}