//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Ирина  Сельдюкова on 1/21/25.
//

import Foundation


protocol QuestionFactoryDelegate {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer() // сообщение об успешной загрузке
    func didFailToLoadData(with error: Error) // сообщение об ошибке загрузки
}
