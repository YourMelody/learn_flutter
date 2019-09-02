import 'package:flutter/material.dart';

/*
* 可以简单认为StatefulWidget和StatelessWidget有两点不同
* 1、StatefulWidget可以拥有状态，这些状态在生命周期中可变，而StatelessWidget是不可变的。
* 2、StatefulWidget至少由两个类组成：StatefulWidget类和State类。StatefulWidget类本身是
*   不可变的，但State类中持有的状态在widget生命周期中可变。
* */

class StatelessAndStateful extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('StatelessAndStateful'),
			),
			body: Column(
				children: <Widget>[
					// StatelessWidget
					Expanded(child: _ZFStatelessWidget()),

					// 分割线
					Container(
						color: Color(0xffe5e5e5),
						height: 1,
					),

					// StatefulWidget
					Expanded(child: _ZFStatefulWidget())
				],
			),
		);
	}
}

// 无状态的Widget
class _ZFStatelessWidget extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Center(
			child: Text('这是StatelessWidget')
		);
	}
}

// 有状态的Widget
class _ZFStatefulWidget extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _ZFState();
	}
}

class _ZFState extends State<_ZFStatefulWidget> {
	int clickCount;

	@override
	void initState() {
		super.initState();
		clickCount = 0;
	}

	@override
	void didChangeDependencies() {
		super.didChangeDependencies();
		print('didChangeDependencies');
	}

	@override
	void dispose() {
		super.dispose();
		print('dispose');
	}
	
	@override
	Widget build(BuildContext context) {
		return Center(
			child: FlatButton(
				onPressed: () {
					// 调用setState方法来改变状态值
					setState(() {
						clickCount++;
					});
				}, 
				child: Text('StatefulWidget可戳---$clickCount')),
		);
	}
}