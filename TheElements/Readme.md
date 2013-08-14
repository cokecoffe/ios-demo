#TheElements

###概述

使用表格展示元素周期表，以名字、序号等排序方式展示。
这个程序良好的运用了MVC模式。

###使用到的技术

1. 配置并响应tab bar的选择
2. 使用表格显示数据
3. 使用导航控制器
4. 子类化uiview
5. 子类化cell
6. tableview 委托、数据源 对象
7. 响应view中的点击
8. 调用浏览器
9. 旋转视图
10. 在界面中创建一个view的倒影

###编译需求
iOS 4.0 SDK
###运行环境
iPhone OS 3.2 or later
###源文件结构


**AtomicElement.h**    
**AtomicElement.m**
	
	AtomicElement类封装了单个元素的数据，包括 名字、序号、符号、状态信息，还有布局信息（水平、垂直位置）。它还能够返回展示物体状态的image，用来显示每一个元素。
	
**PeriodicTable.h**      
**PeriodicTable.m**
	
	PeriodicTable类封装了AtomicElement对象的集合。它提供了多种格式来访问元素：按照序号、名字、符号、原子状态、元素首字母等来排序的方式。数据从plist文件读取后是预排序、索引的。PeriodicTable是一个单例、供整个应用共享。

**ElementsTableViewController.h**
**ElementsTableViewController.m**

	ElementsTableViewController是一个控制器类，应用程序用它来以四种形式展示元素数据。程序启动后，创建了ElementsTableViewController类的四个对象，每个对象包括了对应的数据源对象。数据源对象也提供展示在导航上的那个按钮的图像。
	ElementsTableViewController负责创建并配置tableview对象。它遵循了UITableViewDelegate协议。并为tableview提供用来展示前面提到的AtomicElement的自定义cell对象。
	作为tableview的委托对象，它可以接收列表点击事件，并负责推入新的界面到导航控制器。

**AtomicElementTableViewCell.h**
**AtomicElementTableViewCell.h**
	
	用来展示元素的自定义表格项

**ElementsDataSourceProtocol.h**
**ElementsSortedByNameDataSource.h**
**ElementsSortedByNameDataSource.m**
**ElementsSortedByNumberDataSource.h**
**ElementsSortedByNumberDataSource.m**
**ElementsSortedBySymbolDataSource.h**
**ElementsSortedBySymbolDataSource.m**
**ElementsSortedByStateDataSource.h**
**ElementsSortedByStateDataSource.m**

	数据源类为ElementsTableViewController、导航按钮、导航控制器、tableview提供数据供显示。
	这些数据源类都遵循了UITableViewDataSource协议，并被tableview设置成了数据源对象。
	这些数据源类也遵循了ElementsDataSource协议，为导航、tab bar等提供显示的数据。

**AtomicElementViewController.h**
**AtomicElementViewController.m**
	
	当用户点击表格中的某个元素，AtomicElementViewController将被推入导航栈。这个控制器负责显示单独的某个元素。它还负责确定是否有另一个视图提供翻转显示。

**AtomicElementView.h**
**AtomicElementView.m**

	在AtomicElementViewController中显示。
	
**AtomicElementFlippedView.h**
**AtomicElementFlippedView.m**
	
	在AtomicElementViewController中的旋转视图。   
	     
	        
	              
***
***
Copyright (C) 2008-2010 Apple Inc. All rights reserved.
