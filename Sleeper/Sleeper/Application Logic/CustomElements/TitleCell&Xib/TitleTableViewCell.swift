//
//  TitleTableViewCell.swift
//  Sleeper
//
//  Created by user on 18.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .white
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        selectionStyle = .none
        backgroundColor = .darkGray
    }

    func configure(title: String) {
        titleLabel.text = title
    }
}
