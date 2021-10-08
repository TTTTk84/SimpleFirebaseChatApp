//
//  UserListCell.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import UIKit

class UserListCell: UITableViewCell {
    static let cellIdentifier = "UserListCell"
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var partnerLabel: UILabel!

    func setupValue(partnerLabel: String) {
        self.partnerLabel.text = partnerLabel
    }
}
