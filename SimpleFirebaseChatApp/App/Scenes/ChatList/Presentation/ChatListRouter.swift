//
//  ChatListRouter.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import UIKit


protocol ChatListRouterProtocol {
    func transitionToLogout()
    func transitionToNewChat()
    func transitionToChatRoom()
}


class ChatListRouter: ChatListRouterProtocol {



    private(set) var view: ChatViewProtocol!
    private let useCase = Application.shared.useCase


    init(view: ChatViewProtocol) {
        self.view = view
    }

    func transitionToLogout() {
        self.view.popViewController(animated: true)
    }

    func transitionToNewChat() {
        let userListViewController = UserListViewController()
        let navigationController = UINavigationController(rootViewController: userListViewController)

        let router = UserListRouter(view: userListViewController)
        let presenter = UserListPresenter(view: userListViewController,
                                          router: router,
                                          useCase: self.useCase!)
        userListViewController.inject(presenter: presenter)

        self.view.present(navigationController, animated: true, completion: nil)
    }

    func transitionToChatRoom() {
        let chatRoomViewController = ChatRoomViewController()
        self.view.pushViewController(chatRoomViewController, animated: true)
    }

}

