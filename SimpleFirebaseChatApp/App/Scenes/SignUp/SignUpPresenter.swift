//
//  SignUpPresenter.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import Foundation

protocol SignUpPresenterProtocol {
    func tappedSignUpButton(doc: [String: Any],imageData: Data)
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
    func tappedSignUpButton(doc: [String: Any],imageData: Data) {
        
        userUseCase.createUser(doc: doc,
                               imageData: imageData){ bool in
            if !bool {
                return
            }
            self.router.transitionToSignUpSuccess()
        }
    }

    func tappedLoginButton() {
        self.router.transitionToLogin()
    }


}
