//
//  LoginInspector.swift
//  Navigation
//
//  Created by Ислам on 10.12.2024.
//

final class LoginInspector: LoginViewControllerDelegate {
    private let service: CheckerServiceProtocol
    
    init(service: CheckerServiceProtocol = CheckerService()) {
        self.service = service
    }
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        service.checkCredentials(email: email, password: password, completion: completion)
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        service.signUp(email: email, password: password, completion: completion)
    }
}
