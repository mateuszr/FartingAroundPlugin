//
//  SavePanelWithURLPlugin.m
//  SavePanelWithURL
//
//  Created by Wojciech Rolecki on 25/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <objc/objc.h>
#import <objc/runtime.h>
#import "SavePanelWithURLPlugin.h"
#import "JRSwizzle.h"

@interface SavePanelWithURLPlugin (PrivateMethods)
- (void)swizzleMyNizzle;
@end

@implementation SavePanelWithURLPlugin

+ (SavePanelWithURLPlugin*) sharedInstance
{
  static SavePanelWithURLPlugin *plugin = nil;
  
  if (plugin == nil)
    plugin = [[SavePanelWithURLPlugin alloc] init];
  
  return plugin;
}

+ (void) load
{
  SavePanelWithURLPlugin *plugin = [SavePanelWithURLPlugin sharedInstance];
  NSLog(@"everyday I'm swizzlin");
  [[self class] swizzleMyNizzle];
}

+ (void)swizzleMyNizzle
{
//  NSError *e1 = nil;  
  Method original, swizzled;
  
  original = class_getInstanceMethod(NSClassFromString(@"TGlobalWindowController"), @selector(cmdGoTo:));
  swizzled = class_getInstanceMethod(self, @selector(savePluginCmdGoTo:));
  method_exchangeImplementations(original, swizzled);
  
//  Class hackedClass = NSClassFromString(@"TGlobalWindowController");
//  Method myMethod = class_getInstanceMethod([self class], @selector(savePluginCmdGoTo:));
//  class_addMethod(hackedClass, @selector(savePluginCmdGoTo:), method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
//  
//  if (![NSClassFromString(@"TGlobalWindowController") jr_swizzleMethod:@selector(cmdGoTo:) withMethod:@selector(originalCmdGoTo:) error:&e1]) {
//    NSLog(@"failed with %@\n%@", e1, [e1 userInfo]);
//  }    
}

- (void)savePluginCmdGoTo:(id)sender
{
  NSLog(@"great success");
  [self savePluginCmdGoTo:sender];
}


@end
