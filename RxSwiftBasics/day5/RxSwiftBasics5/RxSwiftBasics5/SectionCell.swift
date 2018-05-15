//
//  SectionCell.swift
//  RxSwiftBasics5
//
//  Created by Young Kim on 2018-05-14.
//  Copyright © 2018 Younghwan Kim. All rights reserved.
//

import UIKit

class SectionCell: UITableViewCell {
    
    @IBOutlet weak var sectionTitleLabel: UILabel! {
        didSet {
            sectionTitleLabel.text = "Personal Information"
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
