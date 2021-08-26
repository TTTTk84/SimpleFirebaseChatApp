//
//  UserListViewController.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/14.
//


import UIKit

class UserListViewController: UIViewController {

    let userTableView = UITableView()
    let tempUserList = [
        "user 1",
        "user 2",
        "user 3"
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.navigationController?.navigationBar.barTintColor = .navBarColor
        self.navigationItem.title = "登録ユーザ一覧"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        self.view.addSubview(self.userTableView)
        self.setupUserTableView()
    }

    private func setupUserTableView() {
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
        return tempUserList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: UserListCell.cellIdentifier) as! UserListCell
        cell.partnerLabel.text = tempUserList[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped table view")
//        let storyboard = UIStoryboard.init(name: "ChatRoom", bundle: nil)
//        let chatRoomViewController = storyboard.instantiateViewController(withIdentifier: "ChatRoomViewController") as! ChatRoomViewController
//        chatRoomViewController.user = user
//        chatRoomViewController.chatroom = chatroooms[indexPath.row]
//        navigationController?.pushViewController(chatRoomViewController, animated: true)
        
    }
}
