//
//  NavigationTests.swift
//  NavigationTests
//
//  Created by Ислам on 16.04.2025.
//

import XCTest
@testable import Navigation

class LoginViewModelTests: XCTestCase {
    
    // MARK: - Test SignIn Method
    
    func testSignInWithEmptyFields() {
        // Arrange
        let mockDelegate = MockLoginDelegate()
        let viewModel = LoginViewModel(delegate: mockDelegate)
        
        // Expectations
        let expectation = XCTestExpectation(description: "Empty fields completion should be called")
        var receivedError: Error?
        
        // Act
        viewModel.signIn(email: "", password: "") { result in
            if case .failure(let error) = result {
                receivedError = error
            }
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(receivedError, "Should receive an error for empty fields")
        
        XCTAssertTrue(viewModel.isLoggedIn == false, "User should not be logged in after an error")
    }
    
    func testSignInSuccess() {
        // Arrange
        let mockDelegate = MockLoginDelegate()
        mockDelegate.shouldSucceed = true
        let viewModel = LoginViewModel(delegate: mockDelegate)
        
        // Expectations
        let expectation = XCTestExpectation(description: "Success completion should be called")
        var isSuccess = false
        
        // Act
        viewModel.signIn(email: "test@example.com", password: "password") { result in
            if case .success = result {
                isSuccess = true
            }
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(isSuccess, "Should return success for valid credentials")
        XCTAssertTrue(viewModel.isLoggedIn, "User should be logged in after successful authentication")
    }
    
    func testSignInFailure() {
        // Arrange
        let mockDelegate = MockLoginDelegate()
        mockDelegate.shouldSucceed = false
        let viewModel = LoginViewModel(delegate: mockDelegate)
        
        // Expectations
        let expectation = XCTestExpectation(description: "Failure completion should be called")
        var receivedError: Error?
        
        // Act
        viewModel.signIn(email: "test@example.com", password: "wrong") { result in
            if case .failure(let error) = result {
                receivedError = error
            }
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(receivedError, "Should receive an error for invalid credentials")
        XCTAssertFalse(viewModel.isLoggedIn, "User should not be logged in after authentication failure")
    }
    
    // MARK: - Test SignUp Method
    
    func testSignUpWithEmptyFields() {
        // Arrange
        let mockDelegate = MockLoginDelegate()
        let viewModel = LoginViewModel(delegate: mockDelegate)
        
        // Expectations
        let expectation = XCTestExpectation(description: "Empty fields completion should be called")
        var receivedError: Error?
        
        // Act
        viewModel.signUp(email: "", password: "") { result in
            if case .failure(let error) = result {
                receivedError = error
            }
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(receivedError, "Should receive an error for empty fields")
        XCTAssertFalse(mockDelegate.signUpCalled, "Should not call delegate's signUp method for empty fields")
    }
    
    func testSignUpSuccess() {
        // Arrange
        let mockDelegate = MockLoginDelegate()
        mockDelegate.shouldSucceed = true
        let viewModel = LoginViewModel(delegate: mockDelegate)
        
        // Expectations
        let expectation = XCTestExpectation(description: "Success completion should be called")
        var isSuccess = false
        
        // Act
        viewModel.signUp(email: "new@example.com", password: "newpassword") { result in
            if case .success = result {
                isSuccess = true
            }
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(isSuccess, "Should return success for valid signup")
        XCTAssertTrue(mockDelegate.signUpCalled, "Should call delegate's signUp method")
    }
}

// MARK: - Mock Classes

class MockLoginDelegate: LoginViewControllerDelegate {
    var shouldSucceed = false
    var errorToReturn = NSError(domain: "com.test", code: -1, userInfo: nil)
    var signUpCalled = false
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if shouldSucceed {
            completion(.success(()))
        } else {
            completion(.failure(errorToReturn))
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        signUpCalled = true
        if shouldSucceed {
            completion(.success(()))
        } else {
            completion(.failure(errorToReturn))
        }
    }
}
