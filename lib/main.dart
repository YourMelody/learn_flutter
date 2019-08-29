import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Common/ZFBottomNavigationBar.dart';

/* *
 * 动画调试：最简单方法是减慢动画速度。可以将scheduler库中的timeDilation变量设置为大于1.0的数字
 *
 * 衡量应用启动时间：flutter run --trace-startup --profile
 *      跟踪输出保存为start_up_info.json，在Flutter工程目录的build目录下，记录了从程序启动到这些跟踪时间所用的时间（微秒）：
 *      1、进入Flutter引擎时
 *      2、展示应用第一帧时
 *      3、初始化Flutter框架时
 *      4、完成Flutter框架初始化时
 *
 * 将MaterialApp构造函数的debugShowMaterialGrid设置为true，会将基线网格覆盖在应用上，以方便验证对齐
 * */

// 应用入口
void main() {
	// 需要导入package:flutter/rendering.dart
	// 将以可视方式调试布局问题。它可以在任何时候启用，最简单的方法是在void main()内设置。启用该功能之后，：
	// boxes    -----  深青色边框
	// 空白      -----  填充灰色
	// padding  -----  浅蓝色
	// 对齐方式  -----  黄色箭头
	// 子widget  -----  深蓝色框
	debugPaintSizeEnabled = false;

	// 与debugPaintSizeEnabled类似，但对于有基线的对象，文字基线以绿色显示，表意（ideographic）基线以橙色显示
	debugPaintBaselinesEnabled = false;

	// 任何正在点击的对象都会以深青色突出显示（可用于hit测试）
	debugPaintPointersEnabled = false;

	// runApp作用是启动Flutter应用，接收一个Widget参数
	// MaterialApp：一般作为App顶层的主页入口，可配置主题，路由等
	runApp(MaterialApp(
		// 该功能应该始终在release模式下使用，启用后，会在屏幕上产生性能图谱，包含了GPU和CPU线程花费的时间（debug模式下测试性能意义不大）
		showPerformanceOverlay: false,

		// 是否显示屏幕右上角的debug标签
		debugShowCheckedModeBanner: false,

		// 在应用上覆盖基线网格，方便对齐验证
		debugShowMaterialGrid: false,

		home: ZFBottomNavigationBar(),

		// 设置主题
		theme: ThemeData(primaryColor: Color(0xFF5AA5FF)),

		// 静态路由配置，可以在路由注册的时候传递参数，也可以在手动调用pop的时候返回参数
//		routes: <String, WidgetBuilder> {
//
//		},
	));
}
