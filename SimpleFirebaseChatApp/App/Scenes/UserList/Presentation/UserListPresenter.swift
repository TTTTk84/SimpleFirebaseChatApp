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

    private(set) var userList: [User] = [
        User(dic: ["username": "user 1"]),
        User(dic: ["username": "user 2"]),
        User(dic: ["username": "user 3"]),
        User(dic: ["username": "user 4"]),
    ]

    private let router: UserListRouterProtocol!
    private let useCase: ChatUseCaseProtocol!
    private var selectedUsers: [User]!

    init(router: UserListRouterProtocol, useCase: ChatUseCaseProtocol) {
        self.router = router
        self.useCase = useCase
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
        self.router.transitionToChatList()
    }


}
