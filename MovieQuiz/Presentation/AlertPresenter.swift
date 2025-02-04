//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Ирина  Сельдюкова on 1/24/25.
//

import Foundation
import UIKit

final class AlertPresenter {

    weak var delegate: MovieQuizViewController?

    func setup(delegate: MovieQuizViewController) {
        self.delegate = delegate
    }
    
    func show(alert model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)

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
