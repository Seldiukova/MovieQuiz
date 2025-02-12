//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Ирина  Сельдюкова on 1/28/25.
//

import Foundation

protocol StatisticServiceProtocol {
    var gamesCount: Int { get }
    var bestGame: GameResult { get }
    var totalAccuracy: Double { get }
    
    func store(correct count: Int, total amount: Int)
}
