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
    private let userUseCase: UserUsecaseProtocol = Application.shared.userUseCase
    private let chatRoomUseCase: ChatRoomUsecaseProtocol = Application.shared.chatRoomUseCase


    init(view: ChatViewProtocol) {
        self.view = view
    }

    func transitionToSignUpSuccess() {
        let chatListViewController = ChatListViewController()
        let chatListRouter = ChatListRouter(view: chatListViewController)
        let chatListPresenter = ChatListPresenter(view: chatListViewController,
                                                  router: chatListRouter,
                                                  userUseCase: self.userUseCase,
                                                  chatRoomUseCase: self.chatRoomUseCase)
        chatListViewController.inject(presenter: chatListPresenter)
        self.view.pushViewController(chatListViewController, animated: true)
    }

    func transitionToLogin() {
        let loginViewController = LoginViewController()
        let loginRouter = LoginRouter(view: loginViewController)
        let loginPresenter = LoginPresenter(router: loginRouter, useCase: self.userUseCase)
        loginViewController.inject(presenter: loginPresenter)
        self.view.pushViewController(loginViewController, animated: true)
    }

}
