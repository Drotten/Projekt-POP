

import javax.swing.ImageIcon;

public class Cowboy {
    int x;
    int y;
    ImageIcon image;

    public Cowboy(int x, int y, ImageIcon image) {
		this.x = x;
		this.y = y;
		this.image = image;
    }

    public void setX(int x)
    {
    	this.x = x;
    }

    public void setY(int y)
    {
    	this.y = y;
    }

    public int getX()
    {
    	return x;
    }

    public int getY()
    {
    	return y;
    }

    public ImageIcon getImage()
    {
    	return image;
    }

    public String toString()
    {
    	return x + ", " + y;
    }
}