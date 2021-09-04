//
//  SignUpRouter.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import UIKit


protocol SignUpRouterProtocol {
    func transitionToSignUpSuccess()
    func transitionToLogin()
}

class SignUpRouter: SignUpRouterProtocol {

    private(set) var view: ChatViewProtocol!
    private let useCase: ChatUseCaseProtocol = Application.shared.useCase


    init(view: ChatViewProtocol) {
        self.view = view
    }

    func transitionToSignUpSuccess() {
        let chatListViewController = ChatListViewController()
        let chatListRouter = ChatListRouter(view: chatListViewController)
        let chatListPresenter = ChatListPresenter(view: chatListViewController, router: chatListRouter,
                                                  useCase: self.useCase)
        chatListViewController.inject(presenter: chatListPresenter)
        self.view.pushViewController(chatListViewController, animated: true)
    }

    func transitionToLogin() {
        let loginViewController = LoginViewController()
        let loginRouter = LoginRouter(view: loginViewController)
        let loginPresenter = LoginPresenter(router: loginRouter, useCase: self.useCase)
        loginViewController.inject(presenter: loginPresenter)
        self.view.pushViewController(loginViewController, animated: true)
    }

}
