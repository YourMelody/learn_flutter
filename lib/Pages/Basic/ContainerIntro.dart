import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum _ZFTextInputType {
	TypePaddingTop,
	TypePaddingLeft,
	TypePaddingBottom,
	TypePaddingRight,
	
	TypeMarginTop,
	TypeMarginLeft,
	TypeMarginBottom,
	TypeMarginRight,
	
	TypeCircularTL,
	TypeCircularTR,
	TypeCircularBL,
	TypeCircularBR,
	
	TypeEllipticalTLX,
	TypeEllipticalTLY,
	TypeEllipticalTRX,
	TypeEllipticalTRY,
	TypeEllipticalBLX,
	TypeEllipticalBLY,
	TypeEllipticalBRX,
	TypeEllipticalBRY
}

enum _ZFBorderType {
	BorderTypeWidth,
	BorderTypeRed,
	BorderTypeGreen,
	BorderTypeBlue,
	BorderTypeOpacity,
	BorderTypeShadowOffsetX,
	BorderTypeShadowOffsetY,
	BorderTypeShadowBlur,
	GradientTypeRadius,
	TransformTypeValue
}

class ContainerIntro extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _ContainerState();
	}
}

class _ContainerState extends State<ContainerIntro> {
	// alignment
	String alignmentValue = 'center';
	Alignment containerAlignment = Alignment.center;
	
	// padding & margin
	double paddingTop, paddingLeft, paddingRight, paddingBottom,
		   marginTop, marginLeft, marginRight, marginBottom;
	
	// decoration-radius
	double circularTL, circularTR, circularBL, circularBR,
		   ellipticalTLX, ellipticalTLY, ellipticalTRX, ellipticalTRY,
		   ellipticalBLX, ellipticalBLY, ellipticalBRX, ellipticalBRY;
	
	// decoration之borderRadius
	String radiusValue = 'circular';
	
	// decoration之border
	double borderWidth, borderRed, borderGreen, borderBlue, borderOpacity;
	
	// decoration之boxShadow
	double shadowOffsetX, shadowOffsetY, shadowBlur;
	
	// decoration之gradient
	List<Color> gradientColors = [Colors.red, Colors.orange];
	String gradientAliStr = 'center';
	Alignment gradientAlignment = Alignment.center;
	double gradientRadius = 0.98;
	
	// container的变换矩阵transform
	double rotationValue = 0;
	String transformStr = 'rotationX';
	Matrix4 matrix4 = Matrix4.rotationX(0);
	
	@override
	void initState() {
		super.initState();
		paddingTop = paddingLeft = paddingRight = paddingBottom =
		marginTop = marginLeft = marginRight = marginBottom = 15;
		
		circularTL = circularTR = circularBL = circularBR =
		ellipticalTLX = ellipticalTLY = ellipticalTRX = ellipticalTRY =
		ellipticalBLX = ellipticalBLY = ellipticalBRX = ellipticalBRY = 5;
		
		borderWidth = borderRed = borderGreen = borderBlue = 0.0;
		borderOpacity = 1.0;
		
		shadowOffsetX = shadowOffsetY = shadowBlur = 0;
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
            appBar: AppBar(
                title: Text('Container')
            ),
			body: Column(
				children: <Widget>[
					_containerHeader(),
					Expanded(
						child: ListView.builder(
							itemBuilder: (context, index) => _renderItem(index),
							itemCount: 8
						)
					)
				],
			),
			backgroundColor: Color(0xff5aa5ff),
        );
	}
	
	// Container
	Widget _containerHeader() {
		bool isCircular = this.radiusValue == 'circular';
		return Container(
			color: Colors.white,
			child: Center(
				child: Container(
					// 唯一标识符，用于查找更新
					key: Key('ZFContainerIntro'),
					// 控制child的对齐方式，如果Container或者Container父节点尺寸大于child的尺寸，这个属性设置会起作用
					alignment: this.containerAlignment,
					padding: EdgeInsets.fromLTRB(paddingLeft, paddingTop, paddingRight, paddingBottom),
					margin: EdgeInsets.fromLTRB(marginLeft, marginTop, marginRight, marginBottom),
					
					// 背景颜色，会被foregroundDecoration设置覆盖；不能与decoration同时存在，否则报错
					// color: Color(0xff5aa5ff),
					
					// 绘制在child后面的装饰，
					decoration: BoxDecoration(
						color: Color(0xff5aa5ff),
						
						// 圆角，注意elliptical的x, y同时不为0才有效果
						borderRadius: BorderRadius.only(
							topLeft: isCircular ? Radius.circular(this.circularTL) :
												  Radius.elliptical(this.ellipticalTLX, this.ellipticalTLY),
							topRight: isCircular ? Radius.circular(this.circularTR) :
												   Radius.elliptical(this.ellipticalTRX, this.ellipticalTRY),
							bottomLeft: isCircular ? Radius.circular(this.circularBL) :
													 Radius.elliptical(this.ellipticalBLX, this.ellipticalBLY),
							bottomRight: isCircular ? Radius.circular(this.circularBR) :
													  Radius.elliptical(this.ellipticalBRX, this.ellipticalBRY),
						),
						
						// 边框颜色、宽度、透明度
						border: Border.all(
							color: Color.fromRGBO(
								this.borderRed.toInt(),
								this.borderGreen.toInt(),
								this.borderBlue.toInt(),
								this.borderOpacity
							),
							width: this.borderWidth
						),
						
						// 阴影颜色、偏移量、模糊程度
						boxShadow: [
							BoxShadow(
								color: Colors.black,
								offset: Offset(this.shadowOffsetX, shadowOffsetY),
								blurRadius: this.shadowBlur
							)
						],
						
						// 设置背景径向渐变(会覆盖decoration中的color)
						gradient: RadialGradient(
							colors: this.gradientColors,
							center: this.gradientAlignment,
							radius: this.gradientRadius
						)
					),
					// 绘制在child前面的装饰
					foregroundDecoration: BoxDecoration(),
					// 设置为double.infinity可以强制在宽度上铺满。不设置，则根据child和父节点两者一起布局
					width: double.infinity,
					height: 120,
					// 添加到child上额外的约束条件
					constraints: BoxConstraints(
						
					),
					// 设置Container的变换矩阵
					transform: this.matrix4,
					child: Text('Hello, world!'),
				),
			),
		);
	}
	
	
	/* ========================================================================================================= */
	/* ========================================================================================================= */
	/* ==============================                                              ============================= */
	/* ****************************** 上面是Container介绍，下面是Container各种效果实现 ***************************** */
	/* ==============================                                              ============================= */
	/* ========================================================================================================= */
	/* ========================================================================================================= */
	
	
	_renderItem(int index) {
		if (index == 0) {           // 改变Container的alignment
			return Card(child: _changeAlignmentItem());
		} else if (index == 1) {    // 改变Container的padding
			return Card(child: _changePaddingOrMargin(true));
		} else if (index == 2) {    // 改变Container的margin
			return Card(child: _changePaddingOrMargin(false));
		} else if (index == 3) {    // decoration之borderRadius
			return Card(child: _changeDecorationRadius());
		} else if (index == 4) {    // decoration之border
			return Card(child: _getBorderWidthAndColor());
		} else if (index == 5) {    // 阴影效果
			return Card(child: _getBoxShadow());
		} else if (index == 6) {    // gradient
			return Card(child: _getGradient());
		} else if (index == 7) {
			return Card(child: _getTransformType());
		}
	}
	
	// 改变Container的alignment
	Widget _changeAlignmentItem() {
		List<String> alignmentList = [
			'topLeft', 'topCenter', 'topRight', 'centerLeft', 'center',
			'centerRight', 'bottomLeft', 'bottomCenter', 'bottomRight'
		];
		return ListTile(
			title: Text('设置alignment'),
			trailing: DropdownButton(
				items: alignmentList.map((String value) {
					return DropdownMenuItem(
						child: Text(value),
						value: value
					);
				}).toList(),
				onChanged: (newValue) {
					Alignment tempAlignment;
					switch (newValue) {
						case 'topLeft':
							tempAlignment = Alignment.topLeft;
							break;
						case 'topCenter':
							tempAlignment = Alignment.topCenter;
							break;
						case 'topRight':
							tempAlignment = Alignment.topRight;
							break;
						case 'centerLeft':
							tempAlignment = Alignment.centerLeft;
							break;
						case 'center':
							tempAlignment = Alignment.center;
							break;
						case 'centerRight':
							tempAlignment = Alignment.centerRight;
							break;
						case 'bottomLeft':
							tempAlignment = Alignment.bottomLeft;
							break;
						case 'bottomCenter':
							tempAlignment = Alignment.bottomCenter;
							break;
						case 'bottomRight':
							tempAlignment = Alignment.bottomRight;
							break;
					}
					setState(() {
						alignmentValue = newValue;
						containerAlignment = tempAlignment;
					});
				},
				value: this.alignmentValue
			)
		);
	}
	
	
	// 改变Container的padding和margin
	Widget _changePaddingOrMargin(bool isPadding) {
		String showText = isPadding ? '修改padding值 ' : '修改margin值 ';
		return Column(
			children: <Widget>[
				Text(showText),
				Row(
					children: <Widget>[
						Padding(padding: EdgeInsets.only(left: 5)),
						Text('top: '),
						Expanded(child: Container(
							padding: EdgeInsets.only(top: 10, bottom: 10),
							margin: EdgeInsets.only(right: 3),
							child: _getTextInput(_ZFTextInputType.TypePaddingTop)
						)),
						
						
						Text('left: '),
						Expanded(child: Container(
							margin: EdgeInsets.only(right: 3),
							child: _getTextInput(_ZFTextInputType.TypePaddingLeft)
						)),
						
						
						Text('bottom: '),
						Expanded(child: Container(
							margin: EdgeInsets.only(right: 3),
							child: _getTextInput(_ZFTextInputType.TypePaddingBottom)
						)),
						
						
						Text('right: '),
						Expanded(child: Container(
							margin: EdgeInsets.only(right: 5),
							child: _getTextInput(_ZFTextInputType.TypePaddingRight)
						))
					],
				)
			],
		);
	}
	
	
	// decoration之borderRadius
	Widget _changeDecorationRadius() {
		bool showRadius = this.radiusValue == 'circular';
		return Column(
			children: <Widget>[
				ListTile(
					title: Text('decoration之borderRadius'),
					trailing: DropdownButton(
						items: ['circular', 'elliptical'].map((String value) {
							return DropdownMenuItem(
								child: Text(value),
								value: value
							);
						}).toList(),
						onChanged: (newValue) {
							setState(() {
								radiusValue = newValue;
								circularTL = circularTR = circularBL = circularBR =
									ellipticalTLX = ellipticalTLY = ellipticalTRX = ellipticalTRY =
									ellipticalBLX = ellipticalBLY = ellipticalBRX = ellipticalBRY = 5;
							});
						},
						value: this.radiusValue
					)
				),
				
				Row(
					children: <Widget>[
						Padding(padding: EdgeInsets.only(left: 5)),
						Text(showRadius ? 'topLeft: ' : 'topLeft(x, y): '),
						Expanded(child: Container(
							padding: EdgeInsets.only(top: 10, bottom: 10),
							margin: EdgeInsets.only(right: 3),
							child: showRadius ?
							_getTextInput(_ZFTextInputType.TypeCircularTL) :
							_getTextInput(_ZFTextInputType.TypeEllipticalTLX)
						)),
						Expanded(child: Offstage(
							offstage: showRadius,
							child: Container(
								padding: EdgeInsets.only(top: 10, bottom: 10),
								margin: EdgeInsets.only(right: 10),
								child: _getTextInput(_ZFTextInputType.TypeEllipticalTLY)
							)
						)),
						
						
						Text(showRadius ? 'topRight: ' : 'topRight(x, y): '),
						Expanded(child: Container(
							padding: EdgeInsets.only(top: 10, bottom: 10),
							margin: EdgeInsets.only(right: 3),
							child: showRadius ?
							_getTextInput(_ZFTextInputType.TypeCircularTR) :
							_getTextInput(_ZFTextInputType.TypeEllipticalTRX)
						)),
						Expanded(child: Offstage(
							offstage: showRadius,
							child: Container(
								padding: EdgeInsets.only(top: 10, bottom: 10),
								margin: EdgeInsets.only(right: 5),
								child: _getTextInput(_ZFTextInputType.TypeEllipticalTRY)
							)
						))
					]
				),
				
				Row(
					children: <Widget>[
						Padding(padding: EdgeInsets.only(left: 5)),
						Text(showRadius ? 'botLeft: ' : 'botLeft(x, y): '),
						Expanded(child: Container(
							padding: EdgeInsets.only(top: 10, bottom: 10),
							margin: EdgeInsets.only(right: 3),
							child: showRadius ?
							_getTextInput(_ZFTextInputType.TypeCircularBL) :
							_getTextInput(_ZFTextInputType.TypeEllipticalBLX)
						)),
						Expanded(child: Offstage(
							offstage: showRadius,
							child: Container(
								padding: EdgeInsets.only(top: 10, bottom: 10),
								margin: EdgeInsets.only(right: 5),
								child: _getTextInput(_ZFTextInputType.TypeEllipticalBLY)
							)
						)),
						
						
						Text(showRadius ? 'botRight: ' : 'botRight(x, y): '),
						Expanded(child: Container(
							padding: EdgeInsets.only(top: 10, bottom: 10),
							margin: EdgeInsets.only(right: 3),
							child: showRadius ?
							_getTextInput(_ZFTextInputType.TypeCircularBR) :
							_getTextInput(_ZFTextInputType.TypeEllipticalBRX)
						)),
						Expanded(child: Offstage(
							offstage: showRadius,
							child: Container(
								padding: EdgeInsets.only(top: 10, bottom: 10),
								margin: EdgeInsets.only(right: 5),
								child: _getTextInput(_ZFTextInputType.TypeEllipticalBRY)
							)
						))
					],
				)
			],
		);
	}
	
	Widget _getTextInput(_ZFTextInputType type) {
		return CupertinoTextField(
			keyboardType: TextInputType.numberWithOptions(),
			onSubmitted: (text) {
				switch (type) {
					// padding
					case _ZFTextInputType.TypePaddingTop:
					    setState(() => paddingTop = double.parse(text));
					    break;
					case _ZFTextInputType.TypePaddingLeft:
					    setState(() => paddingLeft = double.parse(text));
					    break;
					case _ZFTextInputType.TypePaddingBottom:
					    setState(() => paddingBottom = double.parse(text));
					    break;
					case _ZFTextInputType.TypePaddingRight:
					    setState(() => paddingRight = double.parse(text));
					    break;
					    
					// margin
					case _ZFTextInputType.TypeMarginTop:
					    setState(() => marginTop = double.parse(text));
					    break;
					case _ZFTextInputType.TypeMarginLeft:
					    setState(() => marginLeft = double.parse(text));
					    break;
					case _ZFTextInputType.TypeMarginBottom:
					    setState(() => marginBottom = double.parse(text));
					    break;
					case _ZFTextInputType.TypeMarginRight:
					    setState(() => marginRight = double.parse(text));
					    break;
					    
					// circular
					case _ZFTextInputType.TypeCircularTL:
					    setState(() => circularTL = double.parse(text));
					    break;
					case _ZFTextInputType.TypeCircularTR:
					    setState(() => circularTR = double.parse(text));
					    break;
					case _ZFTextInputType.TypeCircularBL:
					    setState(() => circularBL = double.parse(text));
					    break;
					case _ZFTextInputType.TypeCircularBR:
					    setState(() => circularBR = double.parse(text));
					    break;
					    
					// elliptical
					case _ZFTextInputType.TypeEllipticalTLX:
					    setState(() => ellipticalTLX = double.parse(text));
					    break;
					case _ZFTextInputType.TypeEllipticalTLY:
					    setState(() => ellipticalTLY = double.parse(text));
					    break;
					case _ZFTextInputType.TypeEllipticalTRX:
					    setState(() => ellipticalTRX = double.parse(text));
					    break;
					case _ZFTextInputType.TypeEllipticalTRY:
					    setState(() => ellipticalTRY = double.parse(text));
					    break;
					case _ZFTextInputType.TypeEllipticalBLX:
					    setState(() => ellipticalBLX = double.parse(text));
					    break;
					case _ZFTextInputType.TypeEllipticalBLY:
					    setState(() => ellipticalBLY = double.parse(text));
					    break;
					case _ZFTextInputType.TypeEllipticalBRX:
					    setState(() => ellipticalBRX = double.parse(text));
					    break;
					case _ZFTextInputType.TypeEllipticalBRY:
					    setState(() => ellipticalBRY = double.parse(text));
					    break;
				}
			},
			textAlign: TextAlign.center,
			placeholder: '15'
		);
	}
	
	
	// decoration之border
	Widget _getBorderWidthAndColor() {
		return Column(children: <Widget>[
			Container(
				padding: EdgeInsets.only(top: 10, bottom: 10),
				child: Text('边框的颜色、宽度和透明度')
			),
			
			_getSliderItem('边框宽度(0-20)', this.borderWidth, 0, 20.0, _ZFBorderType.BorderTypeWidth),
			_getSliderItem('边框颜色R(0-255)', this.borderRed, 0, 255.0, _ZFBorderType.BorderTypeRed),
			_getSliderItem('边框颜色G(0-255)', this.borderGreen, 0, 255.0, _ZFBorderType.BorderTypeGreen),
			_getSliderItem('边框颜色B(0-255)', this.borderBlue, 0, 255.0, _ZFBorderType.BorderTypeBlue),
			_getSliderItem('边框透明度(0-1)', this.borderOpacity, 0, 1.0, _ZFBorderType.BorderTypeOpacity)
		]);
	}
	
	Widget _getSliderItem(String str, double stateValue, double minValue, double maxValue, _ZFBorderType type) {
		return ListTile(
			title: Text(str, style: TextStyle(fontSize: 13)),
			trailing: Container(
				width: 200,
				child: Slider(
					value: stateValue,
					onChanged: (newValue) {
						switch (type) {
							case _ZFBorderType.BorderTypeWidth:
								this.setState(() => this.borderWidth = newValue);
								break;
							case _ZFBorderType.BorderTypeRed:
								this.setState(() => this.borderRed = newValue);
								break;
							case _ZFBorderType.BorderTypeGreen:
								this.setState(() => this.borderGreen = newValue);
								break;
							case _ZFBorderType.BorderTypeBlue:
								this.setState(() => this.borderBlue = newValue);
								break;
							case _ZFBorderType.BorderTypeOpacity:
								this.setState(() => this.borderOpacity = newValue);
								break;
							case _ZFBorderType.BorderTypeShadowOffsetX:
								this.setState(() => this.shadowOffsetX = newValue);
								break;
							case _ZFBorderType.BorderTypeShadowOffsetY:
								this.setState(() => this.shadowOffsetY = newValue);
								break;
							case _ZFBorderType.BorderTypeShadowBlur:
								this.setState(() => this.shadowBlur = newValue);
								break;
							case _ZFBorderType.GradientTypeRadius:
								this.setState(() => this.gradientRadius = newValue);
								break;
							case _ZFBorderType.TransformTypeValue:
								Matrix4 tempM;
								if (this.transformStr == 'rotationX') {
									tempM = Matrix4.rotationX(newValue);
								} else if (this.transformStr == 'rotationY') {
									tempM = Matrix4.rotationY(newValue);
								} else if (this.transformStr == 'rotationZ') {
									tempM = Matrix4.rotationZ(newValue);
								}
								
								this.setState(() {
									this.rotationValue = newValue;
									matrix4 = tempM;
								});
								break;
						}
					},
					min: minValue,
					max: maxValue
				),
			),
		);
	}
	
	// decoration之boxShadow
	Widget _getBoxShadow() {
		return Column(
			children: <Widget>[
				Container(
					padding: EdgeInsets.only(top: 10, bottom: 10),
					child: Text('阴影效果(设置了黑色)')
				),
				
				_getSliderItem('阴影offsetX(-20~20)', this.shadowOffsetX, -20, 20, _ZFBorderType.BorderTypeShadowOffsetX),
				_getSliderItem('阴影offsetY(-20~20)', this.shadowOffsetY, -20, 20, _ZFBorderType.BorderTypeShadowOffsetY),
				_getSliderItem('阴影blurRadius(0-10)', this.shadowBlur, 0, 10, _ZFBorderType.BorderTypeShadowBlur)
			]
		);
	}
	
	// decoration之gradient-colors
	Widget _getGradient() {
		return Column(
			children: <Widget>[
				Container(
					padding: EdgeInsets.only(top: 10, bottom: 10),
					child: Text('decoration之gradient')
				),
				
				Container(
					padding: EdgeInsets.only(bottom: 2),
					child: Text('1、RadialGradient中的colors：')
				),
				
				_getCheckboxItem('1、红色', Colors.red),
				_getCheckboxItem('2、橙色', Colors.orange),
				_getCheckboxItem('3、黄色', Colors.yellow),
				_getCheckboxItem('4、绿色', Colors.green),
				_getCheckboxItem('5、青色', Colors.cyan),
				_getCheckboxItem('6、蓝色', Colors.blue),
				_getCheckboxItem('7、紫色', Colors.purple),
				
				Container(height: 1, color: Color(0xfff5f5f5)),
				_getGradientCenter(),
				
				Container(height: 1, color: Color(0xfff5f5f5)),
				_getSliderItem('3、RadialGradient之radius(0-1)', this.gradientRadius, 0, 1, _ZFBorderType.GradientTypeRadius)
			]
		);
	}
	
	Widget _getCheckboxItem(String str, Color boxColor) {
		return CheckboxListTile(
			value: this.gradientColors.contains(boxColor),
			onChanged: (newValue) {
				if (newValue) {
					this.gradientColors.add(boxColor);
				} else {
					this.gradientColors.remove(boxColor);
				}
				setState(() {});
			},
			title: Text(str),
			activeColor: boxColor,
			selected: true
		);
	}
	
	// decoration之gradient-center
	Widget _getGradientCenter() {
		List<String> alignmentList = [
			'topLeft', 'topCenter', 'topRight', 'centerLeft', 'center',
			'centerRight', 'bottomLeft', 'bottomCenter', 'bottomRight'
		];
		return ListTile(
			title: Text('2、RadialGradient中的center', style: TextStyle(fontSize: 13)),
			trailing: DropdownButton(
				items: alignmentList.map((String value) {
					return DropdownMenuItem(
						child: Text(value),
						value: value
					);
				}).toList(),
				onChanged: (newValue) {
					Alignment tempAlignment;
					switch (newValue) {
						case 'topLeft':
							tempAlignment = Alignment.topLeft;
							break;
						case 'topCenter':
							tempAlignment = Alignment.topCenter;
							break;
						case 'topRight':
							tempAlignment = Alignment.topRight;
							break;
						case 'centerLeft':
							tempAlignment = Alignment.centerLeft;
							break;
						case 'center':
							tempAlignment = Alignment.center;
							break;
						case 'centerRight':
							tempAlignment = Alignment.centerRight;
							break;
						case 'bottomLeft':
							tempAlignment = Alignment.bottomLeft;
							break;
						case 'bottomCenter':
							tempAlignment = Alignment.bottomCenter;
							break;
						case 'bottomRight':
							tempAlignment = Alignment.bottomRight;
							break;
					}
					setState(() {
						alignmentValue = newValue;
						gradientAlignment = tempAlignment;
					});
				},
				value: this.gradientAliStr
			)
		);
	}
	
	// transform
	Widget _getTransformType() {
		List itemList = ['rotationX', 'rotationY', 'rotationZ'];
		return Column(
			children: <Widget>[
				ListTile(
					title: Text('transform', style: TextStyle(fontSize: 13)),
					trailing: DropdownButton(
						items: itemList.map((value) {
							return DropdownMenuItem(
								child: Text(value),
								value: value,
							);
						}).toList(),
						onChanged: (newValue) {
							Matrix4 tempM;
							switch (newValue) {
								case 'rotationX':
									tempM = Matrix4.rotationX(this.rotationValue);
									break;
								case 'rotationY':
									tempM = Matrix4.rotationY(this.rotationValue);
									break;
								case 'rotationZ':
									tempM = Matrix4.rotationZ(this.rotationValue);
									break;
							}
							setState(() {
								matrix4 = tempM;
								transformStr = newValue;
							});
						},
						value: this.transformStr
					)
				),
				
				Container(height: 1, color: Color(0xfff5f5f5)),
				_getSliderItem('transformValue(0-2)', this.rotationValue, 0, 2, _ZFBorderType.TransformTypeValue)
			],
		);
	}
}
