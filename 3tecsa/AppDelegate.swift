//
//  AppDelegate.swift
//  3tecsa
//
//  Created by Marvel Alvarez on 12/21/16.
//  Copyright (c) 2016 Marvel Alvarez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    func styleApp(){
    
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        //  estilo de la barra
        var navigationBarAppearace = UINavigationBar.appearance()
        var tabbarAppearence = UITabBar.appearance()
        
        navigationBarAppearace.tintColor = uicolorFromHex(0xffffff)
        navigationBarAppearace.barTintColor = uicolorFromHex(0x165F95)
        
        tabbarAppearence.tintColor = uicolorFromHex(0xffffff)
        tabbarAppearence.barTintColor = uicolorFromHex(0x165F95)
        
        // change navigation item title color
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        //tabbarAppearence.t
        //

    
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //copiar lo que me hace falta
       
        //error.text = filemgr.isReadableFileAtPath(dir).description
        NSThread .sleepForTimeInterval(1.5)
        
        styleApp()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

