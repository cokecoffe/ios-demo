### MultipleDetailViews ###

===========================================================================
DESCRIPTION:

This sample shows how you can use UISplitViewController to manage multiple detail views.

The application uses a split view controller with a table view controller as the root view controller. When you make a selection in the table view, a new view controller is created and set as the split view controller's second view controller.

The root view controller defines a protocol (SubstitutableDetailViewController) that detail view controllers must adopt. The protocol specifies methods to hide and show the bar button item controlling the popover.


===========================================================================
BUILD REQUIREMENTS:

Mac OS X v10.6 or later, Xcode 3.2.2 or later, iPhone OS 3.2 or later

===========================================================================
RUNTIME REQUIREMENTS:

Mac OS X v10.6 or later, iPhone OS 3.2 or later

===========================================================================
PACKAGING LIST:

AppDelegate.{h,m}
The application delegate configures the root and first detail view controllers.

RootViewController.{h,m}
A table view controller that manages two rows. Selecting a row creates a new detail view controller that is added to the split view controller. The root view controller is the split view controller's delegate (set in MainWindow.xib).


FirstDetailViewController.{h,m}
SecondDetailViewController.{h,m}
Simple view controllers that adopt the SubstitutableDetailViewController protocol defined by RootViewController. They are responsible for adding and removing the popover button: FirstDetailViewController uses a toolbar; SecondDetailViewController uses a navigation bar.


===========================================================================
CHANGES FROM PREVIOUS VERSIONS:

Version 1.1
- Added localization support; viewDidUnload now releases IBOutlets.

Version 1.0
- First version.

===========================================================================
Copyright (C) 2010 Apple Inc. All rights reserved.
