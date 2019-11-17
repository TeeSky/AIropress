//
//  BrewDoneViewController.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import UIKit

class BrewDoneViewController: BaseViewController<BrewDoneSceneView> {

    var viewModel: BrewDoneVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.configure(tableView: sceneView.tableView)

        sceneView.tableView.dataSource = self
        sceneView.tableView.delegate = self

        sceneView.bottomButton.addTarget(
            viewModel,
            action: #selector(viewModel.onMakeAnotherTapped),
            for: .touchUpInside
        )
        sceneView.rateSwitch.addTarget(
            self,
            action: #selector(onRateSwitched(_:)),
            for: .valueChanged
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        sceneView.tableView.isHidden = true
        sceneView.rateSwitchContainer.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.33) { [weak self] in
                self?.sceneView.rateSwitchContainer.alpha = 100
            }
        }
    }

    @objc
    func onRateSwitched(_ sender: UISwitch) {
        let shouldShowRateTableView = sender.isOn

        sceneView.setRateOn(shouldShowRateTableView)
    }
}

extension BrewDoneViewController: UITableViewDataSource {

    func numberOfSections(in _: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = viewModel.cellViewModel(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.identifier, for: indexPath)

        guard let baseTableCell = cell as? ConfigurableTableCell else {
            fatalError("All table view cell classes must implement ConfigurableTableCell.")
        }
        baseTableCell.configure(viewModel: cellVM)

        return cell
    }
}

extension BrewDoneViewController: UITableViewDelegate {

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellHeight(for: indexPath)
    }
}
