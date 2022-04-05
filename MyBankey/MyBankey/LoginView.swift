//
//  LoginView.swift
//  MyBankey
//
//  Created by Luis Lagos on 02/04/22.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    let stackView = UIStackView()
    
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let dividerView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    // this is a default size a control wants to be
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: 200, height: 200)      // make 200 x 200 the default
//    }
    
} // class LoginView: UIView


extension LoginView {
    
    private func style() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .secondarySystemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8   // 8 points of space btw elements
        
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "User name"
        usernameTextField.delegate = self

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true  // enable non-visible characteres
        passwordTextField.delegate = self
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        
        // round the corners of the View
        layer.cornerRadius = 5
        clipsToBounds = true
        

        
    } // private func style
    
    private func layout() {
        
        //add elements to the stackview, the order matters
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
        
        addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
          
            // topAnchor, leadingAnchor, trailinganchor = view
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
        
        // another way to define constraints
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
    } // private func layout()

} // extension LoginView


// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    
    // true means = yes, it finishes editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        
        return true
    }
    
    //check what's actually in the text field, return true if not empty
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    
    } // textFieldShouldEndEditing
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}


