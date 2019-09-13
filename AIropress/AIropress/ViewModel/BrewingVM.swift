//
//  BrewingVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

protocol BrewingVMDelegate: class {
    func setTimerTexts(mainTimerText: String, currentPhaseTimerText: String)
    func setPhaseTexts(textSets: [PhaseTextSet])
}

class BrewingVM: BaseViewModel {
    
    private(set) var currentTotalTicks: Int
    private(set) var currentBrewPhaseIndex: Int
    private(set) var currentBrewPhaseTimer: BrewPhaseTimer?
    
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
        self.currentTotalTicks = 0
        self.currentBrewPhaseIndex = startPhaseIndex
        self.brewPhases = brewPhases
        self.brewTimerType = timerType
    }
    
    func onResetClicked() {
        flowController?.onRecipeReset()
    }
    
    func onSceneDidAppear() {
        initiateBrewPhase()
    }
    
    private func onPhaseTick(remainingSeconds: Double) {
        currentTotalTicks += 1
        
        let totalRemainingSeconds = (totalBrewTime - Double(currentTotalTicks)).rounded(.towardZero)
        let mainTimerText = totalRemainingSeconds.asStopwatchString()
        
        let phaseTimerText = remainingSeconds.asStopwatchString()
        
        delegate?.setTimerTexts(mainTimerText: mainTimerText, currentPhaseTimerText: phaseTimerText)
    }
    
    private func onPhaseEnd() {
        currentBrewPhaseIndex += 1
        guard currentBrewPhaseIndex < brewPhases.count else {
            flowController?.onBrewFinished()
            return
        }
        
        initiateBrewPhase()
    }
    
    private func initiateBrewPhase() {
        delegate?.setPhaseTexts(textSets: nextPhaseTexts)
        
        currentTotalTicks = 0
        currentBrewPhaseTimer = brewTimerType.init(brewPhase: brewPhases[currentBrewPhaseIndex],
                                                   tickDelegate: onPhaseTick, phaseEndDelegate: onPhaseEnd)
    }
}
