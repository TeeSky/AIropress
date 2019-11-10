//
//  AppDelegate.swift
//  AIropress
//
//  Created by Tomas Skypala on 14/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    var flowController: MainFlowController?

    func applicationDidFinishLaunching(_ application: UIApplication) {

        // Override point for customization after application launch.
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController = navigationController

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        self.window = window

        let flowController = MainFlowController(navigationController: navigationController,
                                                viewControllerProvider: MainViewControllerProvider())
        self.flowController = flowController

        window.makeKeyAndVisible()

        flowController.startFlow(launchMode: .normal)
    }

    func application(
        _ application: UIApplication,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        completionHandler(handleShortcut(shortcutItem: shortcutItem))
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func handleShortcut(shortcutItem: UIApplicationShortcutItem) -> Bool {

        flowController?.startFlow(launchMode: launchMode(for: shortcutItem))

        return true
    }

    private func launchMode(for shortcutItem: UIApplicationShortcutItem) -> LaunchMode {

        let launchMode: LaunchMode
        switch shortcutItem.type {
        case UserActivityType.brewDefaultFilter:
            launchMode = .brewShortcut(BrewRecipe.createDefaultFilterRecipe())
        case UserActivityType.brewDefaultPrismoEspresso:
            launchMode = .brewShortcut(BrewRecipe.createDefaultPrismoEspressoRecipe())
        default:
            launchMode = .normal
        }

        return launchMode
    }

}
