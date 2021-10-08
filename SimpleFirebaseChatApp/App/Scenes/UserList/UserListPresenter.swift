//
//  UserListPresenter.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//


import Foundation

protocol UserListPresenterProtocol {
    var numberOfUsers: Int { get }
    func didSelectRow(at indexPath: IndexPath)
    func checkUserListRow(forRow row: Int) -> User?
    func addSelectedUsers(user: User)
    func tappedAddUserButton()
    func transitionToChatList()
}


class UserListPresenter {

    private(set) var userList: [User] = []

    private let router: UserListRouterProtocol!
    private var userUseCase: UserUsecaseProtocol!
    private var chatRoomUseCase: ChatRoomUsecaseProtocol!
    private var selectedUsers: [User]!
    private var chatListView: ChatViewProtocol!
    private var view: ChatViewProtocol!

    init(view: ChatViewProtocol,
         router: UserListRouterProtocol,
         userUseCase: UserUsecaseProtocol,
         chatRoomUseCase: ChatRoomUsecaseProtocol) {
        self.view = view
        self.router = router
        self.userUseCase = userUseCase
        self.chatRoomUseCase = chatRoomUseCase
        self.userUseCase.userListOutput = self
        self.userUseCase.fetchUserAll()
    }

}

extension UserListPresenter: UserListPresenterProtocol {




    var numberOfUsers: Int {
        return self.userList.count
    }

    func didSelectRow(at indexPath: IndexPath) {
    }

    func checkUserListRow(forRow row: Int) -> User? {
        guard row < self.userList.count else { return nil }
        return self.userList[row]
    }

    func addSelectedUsers(user: User) {
        self.selectedUsers = []
        self.selectedUsers.append(user)
    }

    func tappedAddUserButton() {

        let alert = AddChatRoomAlert(selectedUsers: self.selectedUsers,
                                     useCase: self.chatRoomUseCase,
                                     view: view as! UserListAlertProtocol)
        alert.createChatRoomAlert()
//        let tempUser = User(dic: ["username": "new user"])
//        self.chatRoomUseCase.createChatRoom(chatRoomName: "hogehoge",
//                                            members: [tempUser])
    }

    func transitionToChatList() {
        self.router.transitionToChatList()
    }



}

extension UserListPresenter: ChatUseCaseUserListOutput {
    func useCaseDidUpdate(userList: [User]) {

        self.userList = userList
        self.view.reloadTableView()
    }
}


