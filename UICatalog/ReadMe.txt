UICatalog
=========

This sample is a catalog exhibiting many views and controls in the UIKit framework, along with their various properties and styles.
If you need code to create specific UI controls or views, refer to this sample and it should give you a good head start in building your user interface.
In most cases you can simply copy and paste the code snippets you need. 
When images or custom views are used, accessibility code has been added. Using the iPhone Accessibility API enhances the user experience of VoiceOver users.


Build Requirements
iOS 5.0 SDK or later


Runtime Requirements
iOS 3.2 or later


Using the Sample
Build and run the sample using iOS 5.0 SDK.
To run in the simulator, set the Active SDK to Simulator. To run on a device, set the Active SDK to the appropriate Device setting.

In most areas of this sample, as you see various UI elements, you will see a corresponding explanation as to where you can find the code. 
So for example the Buttons page - the gray button will have "ButtonsViewController.m - createGrayButton".
This means refer to the ButtonsViewController.m source file and search for the createGrayButton Objective-C method.

Buttons - This UIViewController or page contains various kinds of UIButton controls complete with background images.

Controls - This page contains other miscellaneous UIControl classes helpful in building your user interface including switch, slider page, and progress indicator.

TextFields - This page hosts different kinds of UITextField controls.  It also demonstrates how to handle the keyboard, particularly where text fields are placed.

SearchBar - This pages exhibits the UISearchBar control.

TextView - This page exhibits the use of UITextView.

Pickers - This page shows the varying picker style view including UIPickerView and UIDatePicker.  UIDatePicker variants include date, time, date & time, as well as a counter.  A custom picker is also included in this page.

Images - Shows how you can create a UIImageView containing a group of images used for animations or slide show.

Web - Shows how to properly use a UIWebView and target websites using NSURL class.

Segment - This page adds several types of UISegmentedControl views.

Toolbar - This page shows how to use UIToolbar and adds several kinds of UIBarButtonItems.

Alerts - This page shows how to use UIActionSheet and UIAlertView to display varying kinds of alerts that require user actions.  This includes simple alerts, OK/Cancel alerts, and alerts with custom titled buttons.

Transitions - This page shows how to implement view "flipping" and "curl" animations between two different views using a category of UIView called UIViewAnimation.

Localization - You will notice this sample in various places shows you how to localize your string content by using the NSLocalizedString() macro.  Each language has a "Localizeable.strings" file and this macro refers to this file when loading the strings.


Packaging List
main.m - Main source file for this sample.
AppDelegate.h/.m - The application's delegate to setup its window and content.
Contants.h - Contains various screen placement constants used across all the UIViewControllers.

MainViewController.h/.m - The front UIViewController containing a UITableView to navigate to all its pages.
ButtonsViewController.h/.m -UIViewController that hosts all the varying UIButtons.
ControlsViewController.h/.m - UIViewController that hosts all the varying UIControls.
TextFieldViewController.h/.m - UIViewController that contains UITextFields and how to use them.
SearchBarController.h/.m - UIViewController that contains a UISearchBar.
TextViewController.h/.m - UIViewController that shows how to use UITextView.
PickerViewController.h/.m - UIViewController that shows all the different kinds of picker controls.
ImagesViewController.h/.m - UIViewController that contains a UIImageView.
WebViewController.h/.m - UIViewController that shows how to use UIWebView.
AlertsViewController.h/.m - UIViewController that hosts all the varying kinds of alerts and action sheets.
SegmentViewController.h/.m - UIViewController that hosts all the varying UISegmentedControls.
ToolbarViewController.h/.m - UIViewController that hosts a UIToolbar and its UIBarButtonItems.
TransitionViewController.h/.m - UIViewController that shows how to flip between two different views.

Changes from Previous Versions
1.0 - First release
1.1 - Updated the user interface layout to show proper use or proper context in using the UIKit controls and views.
1.2 - Changes due to API updates in the Beta 3 SDK: reusable UITableView cells.
1.3 - Updated for Beta 4, changed to use Interface Builder xib files, removed un-needed QuartzCore framework, added Toolbar view for UIToolbar and UIBarButtonItems, added additional UIButtonTypes, added UISearchBar.
1.4 - Updated for Beta 5, renamed some classes.
1.5 - Beta 6 Release, updated to use xib file for MainViewController, fixed bad blur effect on UIView classes by properly rounding of coordinates, introduced "UIViewAnimationTransitionCurlUp/UIViewAnimationTransitionCurlDown" UIView transitions, adopted UITextField's "leftView" property.
1.6 - Minor UI modifications, changed bundle identifier.
1.7 - Improved custom UIPicker, Updated for and tested with iPhone OS 2.0. First public release.
2.0 - Upgraded for 3.0 SDK due to deprecated APIs, more use of UITableViewController.
2.5 - Minor bug fixes, all view controllers created from separate nibs, more use of properties, further code optimizations, added viewDidUnload methods.
2.6 - Used the iPhone Accessibility API to improve the accessibility of UICatalog and demonstrate how accessibility should be employed.
2.7 - Removed deprecation use of UIKeyboard info keys, upgraded project to build with the iOS 4 SDK.
2.8 - Deployment target set to iPhone OS 3.2.
2.9 - Upgraded to support 4.2 SDK, Picker page now supports landscape orientation.
2.10 - Upgraded to support 5.0 SDK, UIStepper control added, tinting/background image support added where possible, and secure text entry for UIAlertView.

Copyright (C) 2008-2011 Apple Inc. All rights reserved.
