//
//  ViewController.swift
//  MyBankey
//
//  Created by Luis Lagos on 01/04/22.
//

import UIKit

//MARK: - Protocols

// 1
protocol LogoutDelegate: AnyObject {
    
    func didLogout()
    
} // protocol LogoutDelegate


// 1 - Protocol-Delegate - signal when someone finishes the login process
// this is a protocol, not a delegate, do not get confused
// the postfix ...Delegate is just the namingConvention
protocol LoginViewControllerDelegate: AnyObject {
    
    // message to send to whoever register themselves to us
    func didLogin()     // functions defined in protocols don't have a body
    
    
} // protocol LoginViewControllerDelegate


class LoginViewController: UIViewController {

//MARK: UI variables
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    // use the custom View in the View Controller
    let loginView = LoginView()
    
    let signInButton = UIButton(type: .system)      // new kind of Button of iOS 15
    let errorMessageLabel = UILabel()

    // 2 - Protocol-Delegate - signal when someone finishes the login process
    // define the delegate in the class for people to register
    // "weak var" to avoid retain cycle (2 strong vars)
    weak var delegate: LoginViewControllerDelegate?

    
    // get TextFields data, computed properties to return those values
    var username: String? {
           return loginView.usernameTextField.text
       }

    var password: String? {
        return loginView.passwordTextField.text
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                      
        style()
        layout()

    } //viewDidLoad
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false 
    }


} // LoginViewController






extension LoginViewController {
    
    private func style() {
        
        view.backgroundColor = .systemBackground
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bankey"
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0     // 0 (zero) enables multiline
        subtitleLabel.text = "Your premium source for all things banking!"
        
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
    
        // Button
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        // iOS 15 Button configuration style (there are others, too)
        signInButton.configuration = .filled()
        // for the spinning indicator spacing
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        // error message
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed    // system colors work with light and darkmode
        errorMessageLabel.numberOfLines = 0         // 0 (zero) enables multiline
        errorMessageLabel.isHidden = true           // initialize the label hidden
        
    }
    
    
    private func layout() {
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        // Title
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Subtitle
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
            subtitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])

        // LoginView
        NSLayoutConstraint.activate([

            // put the view in the middle
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // 1x = 8 points, set 8 points from the leading side, 8 points is the standard unit by default
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor,
                                               multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor,
                                           multiplier: 1),
        ])
        
        // Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            // align this button to the LoginView constraints
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        // Error message
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            // align this label to the LoginView constraints
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])


        
        
    }  // func layout()
    
} // extension LoginViewController



//MARK: Actions

extension LoginViewController {
    
    
    @objc func signInTapped(sender: UIButton){
        
        errorMessageLabel.isHidden = true       // assumption
        login()
        
    }
    
    // Text fields validations
    private func login(){
        
        // unwrap the String optionals to get real Strings
        guard let username = username, let password = password else {
            // * assertionFailure * - only appears in debug builds.
            // gets compiled out of production builds. It's a developer bug, it should never happen.
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return  // to disappear the label message
        }
        
        // check username and password
        if username == "Luis" && password == "Luis" {
            // successful log in
            // Spinning indicator in the button
            signInButton.configuration?.showsActivityIndicator = true
            
            // 3 - Protocol-Delegate - signal when someone finishes the login process
            // send the signal to everyone to indicate that we finished login, we're done here.
            // we say that they are free to do what ever is next
            delegate?.didLogin()
            
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
        
    } // login()
    
    // * withMessage * - is an "Argument Label", only to make code more readable, elegant.
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false      // show the message
        errorMessageLabel.text = message
    }
    
} // extension LoginViewController

