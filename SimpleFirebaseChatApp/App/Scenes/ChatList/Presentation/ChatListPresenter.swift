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

    private(set) var chatRoomList: [ChatRoom] = [
        ChatRoom(dic: ["latestMessageId": "message1",
                       "chatRoomName": "chatroom 1"]),
        ChatRoom(dic: ["latestMessageId": "message2",
                       "chatRoomName": "chatroom 2"]),
        ChatRoom(dic: ["latestMessageId": "message3",
                       "chatRoomName": "chatroom 3"]),
    ]

    private let router: ChatListRouterProtocol!
    private let useCase: ChatUseCaseProtocol!

    init(router: ChatListRouterProtocol, useCase: ChatUseCaseProtocol) {
        self.router = router
        self.useCase = useCase
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
