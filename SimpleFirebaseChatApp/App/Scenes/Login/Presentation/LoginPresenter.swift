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
    private let userUseCase: UserUsecaseProtocol!

    init(router: LoginRouter, useCase: UserUsecaseProtocol) {
        self.router = router
        self.userUseCase = useCase
    }

}

extension LoginPresenter: LoginPresenterProtocol {

    func checkLoginUser(email: String,
                        passWord: String,
                        completion: @escaping (Bool) -> Void) {
        self.userUseCase.checkLoginUser(email: email,
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
