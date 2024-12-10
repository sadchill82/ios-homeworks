//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Ислам on 10.12.2024.
//

protocol LoginViewControllerDelegate: AnyObject {
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}
