import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'ZFBasicList.dart';

class ZFBottomNavigationBar extends StatefulWidget {
	@override
	_ZFBottomNavWidgetState createState() => _ZFBottomNavWidgetState();
}

class _ZFBottomNavWidgetState extends State<ZFBottomNavigationBar> with SingleTickerProviderStateMixin {
	List <String> _appBarTitles;
	int _currentIndex = 0;
	TabController _tabController;
	List _widgetList = List();

	@override
	void initState() {
		super.initState();
		_appBarTitles = ['Basic', 'Demo'];
		_tabController = TabController(length: 2, vsync: this);
		_tabController.addListener(() {
			// 监听tab切换，切换完成才执行
			print('index = ${_tabController.index}, previousIndex = ${_tabController.previousIndex}');
		});

		final TabBarView _myTabBarView = TabBarView(
			children: <Widget> [
				ZFBasicList(basic: ShowBasic.ShowBasicOfDart),
				Container(
					child: Center(
						child: Text('Widget_tabBarView'),
					),
					color: Colors.black45,
				)
			],
			controller: _tabController,
		);

		_widgetList
			..add(_myTabBarView)
			..add(
				Container(
					child: Center(
						child: Text('Demo'),
					),
					color: Colors.black38,
				)
			);
	}

	@override
	Widget build(BuildContext context) {
	    return Scaffold(
		    // 顶部导航栏
		    appBar: AppBar(
			    // 标题，默认居中显示，位置会受actions影响
			    title: Text(_appBarTitles[_currentIndex]),

			    // 顶部导航栏右侧按钮
			    actions: _currentIndex == 1 ? <Widget>[
				    IconButton(
					    // 默认24
					    iconSize: 24,
					    // 默认为 EdgeInsets.all(8)
					    padding: EdgeInsets.all(4),
					    icon: Icon(Icons.list),
					    onPressed: () {

					    }
				    )
			    ] : null,

			    // 顶部导航栏下面副导航栏
			    bottom: _currentIndex == 0 ? _getMaterialAppBarBottom() : null,

			    // 顶部导航栏颜色
			    backgroundColor: Colors.white,
			    // bottom的透明度，默认为1.0
			    bottomOpacity: 1.0,
			    // Android标题默认居左，设置该属性为true，可让标题居中
			    centerTitle: true
		    ),

		    // 底部导航
		    bottomNavigationBar: _getCupertinoTabBar(),

		    body: _widgetList[_currentIndex],
	    );
    }

    // Cupertino风格的CupertinoTabBar
    Widget _getCupertinoTabBar() {
		return CupertinoTabBar(
			items: [
				BottomNavigationBarItem(
					icon: Icon(Icons.home),
					title: Text(_appBarTitles[0])
				),
				BottomNavigationBarItem(
					icon: Icon(Icons.person_outline),
					title: Text(_appBarTitles[1])
				)
			],
			currentIndex: _currentIndex,
			onTap: (int index) {
				setState(() {
					_currentIndex = index;
				});
			},
			backgroundColor: Colors.white,
			// 图片大小，默认值30
			iconSize: 30,
			activeColor: Color(0xff5aa5ff),
			inactiveColor: Color(0xff999999)
		);
    }

    // Material风格的BottomNavigationBar
    Widget _getMaterialTabBar() {
		return BottomNavigationBar(
			items: [
				BottomNavigationBarItem(
					icon: Icon(Icons.home),
					title: Text(_appBarTitles[0])
				),
				BottomNavigationBarItem(
					icon: Icon(Icons.person_outline),
					title: Text(_appBarTitles[1])
				)
			],
			currentIndex: _currentIndex,
			onTap: (int index) {
				setState(() {
					_currentIndex = index;
				});
			},
			// 点击效果，fixed、shifting两种可选。默认为fixed。
			// shifting模式下，item选中状态默认显示图片和标题，未选中状态默认只显示图片，并且会改变item位置
			// 两种模式的icon/title显示与否，都会受showSelectedLabels/showUnselectedLabels影响
			type: BottomNavigationBarType.fixed,
			// BottomNavigationBar的z轴坐标(z-coordinate)，默认值为8
			elevation: 10,
			backgroundColor: Colors.white,
			// 图片大小，默认值为24（会影响bar的高度）
			iconSize: 28,

			// selectedItemColor和fixedColor不能同时存在，否则报错
			// fixedColor: Color(0xff5aa5ff),

			// 选中状态颜色
			selectedItemColor: Color(0xff5aa5ff),
			// 未选中状态颜色（包括icon颜色和title颜色）
			unselectedItemColor: Color(0xff999999),
			// 选中状态字体大小，默认14（会影响bar的高度）
			selectedFontSize: 11,
			// 未选中状态字体大小，默认12（不会影响bar的高度）
			unselectedFontSize: 11,
			// 是否显示选中状态item的title，默认为true
			showSelectedLabels: true,
			// 是否显示未选中状态item的title，fixed默认未true，shifting默认未false
			showUnselectedLabels: true
		);
    }

    // Material风格的appBar->bottom
    Widget _getMaterialAppBarBottom() {
		return TabBar(
			tabs: <Widget> [
				Tab(text: 'Dart'),
				Tab(text: 'Widget')
			],
			// tabs下面线的颜色
			indicatorColor: Color(0xff5aa5ff),
			// 线高度，默认为2
			indicatorWeight: 1,
			// 线的padding，默认为 EdgeInsets.zero
			indicatorPadding: EdgeInsets.all(0),
			// 自定义indicator(会使indicatorPadding、indicatorColor失效，会影响indicatorWeight的效果)
			indicator: UnderlineTabIndicator(
				borderSide: BorderSide(
					color: Color(0xff5aa5ff),
					width: 1
				)
			),
			// 线宽：label（和title同宽）/tab（和item同宽）
			indicatorSize: TabBarIndicatorSize.label,
			// 选中状态文字颜色
			labelColor: Color(0xff5aa5ff),
			// 文字padding值
			labelPadding: EdgeInsets.zero,
			// 选中状态文字样式
			labelStyle: TextStyle(fontSize: 14),
			// 未选中状态文字颜色
			unselectedLabelColor: Color(0xff999999),
			// 未选中状态文字样式
			unselectedLabelStyle: TextStyle(fontSize: 14),
			controller: _tabController
		);
    }
}