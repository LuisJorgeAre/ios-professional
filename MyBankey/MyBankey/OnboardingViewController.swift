//
//  OnboardingViewController.swift
//  MyBankey
//
//  Created by Luis Lagos on 12/04/22.
//

// code snippet "NewVC StackView"
// a new VC, StackView with a label in the center.

import UIKit

class OnboardingViewController: UIViewController {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
    } // viewDidLoad
        
} // class OnboardingViewController


extension OnboardingViewController {
    
    private func style() {  // the way the controls look like, e.g., color, size, etc.
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        // image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "delorean")
        
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true          // adjust the font dinamically
        label.numberOfLines = 0                         // make it multiline
        label.text = "Bankey is faster, easier to use and has a brand new look and feel that will make you feel like you are back in 1989"
        
        
    }
        
    
    private func layout() {  // add the subView to the View and their constraints.
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)     // add the label
        view.addSubview(stackView)              // add StackView to the parent VC
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor,
                                              multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor,                                         multiplier: 1)
            
        ])

    } // layout()
    
} // extension OnboardingViewController
