//
//  BordersTests.swift
//  BordersTests
//
//  Created by Young Kim on 2018-05-26.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import Borders

class BordersTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBlocking() {
        let scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        
        let toArrayObservable = Observable<Int>.create { observer in
            observer.onNext(7)
            observer.onNext(8)
            observer.onNext(9)
            observer.onCompleted()
            
            return Disposables.create()
            }
            .delay(3, scheduler: scheduler)
        
        XCTAssertEqual(try! toArrayObservable.toBlocking().toArray(), [7,8,9])
    }
    
    
    func testCountryInfoFlow() {
        let scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        
        do {
            let myArray = try BordersBusinessLogic.shared.countryInfoFlow(code: "FRA")
            .subscribeOn(scheduler)
            .toBlocking()
            .toArray()
            
            if let countryInfo = myArray.first {
                switch countryInfo {
                case .success(_):
                    XCTAssert(true)
                    break
                case .failure(_):
                    XCTAssert(false)
                    break
                }
            }
        } catch(let e) {
            XCTAssert(false, e.localizedDescription)
        }
    }

    func testCornSorter() {
        var scheduler: TestScheduler!
        let disposeBag = DisposeBag()
        
        scheduler = TestScheduler(initialClock: 0)
        
        let testObserver = scheduler.createObserver(String.self)
        
        // Given
        let observableInput = scheduler.createHotObservable([
            // 2
            Recorded.next(100, "🌽"),
            Recorded.next(200, "🐛"),
            Recorded.next(300, "🐭"),
            Recorded.next(400, "🌽"),
            Recorded.next(500, "🐝"),
            Recorded.next(600, "🐞")
            ])
        let cornSorter = CornSorter(tractorStream: observableInput.asObservable())
        
        // When
        cornSorter.barnStream
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // Then
        let results = testObserver.events.map {
            $0.value.element!
        }
        _ = XCTAssertEqual(results, ["🌽", "🌽"])
    }
    
    func testElements() {
        let items = Observable.of(1, 5, 10, 15, 20)
        
        let elements = try! items.toBlocking().toArray()
        XCTAssertEqual([1, 5, 10, 15, 20], elements)
        
        let results = try! items.skip(3).take(2).toBlocking().toArray()
        XCTAssertEqual([15, 20], results)
        
    }
}


struct CornSorter {
    let barnStream: Observable<String>
    
    init(tractorStream: Observable<String>) {
        barnStream = tractorStream
            .filter { $0 == "🌽" }
    }
}

