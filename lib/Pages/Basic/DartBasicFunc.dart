import 'dart:async';

enum FuncType {
	FuncTypeVarAndConst,    // 常量和变量
	FuncTypeMapAndList,     // 基本数据类型介绍
	FuncTypeException,      // 异常处理
	FuncTypeFunction,       // 函数相关
	FuncTypeAsync,          // 异步
	FuncTypeOther           // 其它
}

void dartBasicFunc(FuncType type) {
	switch (type) {
		case FuncType.FuncTypeVarAndConst:
			_varAndConst();
			break;
		case FuncType.FuncTypeMapAndList:
			_mapAndList();
			break;
		case FuncType.FuncTypeException:
			_aboutException();
			break;
		case FuncType.FuncTypeFunction:
			_aboutFunction();
			break;
		case FuncType.FuncTypeAsync:
			_aboutAsync();
			break;
		case FuncType.FuncTypeOther:
			_other();
			break;
	}
}



/* ******************************* 常量和变量 ******************************* */
void _varAndConst() {
	// 1、var
	// 可以不预先定义变量类型，会自动类型推导
	var name0 = 'zf';                       // name0 = zf, runtimeType = String
	// 报错，var修饰的变量name0，在第一次初始化之后，已经推导类型为String，之后不能再赋其它类型的值
	// name0 = 123;


	// 2、dynamic和Object
	// 如果对象不限于单一类型，或没有明确的类型，可用dynamic/Object
	Object name1 = 'zf';                    // name1 = zf, runtimeType = String
	name1 = ['a', 'b'];                     // name1 = [a, b], runtimeType = List<String>

	dynamic name2 = 'zf';                   // name2 = zf, runtimeType = String
	name2 = 123;                            // name2 = 123, runtimeType = int


	// 3、显示声明变量类型，所有类型的变量未初始化的默认值都是null
	String name3;                           // name3 = null, runtimeType = Null
	name3 = 'zf';                           // name3 = zf, runtimeType = String


	// 4、final和const
	// const修饰的变量值不能改变，需要在声明的同时进行初始化
	const name4 = 'zf';
	// name4 = 'abc'; // 报错
	// const 修饰的变量，类型可以省略，但建议加上类型
	const String name5 = 'zf';

	// final修饰的变量值也不能改变。
	// final不仅有const的编译时常量的特性，
	final name6 = 'zf';

	// final修饰的变量需要在运行时有确定的值；而const修饰的变量，在编译时就要有确定的值
	final time0 = DateTime.now();   // 正确，运行时有确定的值
	// const time1 = DateTime.now();   // 报错，编译时的值不确定

	// final的不可变性不可传递；const的不可变性可以传递
	final List tempList0 = [0, 1, 2, 3];
	tempList0[0] = 4;   // 正确，不可变性没有传递
	print('tempList0 = $tempList0');    // tempList0 = [4, 1, 2, 3]
	const List tempList1 = [0, 1, 2, 3];
	// tempList1[0] = 4; // 运行时报错，不可修改

	// 值相同的final在内存中会重复创建，const会引用相同的值
	final List tempList2 = [0, 1, 2, 3];
	const List tempList3 = [0, 1, 2, 3];
	// identical: Check whether two references are to the same object.
	print(identical(tempList0, tempList2)); // false
	print(identical(tempList1, tempList3)); // true
}



/* ******************************* 几种基本数据类型 ******************************* */
void _mapAndList() {
	// 1、Number和String
	// String转int（只能将纯数字且为整数的字符串转为int，否则会报错）
	int num0 = int.parse('1');                  // num0 = 1, runtimeType = int
	// num0 = int.parse('1.1'); // 报错，非纯数字
	// num0 = int.parse('1e100'); // 报错，不支持科学计数

	// String转double（将小数/整数/科学计数法的字符串转为double）
	double num1 = double.parse('1.23');         // num1 = 1.23, runtimeType = double
	num1 = double.parse('1.23e100');            // num1 = 1.23e+100, runtimeType = double

	// int转String
	String str0 = num0.toString();              // str0 = 1
	// double转String
	String str1 = num1.toString();              // str1 = 1.23e+100



	// 2、bool
	// Dart是强bool类型校验，只有两个对象是bool类型：true和false
	bool b0 = true;                             // b0 = true, runtimeType = bool
	b0 = false;                                 // b0 = false, runtimeType = bool



	// 3、List集合：元素可以是任何类型
	// 指定了元素类型只能是int，且长度为3，不能增删元素
	List<int> list0 = List(2);
	// list0.add(0); // 报错，list0长度固定为2，不能add
	// list0[0] = 'a'; // 报错，元素只能是int类型
	// list0[2] = 2; // 报错，数组越界
	list0[0] = 0;
	list0[1] = 1;                           // list0 = [0, 1], runtimeType = List<int>

	// 没有指定元素类型，则可以是任何类型；没有指定长度，可以增删
	List list1 = [0, 1];
	// 修改指定下标元素的值
	list1[0] = 'abc';
	list1[1] = ['aa', 'bb'];
	// 添加一个元素
	list1.add(0);
	// 添加多个元素
	list1.addAll([null, true]);
	list1.add(null);
	list1.add('abc');               // list1 = [abc, [aa, bb], 0, null, true, null, abc], runtimeType = List<dynamic>
	// 删除最后一个元素
	list1.removeLast();             // list1 = [abc, [aa, bb], 0, null, true, null]
	// 删除指定位置的元素
	list1.removeAt(0);              // list1 = [[aa, bb], 0, null, true, null]
	// 删除指定元素（从前往后找到第一个元素就删除，存在多个也只删除一个）
	list1.remove(null);             // list1 = [[aa, bb], 0, true, null]
	// 删除指定条件的元素（删除所有符合条件的元素）
	list1.removeWhere((item) => item.runtimeType == bool);  // list1 = [[aa, bb], 0, null]
	// 删除指定范围内的元素
	list1.removeRange(0, 2);        // list1 = [null]
	// 删除所有元素
	list1.clear();                  // list1 = []



	// 4、Map集合：key和value都可以是任何类型
	// 指定了map的key/value类型
	Map<String, int> map0 = Map();
	map0['name'] = 123;             // map0 = {name: 123}, runtimeType = _InternalLinkedHashMap<String, int>

	Map map1 = Map();
	map1['name'] = 'zf';
	map1[123] = 123;
	// 会覆盖之前的值
	map1[123] = 456;
	map1[null] = null;
	List tempKey = ['a'];
	map1[tempKey] = {'aKey': 'bValue'};// map1 = {name: zf, 123: 456, null: null, [a]: {aKey: bValue}}, runtimeType = _InternalLinkedHashMap<dynamic, dynamic>
	map1.containsKey(null);     // true
	map1.containsValue(456);    // true
	// 删初key为指定值的健值对
	map1.remove(null);          // map1 = {name: zf, 123: 456, [a]: {aKey: bValue}}
	// 注意这两种的区别
	map1.remove(['a']);         // {name: zf, 123: 456, [a]: {aKey: bValue}}
	map1.remove(tempKey);       // map1 = {name: zf, 123: 456}
	// 按条件删除
	map1.removeWhere((key, value) {
		return key == 'name' || value == 456;
	});                         // {}
}



/* ******************************* 异常处理 ******************************* */
void _aboutException() {
	try {
		_exceptionTest();
	} catch (e, r) { // 匹配所有类型的异常：e是异常对象，r时异常的堆栈信息
		print('1、$e');  // 1、FormatException: this is exception
	} finally {
		print('finally --- 1');
	}
}

void _exceptionTest() {
	try {
		// throw '抛出异常';

		// 抛出指定类型的异常
		throw FormatException('this is exception');
	} on OutOfMemoryError { // 可以捕获指定类型的异常
		print('out of memory');
	} on FormatException catch (e) {
		print('2、$e');      // 2、FormatException: this is exception
		// 重新抛出异常（会在_aboutException中重新catch到异常）
		rethrow;
	} catch (e) {
		print('catch exception');
	} finally { // 一定会执行，如果try/catch中有return/rethrow，会在return/rethrow之前执行
		print('finally --- 2');
	}
}



/* ******************************* 函数相关 ******************************* */
void _aboutFunction() {
	// 可选命名参数
	_funPramTest1(123);                         // a = 123, name = null, age = 10
	_funPramTest1(123, name: 'zf');             // a = 123, name = zf, age = 10
	_funPramTest1(123, age: 20);                // a = 123, name = null, age = 20
	_funPramTest1(123, name: 'zf', age: 20);    // a = 123, name = zf, age = 20


	// 可选位置参数
	_funPramTest2(123);                         // a = 123, name = zf, age = null
	_funPramTest2(123, 'zf');                   // a = 123, name = zf, age = null
	_funPramTest2(123, 'zf', 20);               // a = 123, name = zf, age = 20
	// _funPramTest2(123, 20); // 报错，按照位置匹配参数，20类型不能匹配String name


	// 构造函数
	Point p1 = Point(10, 20);
	// p1 = Instance of 'Point', p1.x = 10, p1.y = 20, runtimeType = Point
	print('p1 = $p1, p1.x = ${p1.x}, p1.y = ${p1.y}, runtimeType = ${p1.runtimeType}');

	Point p2 = Point.fromJson({'x': 30, 'y': 40});
	// p2 = Instance of 'Point', p2.x = 30, p2.y = 40, runtimeType = Point
	print('p2 = $p2, p2.x = ${p2.x}, p2.y = ${p2.y}, runtimeType = ${p2.runtimeType}');


	// 自执行方法
	((int m) {
		print('m = $m');
	})(10);


	// 闭包：函数内部嵌套函数，内部函数会访问外部的变量或参数，变量或参数不会被系统回收
	Function tempFunc = _func();
	tempFunc();     // 闭包内：a = 11
	tempFunc();     // 闭包内：a = 12
	tempFunc();     // 闭包内：a = 13
}

// 可选命名参数
void _funPramTest1(int a, {String name, int age = 10}) {
	print('a = $a, name = $name, age = $age');
}

// 可选位置参数
void _funPramTest2(int a, [String name = 'zf', int age]) {
	print('a = $a, name = $name, age = $age');
}

// 构造函数
class Point {
	int x, y;
//	Point(int a, int b) {
//		this.x = a;
//		this.y = b;
//	}
	// 等价写法
	Point(this.x, this.y);


	// 命名构造函数
//	Point.fromJson(Map data) {
//		this.x = data['x'];
//		this.y = data['y'];
//	}
	// 等价写法
	Point.fromJson(Map data) : this.x = data['x'], this.y = data['y'];
}

// 闭包
Function _func() {
	var a = 10;
	return () {
		a++;
		print('闭包内：a = $a');
	};
}



/* ******************************* 异步相关 ******************************* */
void _aboutAsync() {
	// Dart中的Main isolate只有一个Event Looper，但存在两个Queue：Event Queue和Microtask Queue
	// Event Looper挑选Task执行的顺序为：
	//  1、优先执行Microtask Queue中的Event，直到全部执行完
	//  2、Microtask Queue为空时，再执行Event Queue中的Event
	//
	// 当Event Looper正在处理Microtask Queue中的Event时，Event Queue中的Event就停止处理。
	// 此时应用不能绘制图形，不能处理任何点击，不能处理文件IO等

	// Future 和 Event Queue
	_eventQueue();

	// scheduleMicrotask 和 Microtask Queue
	_microTaskQueue();
}

// 1、通过Future，可以将任务添加到Event Queue的队尾
void _eventQueue() {
	// 打印顺序：start -> end -> 111 -> 222 -> valueA = aaa -> valueB = bbb -> complete -> 333 -> delayed
	print('start');
	Future(() {
		print('111');
	});

	Future(() {
		print('222');
		return 'aaa';
	}).then((valueA) {
		print('valueA = $valueA');  // valueA = aaa
		return 'bbb';
	}).then((valueB) {
		print('valueB = $valueB');  // valueB = bbb
	}).whenComplete(() {
		print('complete');
	});

	Future.delayed(Duration(seconds: 1), () {
		print('delayed');
	});

	Future(() {
		print('333');
	});

	print('end');
}

// 2、通过scheduleMicrotask，将任务加入到Microtask Queue队尾
void _microTaskQueue() {
	// 打印顺序：000 -> 555 -> bbb -> 111 -> 222 -> 444 -> 333 -> 666 -> 777 -> 999 -> aaa -> 888
	scheduleMicrotask(() => print('000'));

	Future(() => print('111'))
		.then((_) {
		print('222');
		scheduleMicrotask(() => print('333'));
	}).then((_) => print('444'));

	scheduleMicrotask(() => print('555'));

	Future(() => print('666'))
		.then((_) {
		print('777');
		Future(() => print('888'));
	}).then((_) => print('999'));

	Future(() => print('aaa'));

	scheduleMicrotask(() => print('bbb'));
}

void _asyncAndAwait() async {

}



/* ******************************* 其它 ******************************* */
void _other() {

}