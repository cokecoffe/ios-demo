
STableViewController
====================================================================================================

STableViewController is a custom table view controller that supports **pull-to-refresh** and 
**load-more**. It was designed to have views and behaviors that can be easily customized.

See the demo project in `Demo/Demo.xcodeproj`.


Usage
----------------------------------------------------------------------------------------------------
To start, simply copy `STableViewController.h` and `STableViewController.m` into your project file.

STableViewController is not very useful on its own. It has to be subclassed to apply your custom
views and adjust any behavior. To get started quickly, you may include these files for reference:

 * `DemoTableViewController` - subclass of `STableViewController`. This declares what views
   to use for pull-to-refresh and load-more. Also includes samples on what methods to override
   for data loading and a sample customization to interact with the header and footer views 
   depending on the situation.
 * `DemoTableHeaderView` - the view used for pull-to-refresh
 * `DemoTableFooterView` - the view used for load-more
 
You may also opt to implement your own subclass for `STableViewController` and use your own
views for pull-to-refresh and load-more.

See `STableViewController.h` for more information on the methods available.