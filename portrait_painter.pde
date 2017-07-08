import java.lang.*;
import java.util.concurrent.*;


private SobelEdgeDetection sobel;
private PImage originalImage;
private int scale = 1;
private List<Stroke> strokes = new CopyOnWriteArrayList <Stroke>();
public final int stroke = 4; // Line Stroke

public void setup(){
  size(1000, 600);
  colorMode(HSB, 360, 100,100, 100); 
  originalImage = loadImage("face.jpg");
  strokeWeight(stroke);
  sobel = new SobelEdgeDetection(); 
}

public void draw(){
   
   if(!strokes.isEmpty()){
     Stroke stroke = strokes.get(0);
     //println("HSB Draw: " + stroke.getHSB().getHue() + " - " + stroke.getHSB().getSaturation() + " - " +  stroke.getHSB().getBrightness());
     stroke(stroke.getHSB().getHue(), stroke.getHSB().getSaturation(), stroke.getHSB().getBrightness());
     //println("stroke.getLines().size(): " + stroke.getLines().size()); 
     for(Line line : stroke.getLines()){
       //println("Line: " + line.getX0() + " - " +  line.getX1() + " - " +  line.getY0() + " - " + line.getY1());
       line(line.getX0(), line.getX1(), line.getY0(), line.getY1());
     }
     strokes.remove(stroke);
   }
  
}
 
void mousePressed(){
  if(mouseButton == LEFT){
    image(originalImage,0,0,int(originalImage.width/scale),int(originalImage.height/scale));
    ImageArrays imageInRange = sobel.calculatePixelRanges(originalImage);
    PImage imageInRangeImage = sobel.createImageFromArray(imageInRange, "output.jpg", true);
    image(imageInRangeImage, originalImage.width/scale , 0,int(originalImage.width/scale), int(originalImage.height/scale));
    sobel.calculateGradients(originalImage, imageInRange, strokes);
    
  }
}
 