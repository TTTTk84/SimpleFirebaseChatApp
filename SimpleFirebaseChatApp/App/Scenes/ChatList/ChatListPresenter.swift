//
//  ChatListPresenter.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//


import Foundation

protocol ChatListPresenterProtocol {
    var numberOfUsers: Int { get }

    func currentUser(completion: @escaping (User) -> Void)
    func didSelectRow(at indexPath: IndexPath)
    func checkChatRoomRow(forRow row: Int) -> ChatRoom?
    func tappedNewChatButton()
    func tappedLogoutButton()
}


class ChatListPresenter {

    private(set) var chatRoomList: [ChatRoom] = []
    private(set) var userTitle: String!

    private let router: ChatListRouterProtocol!
    private var userUseCase: UserUsecaseProtocol!
    private var chatRoomUseCase: ChatRoomUsecaseProtocol!
    private let view: ChatViewProtocol!

    init(view: ChatViewProtocol,
         router: ChatListRouterProtocol,
         userUseCase: UserUsecaseProtocol,
         chatRoomUseCase: ChatRoomUsecaseProtocol) {
        self.view = view
        self.router = router
        self.userUseCase = userUseCase
        self.chatRoomUseCase = chatRoomUseCase
        self.chatRoomUseCase.chatListOutput = self
        self.chatRoomUseCase.fetchChatRoomAll()
    }

}

extension ChatListPresenter: ChatListPresenterProtocol {

    var numberOfUsers: Int {
        return self.chatRoomList.count
    }

    func currentUser(completion: @escaping (User) -> Void) {
        self.userUseCase.getLoginUser() { [weak self] user in
            completion(user)
        }
    }

    func checkChatRoomRow(forRow row: Int) -> ChatRoom? {
        guard row < self.chatRoomList.count else { return nil }
        return self.chatRoomList[row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard let chatRoom = checkChatRoomRow(forRow: indexPath.row) else { return }
        self.router.transitionToChatRoom(chatroom: chatRoom)
    }

    func tappedNewChatButton()  {
        self.router.transitionToNewChat()
    }


    func tappedLogoutButton() {
        self.router.transitionToLogout()
    }

}

extension ChatListPresenter: ChatUseCaseChatListOutput {
    func useCaseTitleUpdate(title: String) {
        self.userTitle = title
    }

    func useCaseDidUpdate(chatroom: [ChatRoom]) {
        print("update")
        self.chatRoomList = chatroom
        self.view.reloadTableView()
    }


}
