//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ислам on 12.08.2024.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        let alertButton = UIButton(type: .system)
        alertButton.setTitle("Show Alert", for: .normal)
        alertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertButton)
        
        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func showAlert() {
        let alertController = UIAlertController(title: "Alert", message: "This is an alert", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK pressed")
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel pressed")
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        present(alertController, animated: true, completion: nil)
    }
}
