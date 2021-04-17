//
//  BrewingViewController.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import RxSwift
import RxCocoa

class BrewingViewController: BaseViewController<BrewingSceneView> {

    var viewModel: BrewingVM!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.stopButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.stopTapped()
            })
            .disposed(by: disposeBag)

        viewModel.mainTimerText
            .bind(to: sceneView.mainTimerLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.currentPhaseTimerText
            .bind(to: sceneView.currentPhaseTimerLabel.timerLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.phaseTexts
            .bind(onNext: { [weak self] phaseTexts in
                guard let self = self else { return }

                self.sceneView.currentPhaseTimerLabel.configure(with: phaseTexts[safe: 0])
                self.sceneView.next1TimerLabel.configure(with: phaseTexts[safe: 1])
                self.sceneView.next2TimerLabel.configure(with: phaseTexts[safe: 2])
            })
            .disposed(by: disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.viewDidAppear()
    }
}
