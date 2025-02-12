//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Ирина  Сельдюкова on 1/21/25.
//

import Foundation


 protocol QuestionFactoryDelegate {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error) 
}
