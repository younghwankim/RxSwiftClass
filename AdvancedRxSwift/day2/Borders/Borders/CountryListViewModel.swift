//
//  CountryListViewModel.swift
//  Borders
//
//  Created by Young Kim on 2018-05-21.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import RxSwift
import RxCocoa

struct CountryListViewModel {

    func countryList() -> Observable<[[String : String]]> {
        return BordersBusinessLogic.shared.countryList()
    }
    
    func countryInfoFlow(code: String) -> Observable<Result<CountriesDto, String>> {
        return BordersBusinessLogic.shared.countryInfoFlow(code: code)
    }
    
}
