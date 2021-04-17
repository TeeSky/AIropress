//
//  BrewingTimer.swift
//  AIropress
//
//  Created by Tomáš Skýpala on 15.04.2021.
//  Copyright © 2021 Tomas Skypala. All rights reserved.
//

import RxSwift
import RxCocoa

protocol BrewTiming {

    var elapsedSeconds: BehaviorSubject<Int> { get }
    var isRunning: BehaviorSubject<Bool> { get }

    init(brewPhaseDuration: Double, autostart: Bool)

    func invalidate()
}

final class BrewingTimer: BrewTiming {

    let elapsedSeconds = BehaviorSubject<Int>(value: 0)
    let isRunning = BehaviorSubject<Bool>(value: false)

    private let brewPhaseDuration: Double

    private let disposeBag = DisposeBag()

    init(brewPhaseDuration: Double, autostart: Bool) {
        self.brewPhaseDuration = brewPhaseDuration

        isRunning
            .asObservable()
            .flatMapLatest { isRunning -> Observable<Int> in
                guard isRunning else { return .empty() }

                return .interval(.seconds(1), scheduler: MainScheduler.instance)
            }
            .take(until: { $0 == Int(brewPhaseDuration - 1) }, behavior: .inclusive)
            .map { $0 + 1 }
            .subscribe(elapsedSeconds)
            .disposed(by: disposeBag)

        if autostart {
            isRunning.onNext(true)
        }
    }

    func invalidate() {
        isRunning.onNext(false)
    }
}
