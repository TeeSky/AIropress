//
//  BrewingVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 15/04/2021.
//  Copyright © 2021 Tomas Skypala. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class BrewingVM: BaseViewModel {

    weak var flowController: BrewingSceneFC?

    // MARK: - Observables

    let mainTimerTextDriver: Driver<String>
    let currentPhaseTimerTextDriver: Driver<String?>

    private(set) lazy var phaseTextsDriver: Driver<[PhaseTextSet]> = currentBrewPhaseIndex
        .asDriver()
        .map({ [weak self] in Self.makePhaseTexts(startIndex: $0, allBrewPhases: self?.allBrewPhases ?? [])})

    // MARK: - Internal Props

    private var currentBrewPhaseTimer: BrewTiming?

    private let currentBrewPhaseIndex = BehaviorRelay<Int>(value: 0)
    private let remainingSeconds: BehaviorRelay<Double>
    private let brewPhaseRemainingSeconds: BehaviorRelay<Double>

    // MARK: - Dependencies

    private let allBrewPhases: [BrewPhase]
    private let brewTimerType: BrewTiming.Type

    private let disposeBag = DisposeBag()

    // MARK: - Init

    init(brewPhases: [BrewPhase], timerType: BrewTiming.Type = BrewingTimer.self) {

        allBrewPhases = brewPhases
        brewTimerType = timerType

        remainingSeconds = .init(value: allBrewPhases.map(\.duration).reduce(0, +))
        mainTimerTextDriver = remainingSeconds
            .asDriver()
            .map({ $0.asStopwatchString() })

        brewPhaseRemainingSeconds = .init(value: brewPhases.first?.duration ?? 0)
        currentPhaseTimerTextDriver = brewPhaseRemainingSeconds
            .asDriver()
            .map({ $0.asStopwatchString() })
    }

    // MARK: - Handling

    func viewDidAppear() {
        initiateBrewPhase(withIndex: 0)
    }

    func stopTapped() {

        currentBrewPhaseTimer?.invalidate()
        flowController?.onBrewStopped()
    }

    // MARK: - Brew Handling Helpers

    private func initiateBrewPhase(withIndex brewPhaseIndex: Int) {
        currentBrewPhaseIndex.accept(brewPhaseIndex)
        let brewPhaseDuration = Int(allBrewPhases[brewPhaseIndex].duration)
        let timer = brewTimerType.init(brewPhaseDuration: brewPhaseDuration)

        timer.elapsedSeconds
            .subscribe(
                onNext: { [weak self] seconds in
                    self?.brewPhaseTimerDidTick(elapsedSeconds: seconds, brewPhaseDuration: brewPhaseDuration)
                },
                onCompleted: { [weak self] in
                    self?.brewPhaseTimerDidFinish(brewPhaseIndex: brewPhaseIndex)
                }
            )
            .disposed(by: disposeBag)

        currentBrewPhaseTimer = timer
        timer.isRunning.onNext(true)
    }

    private func brewPhaseTimerDidTick(elapsedSeconds: Int, brewPhaseDuration: Int) {
        guard elapsedSeconds > 0 else { return }

        brewPhaseRemainingSeconds.accept(Double(brewPhaseDuration - elapsedSeconds))
        remainingSeconds.accept(remainingSeconds.value - 1)
    }

    private func brewPhaseTimerDidFinish(brewPhaseIndex: Int) {
        let nextBrewPhaseIndex = brewPhaseIndex + 1
        guard nextBrewPhaseIndex < allBrewPhases.count else {
            brewDidFinish()
            return
        }

        initiateBrewPhase(withIndex: nextBrewPhaseIndex)
    }

    private func brewDidFinish() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.flowController?.onBrewFinished()
        }
    }

    private static func makePhaseTexts(startIndex: Int = 0, allBrewPhases: [BrewPhase]) -> [PhaseTextSet] {
        let endIndex = min(startIndex + 2, allBrewPhases.count - 1)

        let nextBrewPhases = Array(allBrewPhases[startIndex ... endIndex])
        return nextBrewPhases.map(PhaseTextSet.init(brewPhase:))
    }
}
