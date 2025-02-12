//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Ирина  Сельдюкова on 1/24/25.
//

import UIKit

final class AlertPresenter {

    weak var delegate: MovieQuizViewController!

    init(viewController: MovieQuizViewController) {
        delegate = viewController
    }

    func show(alert model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)

        alert.view.accessibilityIdentifier = "Game results"

        let action = UIAlertAction(
            title: model.buttonText,
            style: .default
        ) { _ in
            model.completion()
        }

        alert.addAction(action)

        delegate?.present(alert, animated: true, completion: nil)
    }
}
