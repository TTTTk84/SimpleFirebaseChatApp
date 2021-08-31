//
//  UserListViewController.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/14.
//


import UIKit

class UserListViewController: UIViewController {

    let userTableView = UITableView()

    private var presenter: UserListPresenterProtocol!

    func inject(presenter: UserListPresenterProtocol) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.setupNavigation()
        self.setupTableConstraint()
    }

    private func setupNavigation() {
        self.navigationController?.navigationBar.barTintColor = .navBarColor
        self.navigationItem.title = "登録ユーザ一覧"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let addUserButton = UIBarButtonItem(title: "追加", style: .plain, target: self, action: #selector(tappedAddUserButton))
        self.navigationItem.rightBarButtonItem = addUserButton
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }

    @objc private func tappedAddUserButton() {
        self.presenter.tappedAddUserButton()
    }

    private func setupTableConstraint() {
        self.view.addSubview(self.userTableView)

        self.userTableView.delegate = self
        self.userTableView.dataSource = self
        self.userTableView.register(UINib(nibName: UserListCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: UserListCell.cellIdentifier)
        self.userTableView.separatorStyle = .none
        self.userTableView.translatesAutoresizingMaskIntoConstraints = false
        self.userTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.userTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.userTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.userTableView.widthAnchor.constraint(equalToConstant: widthValue).isActive = true
    }
}

extension UserListViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfUsers
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: UserListCell.cellIdentifier) as! UserListCell

        let user = self.presenter.checkUserListRow(forRow: indexPath.row)

        cell.setupValue(partnerLabel: user!.username)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let selectedUser = self.presenter.checkUserListRow(forRow: indexPath.row) else {
            return
        }
        self.presenter.addSelectedUsers(user: selectedUser)
    }
}
