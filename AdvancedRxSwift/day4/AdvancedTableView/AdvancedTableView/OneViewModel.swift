//
//  OneViewModel.swift
//  AdvancedTableView
//
//  Created by Young Kim on 2018-05-26.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class OneViewModel: NSObject {
    let disposeBag = DisposeBag()
    var products:BehaviorRelay<[SectionModel<(String, String), Int>]> = BehaviorRelay(value:[])
    var productDataSource:Observable<[SectionModel<(String, String), Int>]>!
    var defaultText = ""
    
    override init() {
        self.productDataSource = products.asObservable()
    }
    
    func updateProduct(seed: Int) {
        var productList:[SectionModel<(String, String), Int>] = []
        
        let sectionModelOne = SectionModel<(String, String), Int>(model: ("One",""), items: [seed,seed + 2, seed + 4])
        let sectionModelTwo = SectionModel<(String, String), Int>(model: ("Two",""), items: [seed + 1,seed + 3, seed + 5])
        productList = [sectionModelOne, sectionModelTwo]
        
        self.products.accept(productList)
    }
}
