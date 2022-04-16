//
//  AppDelegate.swift
//  MyBankey
//
//  Created by Luis Lagos on 01/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // this code is to setup a blank View Controller with the basics
    // The Storyboard and scenedelegate files have been already removed before.
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
//        window?.rootViewController = OnboardingViewController(heroImageName: "delorean",
//                                                              titleText: "Bankey is faster, page 1")
        
        window?.rootViewController = OnboardingContainerViewController()

        
        return true
        
    } //func application


}

