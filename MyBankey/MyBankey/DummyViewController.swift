//
//  DummyViewCntroller.swift
//  MyBankey
//
//  Created by Luis Lagos on 23/04/22.
//

// code snippet "NewVC StackView"
// a new VC, StackView with a label in the center.

import UIKit

class DummyViewController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let logoutButton = UIButton(type: .system)
    
    // 2 - Protocol-Delegate
    weak var logoutDelegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
    } // viewDidLoad
    
} // class DummyViewCntroller


extension DummyViewController {
    
    private func style() {  // the way the controls look like, e.g., color, size, etc.
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Welcome - dummyPlaceholder"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.configuration = .filled()
        logoutButton.setTitle("Logout", for: [])
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped),
                               for: .primaryActionTriggered)
        
        
    } // style
    
    private func layout() {  // add the subView to the View and their constraints.
        
        stackView.addArrangedSubview(label) // add the label to the Stack View
        stackView.addArrangedSubview(logoutButton)
        
        view.addSubview(stackView)          // add StackView to the parent VC
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    } // layout()
    
    
    @objc func logoutButtonTapped(sender: UIButton){
        // 3 - Protocol-Delegate
        logoutDelegate?.didLogout()

    }
    
    
    
} // extension DummyViewCntroller
