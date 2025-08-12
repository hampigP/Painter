# Painter
[DEMO video](https://youtu.be/3sbsC67nQTc)

## 1、匯入圖檔

因為作業檔案中只給了四張圖片，所以其他畫圖工具的圖片是另外找的。

匯入方式：`Sketch > Add File > 選擇圖檔`，檔案會自動放到專案的`data`資料夾

## 2、顯示上方工具列

宣告圖片變數，分別為：`PImage line, clear, eraser, pencil, curve, circle, square, oval`

在 setup()中讀入圖片。
```
line = loadImage("line.png");
clear = loadImage("clear.png");
eraser = loadImage("eraser.png");
pencil = loadImage("pencil.png");
curve = loadImage("curve.png");
circle = loadImage("circle.png");
square = loadImage("square.png");
oval = loadImage("oval.png");
```
設定圖片位置，位置是自己抓的。image(圖片, x座標, y座標, 寬, 長);
```
image(line, 10, 10, 20, 20);
image(pencil, 155, 10, 20, 20);
image(clear, 770, 10, 20, 20);
image(eraser, 180, 10, 20, 20);
image(curve, 130, 10, 20, 20);
image(circle, 40, 10, 20, 20);
image(square, 70, 10, 20, 20);
image(oval, 100, 10, 20, 20);
```
## 3、做可以記住圖案的畫布(PGraphics)

如果只在主畫面畫，`draw()` 每幀重畫會把舊東西蓋掉，所以另外做一塊畫布儲存先前的畫作。

設定如下：
```
void setup(){
...
canvas = createGraphics(width, height);
canvas.beginDraw();
canvas.background(255);
canvas.endDraw();
}
```

在 `draw()`每幀把它貼回來：
```
image(canvas, 0, 0)
```
## 工具切換

`mousePressed()`：點選工具列 > 設定 `currentTool`

EX：
```
void mousePressed(){
  if(mouseY <= 40){
    if(mouseX >= 10 && mouseX <30){
      currentTool = "line";
    }else if(){
      ...
  }
  return;
}
```

`mouseY <= 40` 代表滑鼠在畫面上方40px內點擊

`mouseX >= 10 && mouseX <30` 是工具所在範圍
## 3、演算法
### Line
`CGLine(float x1, float y1, float x2, float y2)`

## 清除畫布
點選 `clear` 圖示範圍 > 呼叫清除畫布的函式
```
void clearCanvas(){
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
}
```

