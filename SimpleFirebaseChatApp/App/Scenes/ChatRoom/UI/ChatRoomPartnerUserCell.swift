//
//  ChatRoomPartnerCell.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import UIKit
import Nuke

class ChatRoomPartnerUserCell: UITableViewCell {

    static let cellIdentifier = "ChatRoomPartnerUserCell"

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2
        self.messageTextView.layer.cornerRadius = 15
        self.messageTextView.isEditable = false
        self.messageTextView.isSelectable = false
        self.messageTextView.isScrollEnabled = false
        self.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
    }

    func setupValue(message: String?, user: User?) {
        if let message = message,
           let urlString = user?.profileImageUrl,
           let url = URL(string: urlString) {
            messageTextView.text = message
            Nuke.loadImage(with: url, into: userImageView)
        }
    }
}
