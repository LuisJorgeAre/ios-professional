//
//  AppDelegate.swift
//  MyBankey
//
//  Created by Luis Lagos on 01/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {




    
    var window: UIWindow?
    
    // 4 - Protocol-Delegate - signal when someone finishes the login process
    let loginViewController = LoginViewController()
    
    // 4 - Protocol-Delegate
    let onboardingContainerViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        // 4 - Protocol-Delegate - signal when someone finishes the login process
        // register ourselves as the delegate for this loginViewController
        // we say "hey  loginViewController make us the delegate,
        // send us any signals you get, we want to receive them"
        loginViewController.delegate = self
        
        // 4 - Protocol-Delegate
        onboardingContainerViewController.delegate = self
        dummyViewController.logoutDelegate = self

        //window?.rootViewController = onboardingContainerViewController
        
//        window?.rootViewController = OnboardingViewController(heroImageName: "delorean",
//                                                              titleText: "Bankey is faster, page 1")
        
        window?.rootViewController = loginViewController

        
        return true
        
    } //func application


} // class AppDelegate



extension AppDelegate {
    // a nice transition or animation. Use this method:
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.7,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    } // setRootViewController
} // extension AppDelegate



// 5 - Protocol-Delegate - signal when someone finishes the login process
// Implement the protocol LoginViewControllerDelegate by creating an extension
extension AppDelegate: LoginViewControllerDelegate {
    
    // send the signal when login completes,
    // do whatever you want
    func didLogin() {
        print(" --> Did login")
        
        // read from user defaults
        if LocalState.hasOnboarded {
            setRootViewController(dummyViewController)
        } else {
            // transition to OnboardingContainerViewController ( after login was executed OK)
            // display onboarding when login completes.
            setRootViewController(onboardingContainerViewController)            
        } // else
        
        
    } // didLogin
    
} // extension AppDelegate: LoginViewControllerDelegate


// 5 - Protocol-Delegate
extension AppDelegate: OnboardingContainerViewControllerDelegate {

    func didFinishOnboarding() {
        print(" --> Did onboard")
        LocalState.hasOnboarded = true     // user has onboarded, read from user defaults
        setRootViewController(dummyViewController)
    }

} // extension AppDelegate


extension AppDelegate: LogoutDelegate {
    func didLogout() {
        // transition to loginViewController (the user logged out)
        setRootViewController(loginViewController)
    }
    
    
}



