//
//  LogInUseCaseTests.swift
//  DomainLayerTests
//
//  Created by Lucas Silveira on 05/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

@testable import DomainLayer
import XCTest

class MockLoginViewModel: LoginUseCaseInterfaceAdapter {
    let startedAuthAssert, logedInAssert, failureOnLoginAssert, invalidEmailAssert, invalidPasswordAssert: Bool

    init(startedAuth: Bool, logedIn: Bool, failureOnLogin: Bool, invalidEmail: Bool, invalidPassword: Bool) {
        startedAuthAssert = startedAuth
        logedInAssert = logedIn
        failureOnLoginAssert = failureOnLogin
        invalidEmailAssert = invalidEmail
        invalidPasswordAssert = invalidPassword
    }

    func startedAuth() {
        XCTAssert(startedAuthAssert)
    }

    func logedIn(loginModel: LoginModel) {
        XCTAssert(logedInAssert)
        XCTAssertNotNil(loginModel.token.isEmpty == !logedInAssert)
    }

    func failureOnLogin() {
        XCTAssert(failureOnLoginAssert)
    }

    func invalidEmail() {
        XCTAssert(invalidEmailAssert)
    }

    func invalidPassword() {
        XCTAssert(invalidPasswordAssert)
    }
}

struct LoginUseCaseParams {
    var customToken: String? = ""
    var startedAuth, logedIn, failureOnLogin, invalidEmail, invalidPassword: Bool
}

class LoginUseCaseTests: XCTestCase {
    var paramsState: LoginUseCaseParams!

    override func setUp() {
        paramsState = LoginUseCaseParams(customToken: "token123",
                                         startedAuth: true,
                                         logedIn: true,
                                         failureOnLogin: true,
                                         invalidEmail: true,
                                         invalidPassword: true)
    }

    func loadLoginUseCase(params: LoginUseCaseParams) -> LoginUseCase {
        var loginModel = LoginModel()
        loginModel.token = params.customToken!

        let repository = MockSignInRepository(loginResult: .success(loginModel))
        let useCase = LoginUseCase(repository: repository)
        let viewModel = MockLoginViewModel(startedAuth: params.startedAuth,
                                           logedIn: params.logedIn,
                                           failureOnLogin: params.failureOnLogin,
                                           invalidEmail: params.invalidEmail,
                                           invalidPassword: params.invalidPassword)

        useCase.delegateInterfaceAdapter = viewModel

        return useCase
    }

    func testLoginWithValidEmailAndPassword_shouldReturnTrue() {
        paramsState.failureOnLogin = false
        paramsState.invalidEmail = false
        paramsState.invalidPassword = false

        let useCase = loadLoginUseCase(params: paramsState)
        useCase.execute(email: "lucas@email.com", password: "pass123")
    }

    func testLoginWithValidEmailAndPassword_shouldReturnFalse() {
        paramsState.customToken = ""
        paramsState.logedIn = false
        paramsState.invalidEmail = false
        paramsState.invalidPassword = false

        let useCase = loadLoginUseCase(params: paramsState)
        useCase.execute(email: "lucas@email.com", password: "pass123")
    }

    func testLoginWithInvalidEmailAndPassword_shouldReturnFalse() {
        paramsState.logedIn = false
        paramsState.failureOnLogin = false
        paramsState.invalidPassword = false

        let useCase = loadLoginUseCase(params: paramsState)
        useCase.execute(email: "lucas@email", password: "pass123")
    }

    func testLoginWithInvalidPassword_shouldReturnFalse() {
        paramsState.logedIn = false
        paramsState.failureOnLogin = false
        paramsState.invalidEmail = false

        let useCase = loadLoginUseCase(params: paramsState)
        useCase.execute(email: "lucas@email.com", password: "pass")
    }
}
