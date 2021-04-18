//
//  BrewingTimer.swift
//  AIropress
//
//  Created by Tomáš Skýpala on 15.04.2021.
//  Copyright © 2021 Tomas Skypala. All rights reserved.
//

import RxSwift

protocol BrewTiming {

    var elapsedSeconds: BehaviorSubject<Int> { get }
    var isRunning: BehaviorSubject<Bool> { get }

    init(brewPhaseDuration: Int)

    func invalidate()
}

final class BrewingTimer: BrewTiming {

    let elapsedSeconds = BehaviorSubject<Int>(value: 0)
    let isRunning = BehaviorSubject<Bool>(value: false)

    private let brewPhaseDuration: Int

    private let disposeBag = DisposeBag()

    init(brewPhaseDuration: Int) {
        self.brewPhaseDuration = brewPhaseDuration

        isRunning
            .asObservable()
            .flatMapLatest { isRunning -> Observable<Int> in
                guard isRunning else { return .empty() }

                return .interval(.seconds(1), scheduler: MainScheduler.instance)
            }
            .take(until: { $0 == brewPhaseDuration - 1 }, behavior: .inclusive)
            .map { $0 + 1 }
            .subscribe(elapsedSeconds)
            .disposed(by: disposeBag)
    }

    func invalidate() {
        isRunning.onNext(false)
    }
}
