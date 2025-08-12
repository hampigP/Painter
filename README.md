# Painter
[DEMO video](https://youtu.be/3sbsC67nQTc)

## 1、匯入圖檔

因為作業檔案中只給了四張圖片，所以其他畫圖工具的圖片是另外找的。

匯入方式：`Sketch > Add File > 選擇圖檔`，檔案會自動放到專案的`data`資料夾

## 2、顯示上方工具列

宣告圖片變數，分別為：`PImage line, clear, eraser, pencil, curve, circle, square, oval`

在 setup()中讀入圖片。EX： line = loadImage("line.png");

設定圖片位置，位置是自己抓的。EX：image(line, 10, 10, 20, 20); > image(圖片, x座標, y座標, 寬, 長);

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

## 3、演算法
### Line
`CGLine(float x1, float y1, float x2, float y2)`
