//
//  BordersViewController.swift
//  Borders
//
//  Created by Young Kim on 2018-05-21.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BordersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: BordersViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let _viewModel = viewModel {
            self.title = "\(_viewModel.countryName) : Borders"
                _viewModel.borderCountries.asObservable()
                    .bind(to: self.tableView.rx.items) {
                        (tableView: UITableView, index: Int, element: CountryDto) in
                        let indexPath = IndexPath(item: index, section: 0)
                        let cell = tableView.dequeueReusableCell(withIdentifier: "borderCell", for: indexPath)
                        cell.textLabel?.text = element.alpha3Code ?? ""
                        cell.detailTextLabel?.text = element.name ?? ""
                        
                        return cell
                    }
                    .disposed(by: self.disposeBag)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
