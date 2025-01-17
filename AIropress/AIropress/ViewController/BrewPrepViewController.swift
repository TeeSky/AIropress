//
//  BrewPrepViewController.swift
//  AIropress
//
//  Created by Tomas Skypala on 30/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class BrewPrepViewController: BaseViewController<BrewPrepSceneView> {

    var viewModel: BrewPrepVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.configure(tableView: sceneView.tableView)

        sceneView.tableView.dataSource = self
        sceneView.tableView.delegate = self

        sceneView.brewButton.addTarget(viewModel, action: #selector(viewModel.onBrewClicked), for: .touchUpInside)
        sceneView.resetButton.addTarget(viewModel, action: #selector(viewModel.onResetClicked), for: .touchUpInside)
    }
}

extension BrewPrepViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

extension BrewPrepViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellHeight(for: indexPath)
    }
}
