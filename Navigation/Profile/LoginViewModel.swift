//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Ислам on 16.04.2025.
//

import Foundation

final class LoginViewModel {
    
    private let delegate: LoginViewControllerDelegate
    
    private(set) var isLoggedIn = false
    
    init(delegate: LoginViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard !email.isEmpty, !password.isEmpty else {
            completion(.failure(LoginError.emptyFields))
            return
        }
        
        delegate.checkCredentials(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.isLoggedIn = true
                completion(.success(()))
            case .failure(let error):
                self.isLoggedIn = false
                completion(.failure(error))
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard !email.isEmpty, !password.isEmpty else {
            completion(.failure(LoginError.emptyFields))
            return
        }
        
        delegate.signUp(email: email, password: password, completion: completion)
    }
}
