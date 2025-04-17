//
//  NavigationTests.swift
//  NavigationTests
//
//  Created by Ислам on 16.04.2025.
//

import XCTest
@testable import Navigation

class LoginViewModelTests: XCTestCase {
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test SignIn Method
    
    func testSignInWithEmptyFields() {
        // Arrange
        let mockDelegate = MockLoginDelegate()
        let viewModel = LoginViewModel(delegate: mockDelegate)
        
        // Act & Assert
        var completionCalled = false
        var receivedResult: Result<Void, Error>?
        
        viewModel.signIn(email: "", password: "") { result in
            completionCalled = true
            receivedResult = result
        }
        
        XCTAssertTrue(completionCalled, "Completion should be called synchronously for empty fields")
        
        if case .failure(let error) = receivedResult {
            XCTAssertNotNil(error, "Should receive an error for empty fields")
        } else {
            XCTFail("Expected failure result for empty fields")
        }
        
        XCTAssertFalse(viewModel.isLoggedIn, "User should not be logged in after empty fields error")
        XCTAssertFalse(mockDelegate.checkCredentialsCalled, "Should not call delegate methods for empty fields")
    }
    
    func testSignInWithNonEmptyCredentialsSuccess() {
        // Arrange
        let mockDelegate = MockLoginDelegate()
        mockDelegate.shouldSucceed = true
        let viewModel = LoginViewModel(delegate: mockDelegate)
        
        // Act
        let expectation = XCTestExpectation(description: "Sign in completion called")
        var receivedResult: Result<Void, Error>?
        
        viewModel.signIn(email: "test@example.com", password: "password") { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockDelegate.checkCredentialsCalled, "Should call delegate check credentials method")
        XCTAssertEqual(mockDelegate.lastEmail, "test@example.com")
        XCTAssertEqual(mockDelegate.lastPassword, "password")
        
        if case .success = receivedResult {
            XCTAssertTrue(viewModel.isLoggedIn, "User should be logged in after successful sign in")
        } else {
            XCTFail("Expected success result")
        }
    }
    
    func testSignInWithNonEmptyCredentialsFailure() {
        // Arrange
        let mockDelegate = MockLoginDelegate()
        mockDelegate.shouldSucceed = false
        let viewModel = LoginViewModel(delegate: mockDelegate)
        
        // Act
        let expectation = XCTestExpectation(description: "Sign in completion called")
        var receivedResult: Result<Void, Error>?
        
        viewModel.signIn(email: "test@example.com", password: "wrong") { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockDelegate.checkCredentialsCalled, "Should call delegate check credentials method")
        
        if case .failure = receivedResult {
            XCTAssertFalse(viewModel.isLoggedIn, "User should not be logged in after failed sign in")
        } else {
            XCTFail("Expected failure result")
        }
    }
    
    // MARK: - Test SignUp Method
    
    func testSignUpWithEmptyFields() {
        // Arrange
        let mockDelegate = MockLoginDelegate()
        let viewModel = LoginViewModel(delegate: mockDelegate)
        
        // Act
        var completionCalled = false
        var receivedResult: Result<Void, Error>?
        
        viewModel.signUp(email: "", password: "") { result in
            completionCalled = true
            receivedResult = result
        }
        
        // Assert
        XCTAssertTrue(completionCalled, "Completion should be called synchronously for empty fields")
        
        if case .failure(let error) = receivedResult {
            XCTAssertNotNil(error, "Should receive an error for empty fields")
        } else {
            XCTFail("Expected failure result for empty fields")
        }
        
        XCTAssertFalse(mockDelegate.signUpCalled, "Delegate signup should not be called for empty fields")
    }
    
    func testSignUpWithNonEmptyFields() {
        // Arrange
        let mockDelegate = MockLoginDelegate()
        mockDelegate.shouldSucceed = true
        let viewModel = LoginViewModel(delegate: mockDelegate)
        
        // Act
        let expectation = XCTestExpectation(description: "Sign up completion called")
        var receivedResult: Result<Void, Error>?
        
        viewModel.signUp(email: "new@example.com", password: "newpassword") { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockDelegate.signUpCalled, "Should call delegate signUp method")
        XCTAssertEqual(mockDelegate.lastEmail, "new@example.com")
        XCTAssertEqual(mockDelegate.lastPassword, "newpassword")
        
        if case .success = receivedResult {
        } else {
            XCTFail("Expected success result")
        }
    }
}

// MARK: - Mock Classes

class MockLoginDelegate: LoginViewControllerDelegate {
    var shouldSucceed = false
    var errorToReturn = NSError(domain: "com.test", code: -1, userInfo: nil)
    
    var checkCredentialsCalled = false
    var signUpCalled = false
    var lastEmail: String?
    var lastPassword: String?
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        checkCredentialsCalled = true
        lastEmail = email
        lastPassword = password
        
        if shouldSucceed {
            completion(.success(()))
        } else {
            completion(.failure(errorToReturn))
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        signUpCalled = true
        lastEmail = email
        lastPassword = password
        
        if shouldSucceed {
            completion(.success(()))
        } else {
            completion(.failure(errorToReturn))
        }
    }
}
