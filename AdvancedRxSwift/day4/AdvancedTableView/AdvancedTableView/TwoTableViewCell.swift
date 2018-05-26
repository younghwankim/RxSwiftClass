//
//  TwoTableViewCell.swift
//  AdvancedTableView
//
//  Created by Young Kim on 2018-05-26.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TwoTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    let textValue = BehaviorRelay(value: "")
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        let textDisposable = textField.rx.textInput <-> textValue
        textDisposable.disposed(by: self.disposeBag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        
        let textDisposable = textField.rx.textInput <-> textValue
        textDisposable.disposed(by: self.disposeBag)
    }
    
}
