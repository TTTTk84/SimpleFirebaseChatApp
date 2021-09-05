//
//  LoginPresenter.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import Foundation

protocol LoginPresenterProtocol {
    func tappedLoginButton()
    func tappedSignUpButton()
    func checkLoginUser(email: String,
                        passWord: String,
                        completion: @escaping (Bool) -> Void)
}

class LoginPresenter {

    private let router: LoginRouter!
    private let useCase: ChatUseCaseProtocol!

    init(router: LoginRouter, useCase: ChatUseCaseProtocol) {
        self.router = router
        self.useCase = useCase
    }

}

extension LoginPresenter: LoginPresenterProtocol {

    func checkLoginUser(email: String,
                        passWord: String,
                        completion: @escaping (Bool) -> Void) {
        self.useCase.checkLoginUser(email: email,
                                    passWord: passWord)
        { [weak self] bool in
            completion(bool)
        }
    }

    func tappedSignUpButton() {
        self.router.transitionToSignUp()
    }

    func tappedLoginButton() {
        self.router.transitionToLoginSuccess()
    }


}
