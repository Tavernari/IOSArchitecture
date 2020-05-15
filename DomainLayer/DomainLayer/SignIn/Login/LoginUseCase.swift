//
//  LoginUseCase.swift
//  DomainLayer
//
//  Created by Lucas Silveira on 05/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol LoginUseCaseInterfaceAdapter {
    func startedAuth()
    func logedIn(loginModel: LoginModel)
    func failureOnLogin()
    func invalidEmail()
    func invalidPassword()
}

public class LoginUseCase {
    public var delegateInterfaceAdapter: LoginUseCaseInterfaceAdapter?
    let repository: SignInRepositoryProtocol

    init(repository: SignInRepositoryProtocol) {
        self.repository = repository
    }

    private func loginIsValid(email: String, password: String) -> Bool {
        if !email.isValidEmail() {
            delegateInterfaceAdapter?.invalidEmail()
            return false
        }

        if !password.isValidPassword() {
            delegateInterfaceAdapter?.invalidPassword()
            return false
        }

        return true
    }

    public func execute(email: String, password: String) {
        guard loginIsValid(email: email, password: password) else { return }

        delegateInterfaceAdapter?.startedAuth()

        repository.login(email: email, password: password) { result in
            guard let loginModel = try? result.handle(), loginModel.token.isEmpty == false else {
                self.delegateInterfaceAdapter?.failureOnLogin()
                return
            }

            self.delegateInterfaceAdapter?.logedIn(loginModel: loginModel)
        }
    }
}