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
## 4、工具切換

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


## 5、演算法
### Line
`CGLine(float x1, float y1, float x2, float y2)`

從`(x1, y1)` 到 `(x2, y2)` 以均勻步進畫出一條線，用像素點近似。

找出x與y兩方向的位移：`dx = x2 - x1`, `dy = y2 - y1`

取較大位移的絕對值當作步數：`steps = int(max(abs(dx), abs(dy)))`

每一步要前進多少：`xInc = dx / steps, yInc = dy / steps`

從 `(x,y) = (x1, y1)` 開始，重複 `steps` 次： `x+=xInc; y+=yInc`，每一步畫一個像素

### Circle
`CGCircle(int xc, int yc, int r)`

以整數運算和`八向對稱`畫出圓的邊界。

以圓心 `(xc, yc)`、半徑 `r`，從最上方開始：`(x = 0, y = r)`

維護判斷參數 `d = 1 - r`

每回合 `x++`， 若 `d < 0`：只移動 x，否則 `y--` (往內收)

每得到一組`(x,y)`，用對稱一次畫8個點：
```
(±x, ±y), (±y, ±x) 之後再加上圓心偏移(+xc, +yc)
```

### Square
`CGRect(float x1, float y1, float x2, float y2)`

用拖曳的對角點拉出正方形。

使用者拖出兩點 `(x1, y1)`, `(x2, y2)`

邊長取 `size = min(abs(dx), abs(dy))`，確保四邊相等

根據拖曳方向(左/右、上/下)決定另一角：`xRight = x1 + sign(dx)*size`, `yBottom = y1 + sign(dy)*size`

用 `CGLine` 依序畫四個邊

### Oval
`CGOval(int xc, int yc, int a, int b)`

以中心與兩軸半徑畫出橢圓的邊界

中心`(xc, yc)`、水平半徑 `a` 、垂直半徑 `b`

參數式：
```
x = int(xc + a * cos(theta));
y = int(yc + b * sin(theta));
```
以滑鼠拖曳兩點決定： `cx = (x1 + x2)/2`, `cy = (y1 + y2)/2`, `a = |x2 - x1|/2`, `b = |y2 - y1|/2`

### Curve
CGB

## 清除畫布
點選 `clear` 圖示範圍 > 呼叫清除畫布的函式
```
void clearCanvas(){
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
}
```

