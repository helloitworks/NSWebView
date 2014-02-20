//
//  AppDelegate.h
//  WebView
//
//  Created by shenyixin on 10/15/12.


#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *navbar;

@property (weak) IBOutlet WebView *webView;
- (IBAction)enterToGo:(id)sender;
- (IBAction)clickTogo:(id)sender;

@property (weak) IBOutlet NSButton *btnGoBack;
@property (weak) IBOutlet NSButton *btnGoForward;


@end
