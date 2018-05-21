//
//  ViewController.swift
//  Borders
//
//  Created by Young Kim on 2018-05-20.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    let viewModel = CountryListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Countries in EU"
        
        self.viewModel.countryList()
            .bind(to: self.tableView.rx.items) {
                (tableView: UITableView, index: Int, element: [String : String]) in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                cell.textLabel?.text = element["Code"] ?? ""
                cell.detailTextLabel?.text = element["Name"] ?? ""
                
                return cell
            }
            .disposed(by: self.disposeBag)
        
        tableView.rx.modelSelected([String : String].self)
            .subscribe(onNext:  { country in
                if let countryCode = country["Code"] {
                    self.viewModel.countryInfoFlow(code: countryCode)
                        .observeOn(MainScheduler.instance)
                        .subscribe(onNext: { [unowned self] response in
                            switch response {
                            case .success(let borders):
                                var bordersViewModel = BordersViewModel()
                                bordersViewModel.countryName = country["Name"] ?? ""
                                bordersViewModel.borderCountries.accept(borders)
                                self.performSegue(withIdentifier: "bordersVCSegue", sender: bordersViewModel)
                                break
                            default:
                                break
                            }
                        }).disposed(by: self.disposeBag)
                }
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bordersVCSegue" {
            if let vc = segue.destination as? BordersViewController, let viewModel = sender as? BordersViewModel {
                vc.viewModel = viewModel
            }
        }
    }
}

