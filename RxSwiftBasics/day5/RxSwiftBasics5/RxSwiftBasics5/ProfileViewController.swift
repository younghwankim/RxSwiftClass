//
//  ProfileViewController.swift
//  RxSwiftBasics5
//
//  Created by Young Kim on 2018-05-14.
//  Copyright © 2018 Younghwan Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum ProfileCellModel {
    case header
    case labelValues (String, String?)
    case footer
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var profileViewModel: ProfileViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureTableView() {
        Observable.of([
            ProfileCellModel.header,
            ProfileCellModel.labelValues(self.profileViewModel.nameLabel, self.profileViewModel.name),
            ProfileCellModel.labelValues(self.profileViewModel.mobilePhoneLabel, self.profileViewModel.mobilePhone),
            ProfileCellModel.labelValues(self.profileViewModel.emailLabel, self.profileViewModel.email),
            ProfileCellModel.footer
            ])
            .bind(to: self.tableView.rx.items) {
                (tableView: UITableView, index: Int, element: ProfileCellModel) in
                let indexPath = IndexPath(item: index, section: 0)
                switch element {
                case .header:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell", for: indexPath) as! SectionCell
                    return cell
                case .labelValues(let cellLabel, let cellvalue):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFieldCell", for: indexPath) as! ProfileFormCell
                    cell.fieldTitleLabel.text = cellLabel
                    cell.fieldValueLabel.text = cellvalue!
                    return cell
                case .footer:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FooterCell", for: indexPath) as! FooterCell
                    return cell
                }
            }
            .disposed(by: self.disposeBag)
        tableView.estimatedRowHeight = self.tableView.frame.height
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}
