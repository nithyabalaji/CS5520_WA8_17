//
//  ChatMessageTableViewCell.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/12/24.
//

import UIKit

class ChatMessageTableViewCell: UITableViewCell {
    let messageLabel = UILabel()
        let messageBackgroundView = UIView()
    let timestampLabel = UILabel()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupMessageBackgroundView()
            setupMessageLabel()
            setupTimestampLabel()
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
         func setupMessageBackgroundView() {
            messageBackgroundView.backgroundColor = UIColor.lightGray
            messageBackgroundView.layer.cornerRadius = 12
            messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(messageBackgroundView)
        }
    func setupTimestampLabel() {
            timestampLabel.font = UIFont.systemFont(ofSize: 12)
            timestampLabel.textColor = .black
            timestampLabel.textAlignment = .right
            timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        messageBackgroundView.addSubview(timestampLabel)
        }
        
         func setupMessageLabel() {
            messageLabel.font = UIFont.systemFont(ofSize: 16)
            messageLabel.textColor = .black
            messageLabel.numberOfLines = 0
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageBackgroundView.addSubview(messageLabel)
        }
        
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Background view constraints
            messageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            messageBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            messageBackgroundView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.centerXAnchor),

            // Message label constraints
            messageLabel.topAnchor.constraint(equalTo: messageBackgroundView.topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: messageBackgroundView.bottomAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: messageBackgroundView.trailingAnchor, constant: -12),
            
            // Timestamp label constraints
            timestampLabel.topAnchor.constraint(equalTo: messageBackgroundView.bottomAnchor, constant: 2),
            timestampLabel.leadingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor, constant: 0),
            timestampLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
