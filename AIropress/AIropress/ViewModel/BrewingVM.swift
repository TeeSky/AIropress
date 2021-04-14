//
//  BrewingVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

protocol BrewingVMDelegate: AnyObject {
    func setTimerTexts(mainTimerText: String, currentPhaseTimerText: String?)
    func setPhaseTexts(textSets: [PhaseTextSet])
}

class BrewingVM: BaseViewModel, BrewPhaseTimerDelegate {

    weak var delegate: BrewingVMDelegate?
    weak var flowController: BrewingSceneFC?

    private(set) var completedPhasesDuration: Double
    private(set) var currentTotalTicks: Int
    private(set) var currentBrewPhaseIndex: Int
    private(set) var currentBrewPhaseTimer: BrewPhaseTimer?
    private(set) var brewFinished: Bool

    private lazy var totalBrewTime: Double = allBrewPhases.map(\.duration).reduce(0, +)

    var phaseTexts: [PhaseTextSet] {
        let startIndex = currentBrewPhaseIndex
        let endIndex = min(startIndex + 2, allBrewPhases.count - 1)

        let nextBrewPhases = Array(allBrewPhases[startIndex ... endIndex])
        return nextBrewPhases.map(PhaseTextSet.init(brewPhase:))
    }

    private let allBrewPhases: [BrewPhase]
    private let brewTimerType: BrewPhaseTimer.Type

    init(brewPhases: [BrewPhase], startPhaseIndex: Int = 0, timerType: BrewPhaseTimer.Type = BrewPhaseTimer.self) {

        allBrewPhases = brewPhases

        completedPhasesDuration = 0
        currentTotalTicks = 0
        brewFinished = false
        currentBrewPhaseIndex = startPhaseIndex
        brewTimerType = timerType
    }

    @objc
    func onStopClicked() {
        guard !brewFinished else { return }

        currentBrewPhaseTimer?.invalidate()
        flowController?.onBrewStopped()
    }

    func onSceneDidAppear() {
        initiateBrewPhase()
    }

    internal func onPhaseTick(remainingSeconds: Double) {
        currentTotalTicks += 1

        let totalRemainingSeconds = (totalBrewTime - Double(currentTotalTicks) -
            completedPhasesDuration).rounded(.towardZero)
        let mainTimerText = totalRemainingSeconds.asStopwatchString()

        let phaseTimerText = remainingSeconds.asStopwatchString()

        delegate?.setTimerTexts(mainTimerText: mainTimerText, currentPhaseTimerText: phaseTimerText)
    }

    internal func onPhaseEnd() {
        completedPhasesDuration += allBrewPhases[currentBrewPhaseIndex].duration
        currentBrewPhaseIndex += 1
        guard currentBrewPhaseIndex < allBrewPhases.count else {
            onBrewFinished()
            return
        }

        initiateBrewPhase()
    }

    private func initiateBrewPhase() {
        delegate?.setTimerTexts(
            mainTimerText: (totalBrewTime - completedPhasesDuration).asStopwatchString(),
            currentPhaseTimerText: nil
        )
        delegate?.setPhaseTexts(textSets: phaseTexts)

        currentTotalTicks = 0
        currentBrewPhaseTimer = brewTimerType.init(
            brewPhase: allBrewPhases[currentBrewPhaseIndex],
            delegate: self
        )
    }

    private func onBrewFinished() {
        brewFinished = true
        delegate?.setTimerTexts(mainTimerText: 0.asStopwatchString(), currentPhaseTimerText: nil)
        delegate?.setPhaseTexts(textSets: [])

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.flowController?.onBrewFinished()
        }
    }
}
