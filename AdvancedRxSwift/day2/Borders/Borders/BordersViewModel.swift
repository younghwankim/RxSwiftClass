//
//  BordersViewModel.swift
//  Borders
//
//  Created by Young Kim on 2018-05-21.
//  Copyright © 2018 Young Kim. All rights reserved.
//


import RxSwift
import RxCocoa

struct BordersViewModel {
    var countryName = ""
    var borderCountries = BehaviorRelay(value: CountriesDto())
    
}
