//
//  ChatListViewController.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/14.
//

import UIKit

class ChatListViewController: UIViewController {

    let chatTableView = UITableView()
    let tempUserList = [
        "user 1",
        "user 2",
        "user 3"
    ]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.navigationController?.navigationBar.barTintColor = .navBarColor
        self.navigationItem.title = "トーク一覧"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        let rigntBarBtn = UIBarButtonItem(title: "新規チャット", style: .plain, target: self, action: #selector(temp))
        let logoutBarBtn = UIBarButtonItem(title: "ログアウト", style: .plain, target: self, action: #selector(temp))
        self.navigationItem.rightBarButtonItem = rigntBarBtn
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.navigationItem.leftBarButtonItem = logoutBarBtn
        self.navigationItem.leftBarButtonItem?.tintColor = .white

        self.view.addSubview(self.chatTableView)
        setupChatTableView()


    }

    @objc private func temp() {

        let userListViewController = UserListViewController()
        let navigationController = UINavigationController(rootViewController: userListViewController)
        self.present(navigationController,
                     animated: true,
                     completion: nil)
    }

    private func setupChatTableView() {
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        self.chatTableView.register(UINib(nibName: ChatListCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ChatListCell.cellIdentifier)
        self.chatTableView.separatorStyle = .none
        self.chatTableView.translatesAutoresizingMaskIntoConstraints = false
        self.chatTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.chatTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.chatTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.chatTableView.widthAnchor.constraint(equalToConstant: widthValue).isActive = true
    }
    

}

extension ChatListViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempUserList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: ChatListCell.cellIdentifier) as! ChatListCell
        cell.partnerLabel.text = tempUserList[indexPath.row]

        return cell
    }




}
