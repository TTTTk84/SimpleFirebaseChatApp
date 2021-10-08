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
    private let userUseCase: UserUsecaseProtocol = Application.shared.userUseCase
    private let chatRoomUseCase: ChatRoomUsecaseProtocol = Application.shared.chatRoomUseCase


    init(view: ChatViewProtocol) {
        self.view = view
    }

    func transitionToSignUp() {
        let signUpViewController = SignUpViewController()
        let signUpRouter = SignUpRouter(view: signUpViewController)
        let signUpPresenter = SignUpPresenter(router: signUpRouter, userUseCase: self.userUseCase)
        signUpViewController.inject(presenter: signUpPresenter)
        self.view.pushViewController(signUpViewController, animated: true)
    }

    func transitionToLoginSuccess() {
        let chatListViewController = ChatListViewController()
        let chatListRouter = ChatListRouter(view: chatListViewController)
        let chatListPresenter = ChatListPresenter(view:
                                                    chatListViewController,
                                                  router: chatListRouter,
                                                  userUseCase: self.userUseCase,
                                                  chatRoomUseCase: self.chatRoomUseCase)
        chatListViewController.inject(presenter: chatListPresenter)
        
        self.view.pushViewController(chatListViewController, animated: true)
    }

}
