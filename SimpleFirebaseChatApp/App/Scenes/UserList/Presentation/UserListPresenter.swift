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
}


class UserListPresenter {

    private(set) var userList: [User] = []

    private let router: UserListRouterProtocol!
    private var useCase: ChatUseCaseProtocol!
    private var selectedUsers: [User]!
    private var view: ChatViewProtocol!

    init(view: ChatViewProtocol,router: UserListRouterProtocol, useCase: ChatUseCaseProtocol) {
        self.view = view
        self.router = router
        self.useCase = useCase
        self.useCase.userListOutput = self

        self.useCase.fetchUserAll()
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
                                     useCase: self.useCase)
        alert.createChatRoomAlert()
        //self.router.transitionToChatList()
    }

}

extension UserListPresenter: ChatUseCaseUserListOutput {
    func useCaseDidUpdate(userList: [User]) {
        self.userList = userList
        self.view.reloadTableView()
    }
}
