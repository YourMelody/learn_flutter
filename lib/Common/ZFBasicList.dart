import 'package:flutter/material.dart';
import '../Pages/Basic/DartBasicFunc.dart';

enum ShowBasic {
	ShowBasicOfDart,
	ShowBasicOfWidget
}

class ZFBasicList extends StatelessWidget {
	final ShowBasic basic;
	// 构造函数
	ZFBasicList({Key key, this.basic}) : super(key: key);
	@override
	Widget build(BuildContext context) {
		List<Map> dataSource = _getDataSource();
		return ListView.builder(
			itemBuilder: (context, index) {
				if (this.basic == ShowBasic.ShowBasicOfDart) {
					return _DartBasicListItem(dataSource[index], index);
				} else {
					return _WidgetBasicListItem(dataSource[index], index);
				}
			},
			itemCount: dataSource.length
		);
	}

	List<Map> _getDataSource() {
		if (this.basic == ShowBasic.ShowBasicOfDart) {
			return [{
				'title': '1、常量和变量',
				'subTitle': '常量和变量的基本用法'
			}, {
				'title': '2、基本数据类型',
				'subTitle': 'int/float/String/bool/Map/List等的基本使用'
			}, {
				'title': '3、异常处理',
				'subTitle': 'try/on/catch/throw/rethrow等的使用'
			}, {
				'title': '4、函数相关',
				'subTitle': '函数不同类型参数/构造函数/闭包'
			}, {
				'title': '5、异步处理',
				'subTitle': 'Future/then/async/await等的使用'
			}];
		} else {
			return [{
				'title': '1、StatelessWidget和StatefulWidget示例'
			}, {
				'title': '2、Container'
			}, {
				'title': ''
			}, {
				'title': ''
			}, {
				'title': ''
			}, {
				'title': ''
			}];
		}
	}
}

class _DartBasicListItem extends StatelessWidget {
	_DartBasicListItem(this.mapData, this.currentIndex);
	final Map mapData;
	final int currentIndex;
	@override
	Widget build(BuildContext context) {
		return Card(
			child: ListTile(
				title: Text(this.mapData['title'], style: TextStyle(fontSize: 20)),
				trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff5aa5ff)),
				subtitle: Text(this.mapData['subTitle']),
				onTap: () => _dartListItemTap()
			),
		);
	}

	void _dartListItemTap() {
		switch (this.currentIndex) {
			case 0: // 常量和变量
				dartBasicFunc(FuncType.FuncTypeVarAndConst);
				break;
			case 1: // 基本数据类型介绍
				dartBasicFunc(FuncType.FuncTypeMapAndList);
				break;
			case 2: // 异常处理
				dartBasicFunc(FuncType.FuncTypeException);
				break;
			case 3: // 函数相关
				dartBasicFunc(FuncType.FuncTypeFunction);
				break;
			case 4: // 异步
				dartBasicFunc(FuncType.FuncTypeAsync);
				break;
		}
	}
}

class _WidgetBasicListItem extends StatelessWidget {
	_WidgetBasicListItem(this.mapData, this.currentIndex);
	final Map mapData;
	final int currentIndex;

	@override
	Widget build(BuildContext context) {
		return Card(
			child: ListTile(
				leading: Icon(Icons.blur_on, color: Color(0xff5aa5ff)),
				title: Text(this.mapData['title']),
				trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff5aa5ff)),
				onTap: () => _widgetListItemTap(context),
			),
		);
	}

	_widgetListItemTap(BuildContext context) {
		switch (this.currentIndex) {
			case 0: // 有状态和无状态的widget
				// 已经配置过的静态路由，可以通过这种方式跳转
				Navigator.of(context).pushNamed('zf_state_widget');
				break;
			case 1:
				Navigator.of(context).pushNamed('zf_container_widget');
				break;
			case 2:
				break;
			case 3:
				break;
		}
	}
}