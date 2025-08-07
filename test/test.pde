PImage line, clear, eraser, pencil, curve, circle, square, oval;
String currentTool = "line";
float x1, y1, x2, y2;
boolean isDrawing = false;
PGraphics canvas; //記住已畫的圖案
float prevX, prevY;
ArrayList<PVector> curvePoints = new ArrayList<PVector>();

void setup()
{
  size(800,600);
  line = loadImage("line.png");
  clear = loadImage("clear.png");
  eraser = loadImage("eraser.png");
  pencil = loadImage("pencil.png");
  curve = loadImage("curve.png");
  circle = loadImage("circle.png");
  square = loadImage("square.png");
  oval = loadImage("oval.png");
  canvas = createGraphics(width, height);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
}

void draw()
{
  fill(255);
  noStroke();
  image(canvas, 0, 0);
  rect(0,0, width, 40);
  image(line, 10, 10, 20, 20);
  image(pencil, 155, 10, 20, 20);
  image(clear, 770, 10, 20, 20);
  image(eraser, 180, 10, 20, 20);
  image(curve, 130, 10, 20, 20);
  image(circle, 40, 10, 20, 20);
  image(square, 70, 10, 20, 20);
  image(oval, 100, 10, 20, 20);
  if (isDrawing && currentTool.equals("line")) {
    CGLine(x1, y1, mouseX, mouseY, canvas, color(0)); 
  }
  
  if(isDrawing && currentTool.equals("circle")){
    float cx = (x1 + mouseX) / 2.0;
    float cy = (y1 + mouseY) /2.0;
    float r = dist(x1, y1, mouseX, mouseY) / 2.0;
    CGCircle(int(cx), int(cy), int(r), canvas);
  }
  if (isDrawing && currentTool.equals("square")) {
    CGRect(x1, y1, mouseX, mouseY, canvas);  
  }
  if(isDrawing && currentTool.equals("oval")){
    int cx = int((x1 + mouseX) / 2.0);
    int cy = int((y1 + mouseY) / 2.0);
    int a = int(abs(mouseX - x1) / 2.0);
    int b = int(abs(mouseY - y1) / 2.0);
    CGOval(cx, cy, a, b, canvas);
  }
  
  if(curvePoints.size() == 4){
    canvas.beginDraw();
    CGBezier(curvePoints.get(0),curvePoints.get(1),curvePoints.get(2),curvePoints.get(3), canvas, color(0));
    canvas.endDraw();
    curvePoints.clear();
  }
}

// 畫直線
void CGLine(float x1, float y1, float x2, float y2, PGraphics pg, color c)
{
  float dx = x2 - x1;
  float dy = y2 - y1;
  int steps = int(max(abs(dx), abs(dy)));

  //if(abs(dx) > abs(dy))
  //{
  //  steps = int(abs(dx));
  //}else{
  //  steps = int(abs(dy));
  //}
  
  float xInc = dx / steps;
  float yInc = dy / steps;
  
  float x = x1;
  float y = y1;
  
  for (int i = 0; i<= steps; i++)
  {
    drawPointCanvas(round(x), round(y), c, pg);
    x += xInc;
    y += yInc;
  }
}

// 畫圓
void CGCircle(int xc, int yc, int r, PGraphics pg){
  int x = 0;
  int y = r;
  int d = 1 - r;
  
  drawCirclePoint(xc, yc, x, y, pg);
  
  while(x < y){
    x ++;
    if(d < 0){
      d += 2*x+1;
    }else{
      y--;
      d += 2 *(x-y)+1;
    }
    drawCirclePoint(xc, yc, x, y, pg);
  }
}

// 畫正方形
void CGRect(float x1, float y1, float x2, float y2, PGraphics pg){
  float dx = x2 - x1;
  float dy = y2 - y1;
  
  float size = min(abs(dx), abs(dy));
  
  float xDir = dx < 0 ? -1 : 1;
  float yDir = dy < 0 ? -1 : 1;
  float xRight = x1 + xDir * size;
  float yBottom = y1 + yDir * size;
  
  CGLine(x1, y1, xRight, y1, pg, color(0));
  CGLine(xRight, y1, xRight, yBottom, pg, color(0));
  CGLine(xRight, yBottom, x1, yBottom, pg, color(0));
  CGLine(x1, yBottom, x1, y1, pg, color(0));
}

// 畫橢圓
void CGOval(int xc, int yc, int a, int b, PGraphics pg){
  for (float theta = 0; theta < TWO_PI; theta += 0.01){
    int x = int(xc + a * cos(theta));
    int y = int(yc + b * sin(theta));
    drawPointCanvas(x, y, color(0), pg);
  }
}

// 畫曲線
void CGBezier(PVector p0, PVector p1, PVector p2, PVector p3, PGraphics pg, color c){
  for(float t = 0; t <= 1; t+= 0.001){
    float x = pow(1 - t, 3)* p0.x + 3* pow(1 - t, 2) *t * p1.x + 3* (1 - t) * t * t * p2.x + t * t * t * p3.x;
    float y = pow(1 - t, 3)* p0.y + 3* pow(1 - t, 2) *t * p1.y + 3* (1 - t) * t * t * p2.y + t * t * t * p3.y;
    
    drawPointCanvas(int(x), int(y), c, pg);
  }
}

void drawPointCanvas(int x, int y, color c, PGraphics pg)
{
  pg.stroke(c);
  pg.point(x, y);
}
void drawCirclePoint(int xc, int yc, int x, int y, PGraphics pg){
  drawPointCanvas(xc + x, yc + y, color(0), pg);
  drawPointCanvas(xc - x, yc + y, color(0), pg);
  drawPointCanvas(xc + x, yc - y, color(0), pg);
  drawPointCanvas(xc - x, yc - y, color(0), pg);
  drawPointCanvas(xc + y, yc + x, color(0), pg);
  drawPointCanvas(xc - y, yc + x, color(0), pg);
  drawPointCanvas(xc + y, yc - x, color(0), pg);
  drawPointCanvas(xc - y, yc - x, color(0), pg);
}

// 偵測滑鼠按甚麼
void mousePressed(){
  if (mouseY <= 40){
    if(mouseX >= 10 && mouseX < 30){
      currentTool = "line";
      println("切換工具：畫直線");
    } else if(mouseX >= 770 && mouseX <= 790){
        clearCanvas();
    }else if(mouseX >= 40 && mouseX <= 60){
      currentTool = "circle";
      println("切換工具：畫圓形");
    }else if(mouseX >= 70 && mouseX <= 90){
      currentTool = "square";
      println("切換工具：畫正方形");
    }else if(mouseX >= 100 && mouseX <= 110){
      currentTool = "oval";
      println("切換工具：畫橢圓形");
    }else if(mouseX >= 155 && mouseX <= 175){
      currentTool = "pencil";
      println("切換工具：畫筆");
    }else if(mouseX >= 180 && mouseX <= 200){
      currentTool = "eraser";
      println("切換工具：橡皮擦");
    }else if(mouseX >= 130 && mouseX <= 150){
      currentTool = "curve";
      println("切換工具：畫曲線");
      curvePoints.clear();
    }
    return;
  }
  if (currentTool.equals("line") || currentTool.equals("circle") || currentTool.equals("square") || currentTool.equals("oval") ){
    x1 = mouseX;
    y1 = mouseY;
    isDrawing = true;
  }
  if(currentTool.equals("pencil") || currentTool.equals("eraser") ){
    prevX = mouseX;
    prevY = mouseY;
  }
  
  if(currentTool.equals("curve") && mouseY > 40){
    curvePoints.add(new PVector(mouseX, mouseY));
  }
}

// 滑鼠放開後的座標
void mouseReleased(){
  if(isDrawing && currentTool.equals("line")){
    x2 = mouseX;
    y2 = mouseY;
    isDrawing = false;
   
    canvas.beginDraw();
    canvas.stroke(0);
    CGLine(x1, y1, x2, y2, canvas, color(0));
    canvas.endDraw();
  }
  
  if(isDrawing && currentTool.equals("circle")){
    x2 = mouseX;
    y2 = mouseY;
    isDrawing = false;
    
    float cx = (x1+x2) / 2.0;
    float cy = (y1+y2) / 2.0;
    float r = dist(x1, y1, x2, y2) / 2.0;
    canvas.beginDraw();
    CGCircle(int(cx), int(cy), int(r), canvas);
    canvas.endDraw();
  }
  
  if(isDrawing && currentTool.equals("square")){
    x2 = mouseX;
    y2 = mouseY;
    isDrawing = false;
    
    canvas.beginDraw();
    CGRect(x1, y1, x2, y2, canvas);
    canvas.endDraw();
  }
   if(isDrawing && currentTool.equals("oval")){
     x2 = mouseX;
     y2 = mouseY;
     isDrawing = false;
     
     int cx = int((x1 + x2) / 2.0);
     int cy = int((y1 + y2) / 2.0);
     int a = int(abs(x2 - x1) / 2.0);
     int b = int(abs(y2 - y1) / 2.0);
     
     canvas.beginDraw();
     CGOval(cx, cy, a, b, canvas);
     canvas.endDraw();
   }
  
}

// 滑鼠拖拉的紀錄
void mouseDragged(){
  if(currentTool.equals("pencil")){
    canvas.beginDraw();
    CGLine(prevX, prevY, mouseX, mouseY, canvas, color(0));
    canvas.endDraw();
    
    prevX = mouseX;
    prevY = mouseY;
  }
  
  if(currentTool.equals("eraser")){
    canvas.beginDraw();
    CGLine(prevX, prevY, mouseX, mouseY, canvas, color(255));
    canvas.endDraw();
    prevX = mouseX;
    prevY = mouseY;
  }
}



// 清空畫面
void clearCanvas(){
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
  println("畫部已清除");
}
