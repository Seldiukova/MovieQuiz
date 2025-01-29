import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {

    @IBOutlet private weak var yesButton: UIButton!

    @IBOutlet private weak var noButton: UIButton!

    @IBOutlet private weak var imageView: UIImageView!

    @IBOutlet private weak var textLabel: UILabel!

    @IBOutlet private weak var counterLabel: UILabel!

    private var currentQuestionIndex = 0

    private var correctAnswers = 0

    private let questionsAmount: Int = 10
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?

    private var alertPresenter: AlertPresenter?
    
    private let statisticService: StatisticServiceProtocol = StatisticService()

    override func viewDidLoad() {
        yesButton.layer.cornerRadius = 15
        noButton.layer.cornerRadius = 15
        imageView.layer.cornerRadius = 20

        super.viewDidLoad()

        let questionFactory = QuestionFactory()
        questionFactory.setup(delegate: self)
        self.questionFactory = questionFactory

        questionFactory.requestNextQuestion()

        let alertPresenter = AlertPresenter()
        alertPresenter.setup(delegate: self)
        self.alertPresenter = alertPresenter
    }

    // MARK: - QuestionFactoryDelegate

    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }

        currentQuestion = question
        let viewModel = convert(model: question)

        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }

    // приватный метод, который меняет цвет рамки
    // принимает на вход булевое значение и ничего не возвращает
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        }

        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor =
            isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.imageView.layer.borderWidth = 0

            self.showNextQuestionOrResults()
        }
    }

    // приватный метод конвертации, который принимает моковый вопрос и возвращает вью модель для главного экрана
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
        return questionStep
    }

    // приватный метод вывода на экран вопроса, который принимает на вход вью модель вопроса и ничего не возвращает
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }

    private func show(quiz result: QuizResultsViewModel) {
        let alert = AlertModel(
            title: result.title,
            message: result.text,
            buttonText: result.buttonText
        ) {
            self.currentQuestionIndex = 0
            self.correctAnswers = 0
            // заново показываем первый вопрос
            self.questionFactory?.requestNextQuestion()
        }

        alertPresenter?.show(alert: alert)

    }

    // приватный метод, который содержит логику перехода в один из сценариев
    // метод ничего не принимает и ничего не возвращает
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
            statisticService.store(correct: correctAnswers, total: questionsAmount)
            
            let text = "Ваш результат: \(correctAnswers)/10\nКоличество сыгранных квизов: \(statisticService.gamesCount)\nРекорд: \(statisticService.bestGame.correct)/10 (\(statisticService.bestGame.date.dateTimeString))\nСредняя точность: \(String(format: "%.2f", statisticService.totalAccuracy))%"
            
            
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            
            show(quiz: viewModel)
        } else {
            currentQuestionIndex += 1
            self.questionFactory?.requestNextQuestion()
        }

    }

    // метод вызывается, когда пользователь нажимает на кнопку "Да"
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = true

        showAnswerResult(
            isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }

    // метод вызывается, когда пользователь нажимает на кнопку "Нет"
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = false

        showAnswerResult(
            isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }

}

