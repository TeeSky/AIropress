//
//  BrewingVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 15/04/2021.
//  Copyright © 2021 Tomas Skypala. All rights reserved.
//

import Foundation
import RxSwift

class BrewingVM: BaseViewModel {

    weak var flowController: BrewingSceneFC?

    // MARK: - Observables

    let mainTimerText: BehaviorSubject<String>
    let currentPhaseTimerText = BehaviorSubject<String?>(value: nil)
    let phaseTexts: BehaviorSubject<[PhaseTextSet]>

    // MARK: - Internal Props

    private var currentBrewPhaseTimer: BrewTiming?
    private var remainingSeconds: Double

    // MARK: - Dependencies

    private let allBrewPhases: [BrewPhase]
    private let brewTimerType: BrewTiming.Type

    private let disposeBag = DisposeBag()

    // MARK: - Init

    init(brewPhases: [BrewPhase], timerType: BrewTiming.Type = BrewingTimer.self) {

        allBrewPhases = brewPhases
        brewTimerType = timerType

        remainingSeconds = allBrewPhases.map(\.duration).reduce(0, +)
        mainTimerText = .init(value: remainingSeconds.asStopwatchString())
        phaseTexts = .init(value: [])
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

        let brewPhaseDuration = Int(allBrewPhases[brewPhaseIndex].duration)
        let timer = brewTimerType.init(brewPhaseDuration: brewPhaseDuration, autostart: false)

        timer.elapsedSeconds
            .subscribe(
                onNext: { [weak self] seconds in
                    self?.brewPhaseTimerDidTick(elapsedSeconds: seconds, brewPhaseDuration: brewPhaseDuration)
                },
                onError: nil,
                onCompleted: { [weak self] in
                    self?.brewPhaseTimerDidFinish(brewPhaseIndex: brewPhaseIndex)
                },
                onDisposed: nil
            )
            .disposed(by: disposeBag)

        currentBrewPhaseTimer = timer
        phaseTexts.onNext(Self.makePhaseTexts(startIndex: brewPhaseIndex, allBrewPhases: allBrewPhases))
        timer.isRunning.onNext(true)
    }

    private func brewPhaseTimerDidTick(elapsedSeconds: Int, brewPhaseDuration: Int) {
        guard elapsedSeconds > 0 else { return }

        currentPhaseTimerText.onNext(Double(brewPhaseDuration - elapsedSeconds).asStopwatchString())

        remainingSeconds -= 1
        mainTimerText.onNext(remainingSeconds.asStopwatchString())
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
        mainTimerText.onNext(0.asStopwatchString())
        currentPhaseTimerText.onNext(nil)
        phaseTexts.onNext([])

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
