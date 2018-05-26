//
//  OneViewController.swift
//  AdvancedTableView
//
//  Created by Young Kim on 2018-05-26.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class OneViewController: UIViewController {

    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var defaultButton: UIButton!
    @IBOutlet weak var userInputLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let viewModel = OneViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.updateProduct(seed: 0)
        self.configureTableView()
        
        self.buttonOne.rx.tap
            .scan(0) { lastCount, newValue in
                return lastCount + 1
            }
        .subscribe(onNext: { seed in
            self.viewModel.updateProduct(seed: seed)
        }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureTableView() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<(String, String), Int>>(
            configureCell: { (_, tv, indexPath, element:Int ) in
                if indexPath.section == 0 {
                    if let cell = tv.dequeueReusableCell(withIdentifier: "oneTableViewCell", for: indexPath) as? OneTableViewCell {
                        cell.textLabel?.text = "\(element)"
                        return cell
                    }
                } else {
                    if let cell = tv.dequeueReusableCell(withIdentifier: "twoTableViewCell", for: indexPath) as? TwoTableViewCell {
                        cell.textLabel?.text = "\(element)"
                        
                        cell.textValue.asObservable()
                            .bind(to: self.userInputLabel.rx.text)
                            .disposed(by: cell.disposeBag)
                        
//                        cell.textValue.asDriver()
//                            .drive(self.userInputLabel.rx.text)
//                            .disposed(by: cell.disposeBag)
//
//                        cell.textValue.asObservable()
//                            .subscribe(onNext: { input in
//                                self.userInputLabel.text = input
//                            })
//                            .disposed(by: cell.disposeBag)
//
//                        cell.textValue.asDriver()
//                            .drive(onNext: { input in
//                                self.userInputLabel.text = input
//                            })
//                            .disposed(by: cell.disposeBag)
                        
                        self.defaultButton.rx.tap.asDriver()
                            .drive(onNext: { _ in
                                cell.textValue.accept("")
                            }).disposed(by: cell.disposeBag)

                        return cell
                    }
                }
                return UITableViewCell()
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model.0
            }
        )
        viewModel.productDataSource
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
