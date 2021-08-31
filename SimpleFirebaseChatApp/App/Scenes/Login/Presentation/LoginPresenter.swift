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
    func tappedSignUpButton() {
        self.router.transitionToSignUp()
    }

    func tappedLoginButton() {
        self.router.transitionToLoginSuccess()
    }


}
