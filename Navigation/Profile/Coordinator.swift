//
//  Coordinator.swift
//  Navigation
//
//  Created by Ислам on 16.11.2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
