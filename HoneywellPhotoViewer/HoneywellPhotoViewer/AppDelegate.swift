//
//  AppDelegate.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var launchScreen : UIViewController!
    var navigationController : UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initializeNetworkMonitoring()
        initializeRootViewCtroller()
        return true
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
           PhotoDownloadManager.shared.clearCache()
       }
       func applicationWillResignActive(_ application: UIApplication) {
           // Hide Protected UI
           launchScreen = UIStoryboard.init(name: AppConstants.launchScreenName, bundle: nil).instantiateInitialViewController()
           window?.addSubview(self.launchScreen.view)
       }

       func applicationDidEnterBackground(_ application: UIApplication) {
           // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
           // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
       }

       func applicationWillEnterForeground(_ application: UIApplication) {
           // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
       }

       func applicationDidBecomeActive(_ application: UIApplication) {
           if let splash = launchScreen{
               splash.view.removeFromSuperview()
           }
       }
    
    // MARK: - Network Monitoring
    func initializeNetworkMonitoring(){
        NetworkMonitoringManager.shared.setUpNetworkMonitoring()
    }
    
    
    //MARK: - SetUp Root View
    func initializeRootViewCtroller(){
        let storyboard = UIStoryboard(name: AppConstants.mainStoryboardName, bundle: nil)
        let welcomeViewController = storyboard.instantiateViewController(withIdentifier: AppConstants.Identifier.welcomeViewController) as! WelcomeViewController
        navigationController = UINavigationController(rootViewController: welcomeViewController)
        window?.rootViewController = navigationController
    }



}

