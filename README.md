IKAutoCompleteTextField
=======================

* Autocomplete text field for iOS based on https://github.com/nicolaschengdev/WYPopoverController inspired by https://github.com/tetek/SuggestiveTextField
* Should work on iPhone as well as on iPad

```objective-c
//Initialize with frame or from xib, doesn't matter.
IKAutoCompleteTextField *textField = [IKAutoCompleteTextField alloc] initWithFrame:CGRectMake(0,0,100,30)];

//Remember to set suggestions.
NSArray *dataSourceArray = @[@"one",@"two",@"three"];
textField.dataSourceArray = dataSource;
```