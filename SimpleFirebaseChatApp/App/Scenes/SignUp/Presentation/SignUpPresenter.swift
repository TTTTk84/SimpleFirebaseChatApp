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
    private let userUseCase: UserUsecaseProtocol!

    init(router: SignUpRouter, userUseCase: UserUsecaseProtocol) {
        self.router = router
        self.userUseCase = userUseCase
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
