//
//  FooterCell.swift
//  RxSwiftBasics5
//
//  Created by Young Kim on 2018-05-14.
//  Copyright © 2018 Younghwan Kim. All rights reserved.
//

import UIKit

class FooterCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel! {
        didSet {
            questionLabel.text = "Is your personal information correct?"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
