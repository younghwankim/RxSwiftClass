//
//  ViewController.swift
//  SimpleTrackActivity
//
//  Created by Young Kim on 2018-05-24.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var TrackActivityOulet: UIActivityIndicatorView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var trackActivityButton: UIButton!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = SimpleViewModel()
        
        viewModel.signingIn
            .bind(to: TrackActivityOulet.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.signingIn
            .map { !$0 }
            .bind(to: backgroundView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.signingIn
            .bind(to: trackActivityButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        trackActivityButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                viewModel.simpleObservable()
                    .observeOn(MainScheduler.instance)
                    .trackActivity(viewModel.signingInIndicator)
                    .subscribe(onNext: { _ in
                    })
                    .disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

