//
//  LoginRouter.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation

protocol ChatViewProtocol {
    func reloadTableView()
}

protocol LoginRouterProtocol {
    func transitionToSignUp()
    func transitionToLoginSuccess()
}


class LoginRouter: LoginRouterProtocol {

    private(set) var view: ChatViewProtocol!
    private let useCase = Application.shared.useCase


    init(view: ChatViewProtocol) {
        self.view = view
    }

    func transitionToSignUp() {
    }

    func transitionToLoginSuccess() {
    }

}
