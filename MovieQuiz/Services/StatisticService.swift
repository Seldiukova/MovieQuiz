//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Ирина  Сельдюкова on 1/28/25.
//

import Foundation

final class StatisticService: StatisticServiceProtocol {
    private let storage: UserDefaults = .standard

    private enum Keys: String {
        case correctAnswers
        case gamesCount

        enum bestGame: String {
            case correct
            case total
            case date
        }
    }

    var gamesCount: Int {
        get {
            return storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }

    var bestGame: GameResult {
        get {
            let correct = storage.integer(
                forKey: Keys.bestGame.correct.rawValue)
            let total = storage.integer(forKey: Keys.bestGame.total.rawValue)
            let date =
                storage.object(forKey: Keys.bestGame.date.rawValue) as? Date
                ?? Date()

            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(
                newValue.correct, forKey: Keys.bestGame.correct.rawValue)
            storage.set(newValue.total, forKey: Keys.bestGame.total.rawValue)
            storage.set(newValue.date, forKey: Keys.bestGame.date.rawValue)
        }
    }

    var totalAccuracy: Double {
        if bestGame.total == 0 {
            return 0
        }
        return Double(correctAnswers) / (10 * Double(gamesCount)) * 100
    }

    private var correctAnswers: Int {
        get {
            return storage.integer(forKey: Keys.correctAnswers.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.correctAnswers.rawValue)
        }
    }

    func store(correct count: Int, total amount: Int) {
        gamesCount += 1
        correctAnswers += count

        let currentGame = GameResult(
            correct: count, total: amount, date: Date())

        if currentGame.isBetterThan(bestGame) {
            bestGame = currentGame
        }
    }
}
