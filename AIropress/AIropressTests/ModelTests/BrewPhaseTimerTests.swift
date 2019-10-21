//
//  BrewPhaseTimerTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 11/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class MockTimer: Timer {

    var interval: TimeInterval!
    var repeats: Bool!
    var block: ((Timer) -> Void)!

    var invalidated: Bool = false

    static var timers: [MockTimer] = []

    override func fire() {
        block(self)
    }

    override func invalidate() {
        invalidated = true
    }

    override open class func scheduledTimer(withTimeInterval interval: TimeInterval,
                                            repeats: Bool,
                                            block: @escaping (Timer) -> Void) -> Timer {
        let timer = MockTimer()
        timer.interval = interval
        timer.repeats = repeats
        timer.block = block

        MockTimer.timers.append(timer)

        return timer
    }
}

class MockTimerDelegate: BrewPhaseTimerDelegate {

    var onTickValue: Double?
    var phaseEnded: Bool?

    func onPhaseTick(remainingSeconds: Double) {
        onTickValue = remainingSeconds
    }

    func onPhaseEnd() {
        phaseEnded = true
    }
}

class BrewPhaseTimerTests: XCTestCase {

    var brewPhase: BrewPhase!
    // swiftlint:disable:next weak_delegate
    var timerDelegate: MockTimerDelegate!

    var brewPhaseTimer: BrewPhaseTimer!

    override func setUp() {
        super.setUp()

        brewPhase = BrewPhase(duration: 5.5, label: "Wait.")
        timerDelegate = MockTimerDelegate()

        brewPhaseTimer = BrewPhaseTimer(brewPhase: brewPhase,
                                        delegate: timerDelegate,
                                        timerProvider: MockTimer.self)
    }

    func testPhaseTimer() {
        let expectedPhaseTimerInterval = brewPhase.duration
        let expectedRepeats = false

        let phaseTimer = MockTimer.timers[0]

        XCTAssertEqual(expectedPhaseTimerInterval, phaseTimer.interval)
        XCTAssertEqual(expectedRepeats, phaseTimer.repeats)
    }

    func testTickTimer() {
        let expectedTickTimerInterval = BrewPhaseTimer.tickDuration
        let expectedRepeats = true

        let tickTimer = MockTimer.timers[1]

        XCTAssertEqual(expectedTickTimerInterval, tickTimer.interval)
        XCTAssertEqual(expectedRepeats, tickTimer.repeats)
    }

    func testInvalidate() {
        brewPhaseTimer.invalidate()

        let phaseTimer = MockTimer.timers[0]
        let tickTimer = MockTimer.timers[1]
        XCTAssertTrue(phaseTimer.invalidated)
        XCTAssertTrue(tickTimer.invalidated)
    }

    func testOnPhaseEnd() {
        let phaseTimer = MockTimer.timers[0]

        phaseTimer.fire()

        XCTAssertTrue(timerDelegate.phaseEnded ?? false)

        let tickTimer = MockTimer.timers[1]
        XCTAssertTrue(phaseTimer.invalidated)
        XCTAssertTrue(tickTimer.invalidated)
    }

    func testOnTick() {
        let expectedCurrentTick = brewPhaseTimer.currentTick + 1
        let expectedTickValue = brewPhase.duration -
            (BrewPhaseTimer.tickDuration * Double(expectedCurrentTick))
        let tickTimer = MockTimer.timers[1]

        tickTimer.fire()

        XCTAssertEqual(expectedCurrentTick, brewPhaseTimer.currentTick)
        XCTAssertEqual(expectedTickValue, timerDelegate.onTickValue)
    }

    override func tearDown() {
        super.tearDown()

        MockTimer.timers.removeAll()
    }
}
