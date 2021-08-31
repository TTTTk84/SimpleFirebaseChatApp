//
//  ChatListPresenter.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//


import Foundation

protocol ChatListPresenterProtocol {
    var numberOfUsers: Int { get }

    func didSelectRow(at indexPath: IndexPath)
    func checkChatRoomRow(forRow row: Int) -> ChatRoom?
    func tappedNewChatButton()
    func tappedLogoutButton()
}


class ChatListPresenter {

    private(set) var chatRoomList: [ChatRoom] = []

    private let router: ChatListRouterProtocol!
    private var useCase: ChatUseCaseProtocol!
    private let view: ChatViewProtocol!

    init(view: ChatViewProtocol, router: ChatListRouterProtocol, useCase: ChatUseCaseProtocol) {
        self.view = view
        self.router = router
        self.useCase = useCase
        self.useCase.chatListOutput = self

        self.useCase.fetchChatRoomAll()
    }

}

extension ChatListPresenter: ChatListPresenterProtocol {

    var numberOfUsers: Int {
        return self.chatRoomList.count
    }

    func checkChatRoomRow(forRow row: Int) -> ChatRoom? {
        guard row < self.chatRoomList.count else { return nil }
        return self.chatRoomList[row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard let chatRoom = checkChatRoomRow(forRow: indexPath.row) else { return }
        self.router.transitionToChatRoom()
    }

    func tappedNewChatButton()  {
        self.router.transitionToNewChat()
    }


    func tappedLogoutButton() {
        self.router.transitionToLogout()
    }

}

extension ChatListPresenter: ChatUseCaseChatListOutput {
    func useCaseDidUpdate(chatroom: [ChatRoom]) {
        self.chatRoomList = chatroom
        self.view.reloadTableView()
    }


}
