//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Ирина  Сельдюкова on 1/21/25.
//

import Foundation


protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)    
}
