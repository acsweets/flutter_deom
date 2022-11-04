import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

class Paper extends StatefulWidget {
  const Paper({Key ?key}) : super(key: key);

  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  ///CustomPaint 组件可以用来显示绘制出的东西。需要传入 CustomPainter 对象。
  ///自定义 PaperPainter 类继承 CustomPainter。 在其中的paint方法中可以拿到的画布Canvas。
  ///下面 paint 方法中使用 canvas 对象绘制了一个半径 10，圆心距左上角偏移 (100，100) 的黑圆点。

  ui.Image ?_image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  //读取 assets 中的图片
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }

  void _loadImage() async {
    _image = await loadImageFromAssets('assets/website.png');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(_image!),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final ui.Image image;
  final List<Sprite> allSprites = []; // Sprite 列表
  PaperPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    drawPaper(canvas);
  }

  ///=================================================================================================================画笔
//颜色color和是否抗锯齿isAntiAlias
  void drawIsAntiAliasColor(Canvas canvas) {
    Paint paint = Paint();
    canvas.drawCircle(
        Offset(200, 200),
        100,
        paint
          ..color = Colors.blue
          ..strokeWidth = 5);
    // canvas.skew(10, 1);//偏斜
    canvas.drawRect(
        Rect.fromLTWH(200, 200, 200, 100),
        paint
          ..isAntiAlias = false
          ..color = Colors.red);
    canvas.rotate(0.5);
  }

  // 画笔类型 style 和线宽 strokeWidth
  void drawIsStyleStrokeWidth(Canvas canvas) {
    Paint paint = Paint();
    canvas.drawCircle(
        Offset(200, 200),
        100,
        paint
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 50);
    canvas.drawCircle(
        Offset(180, 500),
        100,
        paint
          ..color = Colors.red
          ..strokeWidth = 50
          ..style = PaintingStyle.fill);
    // canvas.skew(10, 1);//偏斜

    canvas.rotate(0.5);
  }

  ///画笔的style 是stroke 才有线宽
  ///画笔的线帽paint..strokeCap = StrokeCap.butt
  void drawStrokeCap(Canvas canvas) {
    Paint paint = Paint();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    canvas.drawLine(Offset(50, 50), Offset(50, 150), paint..strokeCap = StrokeCap.butt);
    canvas.drawLine(Offset(50 + 50.0, 50), Offset(50 + 50.0, 150), paint..strokeCap = StrokeCap.round);
    canvas.drawLine(Offset(50 + 50.0 * 2, 50), Offset(50 + 50.0 * 2, 150), paint..strokeCap = StrokeCap.square);
  }

  ///画笔的线接  paint..strokeJoin = StrokeJoin.roundStrokeJoin.bevel - 斜角、StrokeJoin.miter - 锐角、 StrokeJoin.round - 圆角
  ///路径上的线与线的线接方式   一块画布上有定位  路劲跟画笔的样式
  void drawStrokeJoin(Canvas canvas) {
    Paint paint = Paint();
    Path path = Path();
/*    paint
      ..color = Colors.blue
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;
    */
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.red;
    paint.strokeWidth = 20;

    path.moveTo(100, 100);
    path.lineTo(100, 200);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.bevel);
  }

  ///画笔的斜接限制strokeMiterLimit，paint..strokeMiterLimit = 2第一行strokeMiterLimit = 2;第二行strokeMiterLimit = 3;数字越大，允许出现的尖角就可以越尖。
  void drawStrokeMiterLimit(Canvas canvas) {
    Paint paint = Paint();
    Path path = Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeJoin = StrokeJoin.miter
      ..strokeWidth = 20;
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50 + 150.0 * i, 50);
      path.lineTo(50 + 150.0 * i, 150);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint..strokeMiterLimit = 2);
    }
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50 + 150.0 * i, 50 + 150.0);
      path.lineTo(50 + 150.0 * i, 150 + 150.0);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint..strokeMiterLimit = 3);
    }
  }

  ///画笔的颜色属性 shader	着色器	Shader	null   |---- Gradient 渐变着色 linear 线性渐变 radial 径向渐变 sweep  扫描渐变   // |--- ImageShader 图片着色
  /// blendMode	混合模式	BlendMode	BlendMode.srcOver
  /// invertColors	是否反色	bool	false
  void drawInvertColors(Canvas canvas) {
    Paint paint = Paint();
    paint..color = Color(0xff009A44);
    canvas.drawCircle(Offset(100, 100), 50, paint..invertColors = false);
    canvas.drawCircle(Offset(100 + 120.0, 100), 50, paint..invertColors = true);
  }

  ///第四组滤镜属性:

  /// 属性	介绍	类型	默认值
  ///colorFilter	颜色滤镜	Shader	null   ColorFilter 对象可以使用变换矩阵或颜色叠合模式对绘制的对象进行滤色处理。
  //const ColorFilter.mode(Color color, BlendMode blendMode) #颜色模式
  // const ColorFilter.matrix(List<double> matrix) #颜色矩阵变换
  /// maskFilter	遮罩滤镜	MaskFilter	null  使图片进行模糊，可以指定模糊的类型, 只有一个 MaskFilter.blur 构造
  //const MaskFilter.blur(
  //     this._style, //类型
  //     this._sigma, //高斯模糊的偏差
  //   )
  ///imageFilter	图片滤镜	ImageFilter	null   可以通过 ImageFilter.blur 来让图片模糊，或通过 ImageFilter.matrix 进行变换
  //ImageFilter.blur(
  //   { double sigmaX = 0.0,
  //     double sigmaY = 0.0
  //   })
  //
  // ImageFilter.matrix(
  //   Float64List matrix4,
  //   { FilterQuality filterQuality = FilterQuality.low })

  ///filterQuality	滤镜质量	FilterQuality	FilterQuality.none
  //enum FilterQuality {
  //   none,
  //   low,
  //   medium,
  //   high,
  // }
  ///=================================================================================================================画布
  //[1]. 认识画布的变换和状态 (save/restore)。
  //[2]. 基础图形的绘制操作：绘制点、绘制线、绘制类矩形、绘制类圆。
  //[3]. 其他绘制：绘制颜色、绘制画笔、绘制阴影、绘制路径。
  //[4]. 画布裁剪：矩形裁剪、圆角矩形裁剪、路径裁剪。

  ///=========================================================================================变换 保存与恢复
  ///如果想要屏幕的 (0,0) 点永久在屏幕中心，可以将画布进行偏移这样之后的绘制就会以中心为原点。   canvas.translate(size.width / 2, size.height / 2);
  ///平移变换     canvas.translate(400/ 2, 700 / 2);  左右上下平行移动
  void drawTranslate(
    Canvas canvas,
  ) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    // 画布起点移到屏幕中心
    canvas.translate(400 / 2, 700 / 2);
    canvas.drawCircle(Offset(0, 0), 50, paint);
    canvas.drawLine(
        Offset(20, 20),
        Offset(50, 50),
        paint
          ..color = Colors.red
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
  }

  ///平移画布 画格子
  ///当使用 canvas.save() 时，当前画布的状态就会被保存，当执行 canvas.restore() 时，画布就会回到上次保存的状态。
  ///比如：在上面画横线前save画布这时画布的[顶点在屏幕中心]，画横线的过程中画布的顶点被[下移到了最后]。
  ///画完后restore画布，就能让画布顶点重新回到[屏幕中心]。
  void drawBottomRight(
    Canvas canvas,
  ) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    canvas.save();
    for (int i = 0; i < 700 / 2 / 20; i++) {
      canvas.drawLine(Offset(0, 0), Offset(300 / 2, 0), paint);

      ///两个参数是在 两点确定一条直线
      canvas.translate(0, 20); //画布下移20  //按屏幕高度来判定画几次  画一次 画布向下平移20
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < 300 / 2 / 20; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, 700 / 2), paint);
      canvas.translate(20, 0); //画布平移20
    }
    canvas.restore();
  }

  ///现在已经画完四分之一了，也许你正想傻傻再画出其他三个。有更巧妙的方法：   缩放变换
  // 如果是相同或者对称的对象，可以通过缩放进行对称变化。
  // 沿x轴镜像，就相当于canvas.scale(1, -1)；
  // 沿y轴镜像，就相当于canvas.scale(-1, 1)；
  // 沿原点镜像，就相当于canvas.scale(-1, -1)；

  void drawGrid(
    Canvas canvas,
  ) {
    drawBottomRight(
      canvas,
    );
    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    drawBottomRight(
      canvas,
    );
    canvas.restore();
    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    drawBottomRight(
      canvas,
    );
    canvas.restore();
    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    drawBottomRight(
      canvas,
    );
    canvas.restore();
  }

  ///旋转变换    canvas.rotate(step);//画一次旋转20度  step = 2 * pi / 12
  void drawDot(
    Canvas canvas,
  ) {
    final int count = 12;
    var paint = Paint();
    paint
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.translate(400 / 2, 600 / 2); //把画布放在中心
    canvas.save();
    for (int i = 0; i < count; i++) {
      var step = 2 * pi / count;
      canvas.drawLine(Offset(80, 0), Offset(100, 0), paint);
      canvas.rotate(step); //花一次旋转20度
    }
    canvas.restore();
  }

  ///=====================================================================基础图形绘制
  ///1. 点绘制 : drawPoints、drawRawPoints
  // 【1】 绘点: drawPoints
  // 绘制点需要传入点模式pointMode、一个 Offset 的列表和画笔。

  void drawPointsWithPoints(Canvas canvas) {
    final List<Offset> points = [
      Offset(-120, -20),
      Offset(-80, -80),
      Offset(-40, -40),
      Offset(0, -100),
      Offset(40, -140),
      Offset(80, -160),
      Offset(120, -100),
    ];
    var paint = Paint();
    paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    //   canvas.translate(400 / 2, 600 / 2);/// 画布起点移到屏幕中心
    /// PointMode.points : 点模式
    /// PointMode.lines : 线段模式 线段模式下：每两个点一对形成线段。如果点是奇数个，那么最后一个点将没有用。
    /// PointMode.polygon : 多边形连线模式多边形连线模式下：所有的点依次连接成图形。
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  ///【2】 绘点集: drawRawPoints
  ///通过 Float32List 得到点数据信息，点绘制模式同上。
  void drawRawPoints(Canvas canvas) {
    Float32List pos = Float32List.fromList([-120, -20, -80, -80, -40, -40, 0, -100, 40, -140, 80, -160, 120, -100]);
    var paint = Paint();
    paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    /// 画布起点移到屏幕中心
    canvas.drawRawPoints(PointMode.points, pos, paint);
  }

  ///. 绘制线 : drawLine指定两点绘制一条线，如下的两个蓝色坐标轴由六条线构成(包括两个尖角的线)。将上面的点绘制效果保留，会呈现如下的折线图:
  void drawAxis(
    Canvas canvas,
  ) {
    canvas.translate(400 / 2, 600 / 2);
    canvas.save();
    drawGrid(canvas);
    //drawPointsWithPoints(canvas);
    //drawRawPoints(canvas);
    var paint = Paint();
    paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(-300 / 2, 0), Offset(300 / 2, 0), paint);
    canvas.drawLine(Offset(0, -700 / 2), Offset(0, 700 / 2), paint);
    canvas.drawLine(Offset(0, 700 / 2), Offset(0 - 7.0, 700 / 2 - 10), paint);
    canvas.drawLine(Offset(0, 700 / 2), Offset(0 + 7.0, 700 / 2 - 10), paint);
    canvas.drawLine(Offset(300 / 2, 0), Offset(300 / 2 - 10, 7), paint);
    canvas.drawLine(Offset(300 / 2, 0), Offset(300 / 2 - 10, -7), paint);
    canvas.restore();
    //drawRect(canvas); //矩形
    // drawRRect(canvas);//圆角矩形
    //  drawDRRect(canvas); //两个圆角矩形差域
    //  drawFill(canvas);//类圆
    // canvas.drawColor(Colors.amber, BlendMode.lighten); //画布绘制颜色
    // drawPaint(canvas, paint);//绘制画笔drawPaint
    //  drawShadow(canvas);//3.绘制阴影drawShadow
    // drawPath(canvas, paint); //绘制路径
    //  drawClipRect(canvas, paint);//矩形裁剪
    // drawImage(canvas, paint);//绘制图片
    // drawImageRect(canvas, paint); //从图片中截取两个矩形
  }

  ///类矩形绘制:drawRect、drawRRect、drawDRRect
  /// 绘制矩形 drawRect
  void drawRect(Canvas canvas) {
    var paint = Paint();
    paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    //【1】.矩形中心构造  （确定中心的位置 以及宽高）
    Rect rectFromCenter = Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRect(rectFromCenter, paint);
    //【2】.矩形左上右下构造 （ 不懂就看源码  ）
    Rect rectFromLTRB = Rect.fromLTRB(-120, 100, 20, 20);
    canvas.drawRect(rectFromLTRB, paint..color = Colors.red);
    //【3】. 矩形左上宽高构造 （不懂就看源码 ）
    Rect rectFromLTWH = Rect.fromLTWH(80, -120, 40, 40);
    canvas.drawRect(rectFromLTWH, paint..color = Colors.orange);
    //【4】. 矩形内切圆构造  （从圆里切出一个矩形）
    Rect rectFromCircle = Rect.fromCircle(center: Offset(100, 100), radius: 20);
    canvas.drawRect(rectFromCircle, paint..color = Colors.green);
    //【5】. 矩形两点构造  （通过两个确定的点构造一个矩形）
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRect(rectFromPoints, paint..color = Colors.purple);
  }

  /// 绘制圆角矩形 drawRRect
  /// 圆角矩形可以通过一个矩形域 Rect 和一个圆角对象 Radius 构成
  /// 6 个构造方法因地制宜，圆角是一个四分之一椭圆，其中 x,y 表示两个半轴，控制椭圆的宽扁。四个边角的圆角样式可以独立设置。
  void drawRRect(Canvas canvas) {
    var paint = Paint();
    paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    //【1】.圆角矩形fromRectXY构造
    Rect rectFromCenter = Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRRect(RRect.fromRectXY(rectFromCenter, 40, 20), paint);

    //【2】.圆角矩形fromLTRBXY构造 x 是矩形横的弧度  y 是矩形竖的弧度
    canvas.drawRRect(RRect.fromLTRBXY(-120, -120, -80, -80, 10, 20), paint..color = Colors.red);

    //【3】. 圆角矩形fromLTRBR构造  通过R控制矩形整体弧度
    canvas.drawRRect(RRect.fromLTRBR(80, -120, 120, -80, Radius.circular(30)), paint..color = Colors.orange);

    //【4】. 圆角矩形fromLTRBAndCorners构造  通过Corners控制矩形角的弧度
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(80, 80, 120, 120,
            bottomRight: Radius.elliptical(10, 10), topLeft: Radius.elliptical(10, 10)),
        paint..color = Colors.green);

    //【5】. 矩形两点构造
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          rectFromPoints,
          bottomLeft: Radius.elliptical(10, 10),
          bottomRight: Radius.elliptical(10, 10),
        ),
        paint..color = Colors.purple);
  }

  ///【3】 绘制两个圆角矩形差域 drawDRRect    核心是找到两个圆角矩形的区域，前者减去后者。
  void drawDRRect(Canvas canvas) {
    var paint = Paint();
    paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    Rect outRect = Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160); //矩形中心构造  （确定中心的位置 以及宽高）
    Rect inRect = Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100);
    //  圆角矩形传入一个矩形以及什么样式的圆角 RRect.fromRectXY(outRect,60, 10),  x 是矩形横的弧度  y 是矩形竖的弧度
    ///传入两个圆角矩形算出差域
    canvas.drawDRRect(RRect.fromRectXY(outRect, 60, 10), RRect.fromRectXY(inRect, 20, 20), paint);

    Rect outRect2 = Rect.fromCenter(center: Offset(0, 0), width: 60, height: 60);
    Rect inRect2 = Rect.fromCenter(center: Offset(0, 0), width: 40, height: 40);

    ///传入两个圆角矩形算出差域
    canvas.drawDRRect(
        RRect.fromRectXY(outRect2, 15, 15), RRect.fromRectXY(inRect2, 10, 10), paint..color = Colors.green);
  }

  ///==========================绘制类圆 drawCircle,drawOval,drawArc

  ///类圆主要有圆、椭圆、圆弧，圆是一个中心点 Offset 和半径组成，椭圆的形状由一个矩形域确定。
  void drawFill(Canvas canvas) {
    var paint = Paint();
    paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    canvas.save();
    canvas.translate(-150, 0);
    canvas.drawCircle(Offset(0, 0), 50, paint);
    canvas.restore();

    var rect = Rect.fromCenter(center: Offset(0, 0), height: 85, width: 90);

    /// 传入一个矩形 绘制一个轴对齐的椭圆，用给定的 [Paint] 填充给定的轴对齐矩形。椭圆是填充还是描边（或两者）由[Paint.style]控制。
    canvas.drawOval(rect, paint);

    canvas.save();
    canvas.translate(150, 0);
    //drawArc(矩形区域,起始弧度,扫描弧度,是否连中心,画笔)
    //drawArc 的第四参，表示是否使用中心点，下左图为 false,表示两端不与中间连线。
    // 中间图为 true，表示两端与中间连线。
    ///绘制一个缩放以适合给定矩形内的弧。它从椭圆周围的 `startAngle（起始角）` 弧度开始到椭圆周围的 `startAngle` + `sweepAngle` 弧度，
    ///零弧度是椭圆右侧与与矩形中心相交的水平线的点并且正角围绕椭圆顺时针方向。如果 `useCenter` 为真，
    ///则圆弧向中心闭合，形成一个圆形扇区。否则，圆弧不闭合，形成一个圆段。此方法针对绘制圆弧进行了优化
    ///，应该比 [Path.arcTo] 更快。
    ///总结  利用矩形画圆弧， 从开始点-结束点。这个弧多大，弧是否闭合形成扇形
    canvas.drawArc(rect, 0, pi / 2 * 3, true, paint);
    canvas.restore();
  }

  ///其他绘制   绘制颜色 drawColor，左侧是原图，在此基础上绘制颜色，需要传入颜色和混合模式，
  /// 绘制画笔drawPaint，直接使用画笔填充画布。你可以为画笔设置滤镜或着色器、混色模式后，进行绘制一些特效。
  ///.绘制阴影drawShadow阴影是根据路径绘制的，drawShadow 有四个参数:路径 path 、颜色 color、影深 elevation 和 内部是否显示 transparentOccluder
  ///   绘线路径drawPath drawPath是一个极其重要的 API，为绘制提供了无限可能。主要用于将一个路径绘制出来

  ///绘制画笔drawPaint
  void drawPaint(Canvas canvas, Paint paint) {
    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];

    ///Paint有个属性叫shader，也就是着色器，用于：画 或 填充一个图形时增加特殊效果，如drawCircle时，添加颜色渐变效果。
    /// 优先级：colorFilter > shader > color,当共同存在时，优先级高的生效，优先级低的无效。
    ///Gradient，绘制颜色渐变的着色器。ImageShader，对图片做处理的着色器。直白来讲，shader就是设定一个纹理图案，然后贴到要画的内容上。
    ///中间颜色的渐变用到了Paint的方法shader,设置的属性为 dart:ui包下的Gradient,不要导错包了,应该import的时候加入 as ui,才可以如代码中设置的样式.import 'dart:ui' as ui;

    paint.shader = ui.Gradient.linear(Offset(0, 0), Offset(300, 0), colors, pos, TileMode.clamp);

    paint.blendMode = BlendMode.lighten;
    canvas.drawPaint(paint);
  }

  ///绘制阴影 drawShadow

  void drawShadow(Canvas canvas) {
    Path path = Path();
    path.lineTo(80, 80);
    path.lineTo(-80, 80);
    path.close();

    ///路径 path 、颜色 color、影深 elevation 和 内部是否显示 transparentOccluder
    canvas.drawShadow(path, Colors.red, 3, true);
    canvas.translate(150, 0);
    canvas.drawShadow(path, Colors.red, 3, false);
  }

  /// 绘线路径drawPath
  void drawPath(Canvas canvas, Paint paint) {
    Path path = Path();
    path.lineTo(60, 60);
    path.lineTo(-60, 60);
    path.lineTo(60, -60);
    path.lineTo(-60, -60);
    path.close();
    canvas.drawPath(path, paint);
    canvas.translate(140, 0);
    canvas.drawPath(
        path,
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  ///==========================画布的裁剪
  ///矩形裁剪:指定一个矩形，画布在之后的绘制中仅保留矩形内的内容 。 可通过save/restore存换状态。
  // 下面是在裁剪后进行渐变色的绘制，可见，只在矩形域内生效。另外有两个可选属性：
  // doAntiAlias: 是否抗锯齿 默认true  clipOp: ClipOp.intersect 裁内部(默认) ClipOp.difference 裁外部
  ///、圆角矩形裁剪:和矩形裁剪基本一致，只不过效果作用于:一个圆角矩形区域
  ///路径裁剪:和矩形裁剪基本一致，只不过效果作用于:一个指定路径的区域
  ///

  /// 矩形裁剪
  void drawClipRect(Canvas canvas, Paint paint) {
    var rect = Rect.fromCenter(center: Offset.zero, width: 360, height: 240);
    canvas.clipRect(rect, doAntiAlias: true, clipOp: ui.ClipOp.intersect); // 裁剪画布
    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    paint.shader = ui.Gradient.linear(rect.centerLeft, rect.centerRight, colors, pos, TileMode.clamp);
    paint.blendMode = BlendMode.lighten;
    canvas.drawPaint(paint);

    ///圆角矩形裁剪
    var rect1 = Rect.fromCenter(center: Offset.zero, width: 200, height: 100);
    canvas.clipRRect(RRect.fromRectAndRadius(rect1, Radius.circular(30)));

    canvas.drawColor(Colors.red, BlendMode.darken);

    ///路径裁剪
    Path path = Path();
    path.lineTo(80, 80);
    path.lineTo(-80, 80);
    path.close();
    canvas.clipPath(path);
    canvas.drawColor(Colors.red, BlendMode.darken);
  }

  ///画布绘制图片
//[1]. 了解如何获取 [ui.Image] 对象。
// [2]. 将一张图片使用 Canvas 绘制出来。
// [3]. 知道如何从图片中取出部分图片绘制到指定矩形域中。
// [4]. 了解 Canvas 绘制图集的操作。
// [5]. 如何在 Canvas 中绘制文字，并完善坐标系刻度。

  ///  通过 decodeImageFromList 方法可以将一个字节流转换为ui.Image 对象。将 assets 的文件读取为字节流可以使用 rootBundle.load 方法

  void drawImage(Canvas canvas, Paint paint) {
    if (image != null) {
//绘制图片原尺寸，一张图一个定位，一只笔
      canvas.drawImage(image, Offset(-image.width / 2, -image.height / 2), paint);
    } else {
      print('木有图片');
    }
  }

  /// 3. 图片域绘制:drawImageRect drawImageRect中主要是两个矩形域，src 和 dst。
  // src 表示从资源图片 image 上抠出一块矩形域，所以原点是图片的左上角。
  // dst 表示将抠出的图片填充到画布的哪个矩形域中，所以原点是画布原点。

  void drawImageRect(Canvas canvas, Paint paint) {
    if (image != null) {
      canvas.drawImageRect(
          image,
          Rect.fromCenter(center: Offset(image.width / 2, image.height / 2), width: 60, height: 60),
          Rect.fromLTRB(0, 0, 100, 100).translate(50, 0),
          paint);

      canvas.drawImageRect(
          image,
          Rect.fromCenter(center: Offset(image.width / 2, image.height / 2 - 60), width: 60, height: 60),
          Rect.fromLTRB(0, 0, 100, 100).translate(-150, -140),

          ///translate返回一个移动后的矩形
          paint);

      canvas.drawImageRect(
          image,
          Rect.fromCenter(center: Offset(image.width / 2 + 60, image.height / 2), width: 60, height: 60),
          Rect.fromLTRB(0, 0, 100, 100).translate(-150, 40),
          paint);
    }
  }

  ///图片 .9 域绘制:drawImageNine
  ///drawImageNine 中主要是两个矩形域，center 和 dst。
  // center 表示从资源图片image上一块可缩放的矩形域，所以原点是图片的左上角。
  // dst 表示将抠出的图片填充到画布的哪个矩形域中，所以原点是画布原点。
  // 这样很容易画出气泡的效果，即指定区域进行缩放，其余不动。

  void drawImageNine(Canvas canvas, Paint paint) {
    if (image != null) {
      canvas.drawImageNine(
          image,
          Rect.fromCenter(center: Offset(image.width / 2, image.height - 6.0), width: image.width - 20.0, height: 2.0),
          //对原图进行缩放，是原图可以缩放的矩形区域
          Rect.fromCenter(
              center: Offset(
                0,
                0,
              ),
              width: 100,
              height: 120),
          paint);

      canvas.drawImageNine(
          image,
          Rect.fromCenter(center: Offset(image.width / 2, image.height - 6.0), width: image.width - 20.0, height: 2.0),
          Rect.fromCenter(
                  center: Offset(
                    0,
                    0,
                  ),
                  width: 50,
                  height: 50)
              .translate(100, 0),
          paint);

      canvas.drawImageNine(
          image,
          Rect.fromCenter(center: Offset(image.width / 2, image.height - 6.0), width: image.width - 20.0, height: 2.0),
          Rect.fromCenter(
                  center: Offset(
                    0,
                    0,
                  ),
                  width: 60,
                  height: 250)
              .translate(-100, 0),
          paint);
    }
  }

  ///绘制图集 :drawAtlas
  /// 这个方法有七个参数，用起来比较复杂。主要作用是在画布上绘制一张图片上的很多部分，比如雪碧图 (Sprite) 将需要的图片放在一张图里。另外通过 drawAtlas 绘制的效率要更高。

  void drawAtlas( Canvas canvas,Paint paint){
    allSprites.add(Sprite(position: Rect.fromLTWH(0, 325, 157, 166), offset: Offset(0, 0), alpha: 255, rotation: 5));
    final List<RSTransform> transforms = allSprites
        .map((sprite) => RSTransform.fromComponents(
      rotation: sprite.rotation,//角度
      scale: 1.0,
      anchorX: 0,
      anchorY: 0,
      translateX: sprite.offset.dx,
      translateY: sprite.offset.dy,
    ))
        .toList();
    // 通过 allSprites 创建 Rect 集合
    final List<Rect> rects = allSprites.map((sprite) => sprite.position).toList();

    canvas.drawAtlas(image, transforms, rects, null, null, null, paint);
  }


  ///  绘制原始图集:drawRawAtlas 这个方法是drawAtlas的底层实现，其中变换列表、矩形域列表都换为Float32List，颜色数组换为Int32List，在使用方式上是一致的。
  void drawRawAtlas( Canvas canvas,Paint paint){
    allSprites.add(Sprite(
        position: Rect.fromLTWH(0, 325, 50, 66),
        offset: Offset(0, 0),
        anchor:Offset(0, 0),
        alpha: 255,
        rotation: 2));
    allSprites.add(Sprite(
        position: Rect.fromLTWH(0, 325, 50, 66),
        offset: Offset(0, 0),
        anchor:Offset(10, 10),
        alpha: 255,
        rotation: 5));
    allSprites.add(Sprite(
        position: Rect.fromLTWH(0, 325, 50, 66),
        offset: Offset(100, 130),
        anchor:Offset(0, 0),
        alpha: 205,
        rotation: 3));

    Float32List rectList = Float32List(allSprites.length * 4);
    Float32List transformList = Float32List(allSprites.length * 4);

    for (int i = 0; i < allSprites.length; i++) {
      final Sprite sprite = allSprites[i];
      rectList[i * 4 + 0] = sprite.position.left;
      rectList[i * 4 + 1] = sprite.position.top;
      rectList[i * 4 + 2] = sprite.position.right;
      rectList[i * 4 + 3] = sprite.position.bottom;
      final RSTransform transform = RSTransform.fromComponents(
        rotation: sprite.rotation,
        scale: 1.0,
        anchorX: sprite.anchor.dx,
        anchorY: sprite.anchor.dy,
        translateX: sprite.offset.dx,
        translateY: sprite.offset.dy,
      );
      transformList[i * 4 + 0] = transform.scos;
      transformList[i * 4 + 1] = transform.ssin;
      transformList[i * 4 + 2] = transform.tx;
      transformList[i * 4 + 3] = transform.ty;
    }
    canvas.drawRawAtlas(image, transformList, rectList, null, null, null, paint);


  }



  void drawPaper(
    Canvas canvas,
  ) {
    drawAxis(
      canvas,
    );
    var paint = Paint();
    paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    //  drawImageNine(canvas, paint); //可缩放的矩形域绘制
   // drawAtlas(canvas, paint);//在画布上绘制一张图片上的很多部分，
    drawRawAtlas(canvas, paint);//绘制原始图集:drawRawAtlas
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => image != oldDelegate.image;
}

class Sprite {
  Rect position; // 雪碧图 中 图片矩形区域
  Offset offset; // 移动偏倚
  Offset anchor; // 移动偏倚
  int alpha; // 透明度
  double rotation; // 旋转角度

  Sprite({this.offset=Offset.zero,this.anchor=Offset.zero, this.alpha=255, this.rotation=0,required this.position});
}