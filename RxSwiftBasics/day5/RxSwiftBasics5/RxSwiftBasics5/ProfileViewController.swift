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
    
    var userid: String?
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
    
    }

}
