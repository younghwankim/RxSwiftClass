//
//  BordersBusinessLogic.swift
//  Borders
//
//  Created by Young Kim on 2018-05-21.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

typealias JSONDictionary = [String: Any]

class BordersBusinessLogic {
    
    let disposeBag = DisposeBag()
    static var shared = BordersBusinessLogic()
    
    fileprivate init() {
        
    }
    
    func countryList() -> Observable<[[String : String]]> {
        let countries = [ ["Code" : "GBR", "Name" : "England"],
                          ["Code" : "FRA", "Name" : "France"],
                          ["Code" : "DEU", "Name" : "Germany"],
                          ["Code" : "ITA", "Name" : "Italy"],
                          ["Code" : "ESP", "Name" : "Spain"],
                          ["Code" : "BEL", "Name" : "Belgium"],
                          ["Code" : "LUX", "Name" : "Luxembourg"]]
        return Observable.of(countries)
    }
    
    func countryInfoFlow(code: String) -> Observable<Result<CountriesDto, String>> {
        return Observable.create { observer in
            self.countryInfo(code: code)
                .filter{
                    switch $0 {
                    case .failure(let exception):
                        observer.onNext(.failure(exception))
                        observer.onCompleted()
                        return false
                    case .success(_):
                        return true
                    }
                }
                .map { country -> Array<String> in
                    if let countryDto = country.value, let borders = countryDto.borders {
                        return borders
                    } else {
                        return []
                    }
                }
                .flatMapLatest { [unowned self] borders -> Observable<Result<CountriesDto, String>> in
                    self.countriesInfo(codes: borders)
                }
                .subscribe(onNext: { response in
                    switch response {
                    case .failure(let exception):
                        observer.onNext(.failure(exception))
                        observer.onCompleted()
                        break
                    case .success(let countries):
                        observer.onNext(.success(countries))
                        observer.onCompleted()
                        break
                    }
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func countryInfo(code: String) -> Observable<Result<CountryDto, String>> {
        let urlString = "https://restcountries.eu/rest/v2/alpha/\(code)"
        
        return Observable.create { observer in
            self.contentRequestCall(urlString: urlString)
                .subscribe(onNext: { [unowned self] jsonResult in
                    switch jsonResult {
                    case .success(let jsonData):
                        if let parsedJson = self.parseCountryDto(json: jsonData) {
                            observer.onNext(.success(parsedJson))
                            observer.onCompleted()
                        } else {
                            observer.onNext(.failure(nil))
                            observer.onCompleted()
                        }
                        break
                    case .failure(let exception):
                        if let _exception = exception {
                            observer.onNext(.failure(_exception))
                            observer.onCompleted()
                        } else {
                            observer.onNext(.failure(nil))
                            observer.onCompleted()
                        }
                        break
                    }
                    }, onError: {error in
                        observer.onNext(.failure(nil))
                        observer.onCompleted()
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func countriesInfo(codes: Array<String>) -> Observable<Result<CountriesDto, String>> {
        if codes.count == 0 {
            return Observable<Result<CountriesDto, String>>.just(.failure(nil))
        }
        
        let urlString = "https://restcountries.eu/rest/v2/alpha?codes=\(codes.joined(separator: ";"))"
        return Observable.create { observer in
            self.contentRequestCall(urlString: urlString)
                .subscribe(onNext: { [unowned self] jsonResult in
                    switch jsonResult {
                    case .success(let jsonData):
                        if let parsedJson = self.parseCountriesDto(json: jsonData) {
                            observer.onNext(.success(parsedJson))
                            observer.onCompleted()
                        } else {
                            observer.onNext(.failure(nil))
                            observer.onCompleted()
                        }
                        break
                    case .failure(let exception):
                        if let _exception = exception {
                            observer.onNext(.failure(_exception))
                            observer.onCompleted()
                        } else {
                            observer.onNext(.failure(nil))
                            observer.onCompleted()
                        }
                        break
                    }
                    }, onError: {error in
                        observer.onNext(.failure(nil))
                        observer.onCompleted()
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func parseCountryDto(json: Data) -> CountryDto? {
        do {
            let countryDto = try CountryDto.init(data: json)
            return countryDto
        }catch(let exception){
            print(exception.localizedDescription)
            return nil
        }
    }
    private func parseCountriesDto(json: Data) -> CountriesDto? {
        do {
            let countriesDto = try CountriesDto.init(data: json)
            return countriesDto
        }catch(let exception){
            print(exception.localizedDescription)
            return nil
        }
    }
    
    private func contentURLRequest(urlString: String) -> URLRequest? {
        guard let url = URL(string:urlString) else {
            return nil
        }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 180)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func contentRequestCall(urlString: String) -> Observable<Result<Data, String>> {
        guard let urlRequest = contentURLRequest(urlString: urlString) else {
            return Observable<Result<Data, String>>.just(.failure(nil))
        }
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in                
                guard error == nil, let data = data else {
                    observer.onNext(.failure(error?.localizedDescription))
                    observer.onCompleted()
                    return
                }
                observer.onNext(.success(data))
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create{
                task.cancel()
            }
        }
    }
}
