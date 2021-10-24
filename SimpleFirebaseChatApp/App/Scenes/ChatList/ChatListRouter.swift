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
    func transitionToChatRoom(chatroom: ChatRoom)
}


class ChatListRouter: ChatListRouterProtocol {

    private(set) var view: ChatViewProtocol!
    private let userUseCase: UserUsecaseProtocol = Application.shared.userUseCase
    private let chatRoomUseCase: ChatRoomUsecaseProtocol = Application.shared.chatRoomUseCase
    private let messageUseCase: MessageUsecaseProtocol = Application.shared.messageUseCase

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
                                          userUseCase: self.userUseCase,
                                          chatRoomUseCase: self.chatRoomUseCase)
        userListViewController.inject(presenter: presenter)

        self.view.present(navigationController, animated: true, completion: nil)
    }

    func transitionToChatRoom(chatroom: ChatRoom) {
        let chatRoomViewController = ChatRoomViewController()
        let presenter = ChatRoomPresenter(view: chatRoomViewController,
                                          chatroom: chatroom,
                                          messageUseCase: self.messageUseCase, userUseCase: self.userUseCase)
        chatRoomViewController.inject(presenter: presenter)
        self.view.pushViewController(chatRoomViewController, animated: true)
    }

}

