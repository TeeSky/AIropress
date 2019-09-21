//
//  BrewPhaseTimer.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

protocol BrewPhaseTimerDelegate: class {
    func onPhaseEnd()
    func onPhaseTick(remainingSeconds: Double)
}

class BrewPhaseTimer {
    typealias TickDelegate = (Double) -> Void
    typealias PhaseEndDelegate = () -> Void

    static let tickDuration = 1.0

    let phaseDuration: Double

    private(set) var currentTick: Int

    var phaseTimer: Timer!
    var tickTimer: Timer!

    weak var delegate: BrewPhaseTimerDelegate?

    required init(brewPhase: BrewPhase, delegate: BrewPhaseTimerDelegate, autostartTimers: Bool = true,
                  timerProvider: Timer.Type = Timer.self) {
        self.currentTick = 0
        self.phaseDuration = brewPhase.duration
        self.delegate = delegate

        if autostartTimers { startTimers(provider: timerProvider) }
    }

    func startTimers(provider: Timer.Type) {
        self.phaseTimer = provider.scheduledTimer(withTimeInterval: phaseDuration,
                                                  repeats: false, block: onPhaseEnd)
        self.tickTimer = provider.scheduledTimer(withTimeInterval: BrewPhaseTimer.tickDuration,
                                                 repeats: true, block: onTick)
    }

    private func onPhaseEnd(timer: Timer) {
        delegate?.onPhaseEnd()

        self.invalidate()
    }

    private func onTick(timer: Timer) {
        currentTick += 1

        delegate?.onPhaseTick(remainingSeconds: phaseDuration - (Double(currentTick) * BrewPhaseTimer.tickDuration))
    }

    func invalidate() {
        phaseTimer.invalidate()
        tickTimer.invalidate()
    }
}
