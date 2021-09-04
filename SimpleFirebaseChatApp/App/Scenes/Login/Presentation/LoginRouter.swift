//
//  LoginRouter.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import UIKit

protocol ChatViewProtocol: Transitioner {
    func reloadTableView()
}

protocol LoginRouterProtocol {
    func transitionToSignUp()
    func transitionToLoginSuccess()
}


class LoginRouter: LoginRouterProtocol {

    private(set) var view: ChatViewProtocol!
    private let useCase: ChatUseCaseProtocol = Application.shared.useCase


    init(view: ChatViewProtocol) {
        self.view = view
    }

    func transitionToSignUp() {
        let signUpViewController = SignUpViewController()
        let signUpRouter = SignUpRouter(view: signUpViewController)
        let signUpPresenter = SignUpPresenter(router: signUpRouter, useCase: self.useCase)
        signUpViewController.inject(presenter: signUpPresenter)
        self.view.pushViewController(signUpViewController, animated: true)
    }

    func transitionToLoginSuccess() {
        let chatListViewController = ChatListViewController()
        let chatListRouter = ChatListRouter(view: chatListViewController)
        let chatListPresenter = ChatListPresenter(view: chatListViewController, router: chatListRouter,
                                                  useCase: self.useCase)
        chatListViewController.inject(presenter: chatListPresenter)
        
        self.view.pushViewController(chatListViewController, animated: true)
    }

}
