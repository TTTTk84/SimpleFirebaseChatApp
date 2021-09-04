//
//  SignUpPresenter.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import Foundation

protocol SignUpPresenterProtocol {
    func tappedSignUpButton()
    func tappedLoginButton()
}


class SignUpPresenter {

    private let router: SignUpRouter!
    private let useCase: ChatUseCaseProtocol!

    init(router: SignUpRouter, useCase: ChatUseCaseProtocol) {
        self.router = router
        self.useCase = useCase
    }

}

extension SignUpPresenter: SignUpPresenterProtocol {
    func tappedSignUpButton() {
        self.router.transitionToSignUpSuccess()
    }

    func tappedLoginButton() {
        self.router.transitionToLogin()
    }


}
