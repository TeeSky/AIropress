//
//  BrewingVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

protocol BrewingVMDelegate: class {
    func setTimerTexts(mainTimerText: String, currentPhaseTimerText: String?)
    func setPhaseTexts(textSets: [PhaseTextSet])
}

class BrewingVM: BaseViewModel, BrewPhaseTimerDelegate {

    private(set) var completedPhasesDuration: Double
    private(set) var currentTotalTicks: Int
    private(set) var currentBrewPhaseIndex: Int
    private(set) var currentBrewPhaseTimer: BrewPhaseTimer?
    private(set) var brewFinished: Bool

    lazy var totalBrewTime: Double = {
        return brewPhases.map({ $0.duration }).reduce(0, +)
    }()

    var nextPhaseTexts: [PhaseTextSet] {
        let startIndex = currentBrewPhaseIndex
        let endIndex = min(startIndex + 2, brewPhases.count - 1)

        let nextBrewPhases = Array(brewPhases[startIndex...endIndex])
        return nextBrewPhases.map { PhaseTextSet(labelText: $0.label, timerText: $0.duration.asStopwatchString())}
    }

    let brewPhases: [BrewPhase]
    let brewTimerType: BrewPhaseTimer.Type

    weak var delegate: BrewingVMDelegate?
    weak var flowController: BrewingSceneFC?

    init(brewPhases: [BrewPhase], startPhaseIndex: Int = 0, timerType: BrewPhaseTimer.Type = BrewPhaseTimer.self) {
        self.completedPhasesDuration = 0
        self.currentTotalTicks = 0
        self.brewFinished = false
        self.currentBrewPhaseIndex = startPhaseIndex
        self.brewPhases = brewPhases
        self.brewTimerType = timerType
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
        completedPhasesDuration += brewPhases[currentBrewPhaseIndex].duration
        currentBrewPhaseIndex += 1
        guard currentBrewPhaseIndex < brewPhases.count else {
            onBrewFinished()
            return
        }

        initiateBrewPhase()
    }

    private func initiateBrewPhase() {
        delegate?.setTimerTexts(mainTimerText: (totalBrewTime - completedPhasesDuration).asStopwatchString(),
                                currentPhaseTimerText: nil)
        delegate?.setPhaseTexts(textSets: nextPhaseTexts)

        currentTotalTicks = 0
        currentBrewPhaseTimer = brewTimerType.init(brewPhase: brewPhases[currentBrewPhaseIndex],
                                                   delegate: self)
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
