//
//  GameResults.swift
//  MovieQuiz
//
//  Created by Ирина  Сельдюкова on 1/28/25.
//

import Foundation

struct GameResult {
    let correct: Int
    let total: Int
    let date: Date

    func isBetterThan(_ another: GameResult) -> Bool {
        correct > another.correct
    }
}
