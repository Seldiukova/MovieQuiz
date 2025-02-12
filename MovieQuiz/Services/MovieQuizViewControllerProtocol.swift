//
//  MovieQuizControllerProtocol.swift
//  MovieQuiz
//
//  Created by Ирина  Сельдюкова on 2/12/25.
//

import Foundation

protocol MovieQuizViewControllerProtocol {
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func highlightImageBorder(isCorrectAnswer: Bool)
    func hideImageBorder()
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
}
