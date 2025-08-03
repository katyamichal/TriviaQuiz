//
//  QuizViewModel.swift
//  TriviaQuiz
//
//  Created by Катя on 01.08.2025.
//

import Foundation
import Combine

public final class QuizViewModel {
    
    private let service: QuizServiceProtocol
    private let ratingRenderer: RatingRenderer
    
    private var questions: [QuizQuestion]?
    
    var onShowResult: ((ResultConfig) -> Void)?
    var onShowHistory: (() -> Void)?
    var onResetView: (() -> Void)?
    
    // quiz state
    private var correctAnswersCount: Int = 0
    private var currentQuestionIndex: Int = 0
    private var userAnswers: [UserAnswer] = []

    @Published var currentQuestion: QuizQuestion?
    @Published var errorMessage: NSAttributedString? = nil
    @Published private(set) var isLoading: Bool
    @Published private(set) var isNextButtonEnabled: Bool
    
 
    
    init(
         service: QuizServiceProtocol,
         isLoading: Bool = false,
         ratingRenderer: RatingRenderer
    ) {
        self.service = service

        self.isLoading = isLoading
        self.isNextButtonEnabled = false
        self.ratingRenderer = ratingRenderer
    }
    
    func loadQuiz(request: QuizRequest = .default) {
        isLoading = true
        
        Task { [weak self] in
            guard let self = self else { return }
            
            do {
                let response = try await self.service.loadQuizQuestions()
                self.makeQuestions(with: response)
                self.currentQuestion = self.questions?[currentQuestionIndex]
            } catch {
                self.errorMessage = NSAttributedString("Ошибка! Попробуйте еще раз")
            }
            isLoading = false
        }
    }


    
    func handleSelectedOption(_ optionId: String) {
        /// Если есть вопрос и опция с таким id
        guard var question = currentQuestion,
              let index = question.options.firstIndex(where: { $0.id == optionId }) else {
            return
        }
        
        /// Если уже выбрана — ничего не делаем
        if question.options[index].isSelected {
            return
        }

        /// Сбрасываем выбор у всех опций и выбираем нужную
        question.options = question.options.map { option in
            var updatedOption = option
            updatedOption.isSelected = (option.id == optionId)
            return updatedOption
        }
        
        currentQuestion = question
        isNextButtonEnabled = true
    }
    
    func handleNextQuestion() {
        guard let current = currentQuestion else { return }

        if let selected = current.options.first(where: { $0.isSelected }) {
            let isCorrect = selected.title == current.correctAnswer.title
            let userAnswer = UserAnswer(
                question: current.question,
                selectedOption: selected,
                isCorrect: isCorrect
            )
            userAnswers.append(userAnswer)
        }

        currentQuestionIndex += 1
        
        if currentQuestionIndex < questions?.count ?? 0 {
            currentQuestion = questions?[currentQuestionIndex]
            isNextButtonEnabled = false
        } else {
            showResult()
        }
    }
    
    func restart() {
        defer {
            onResetView?()
        }
        correctAnswersCount = 0
        currentQuestionIndex = 0
        userAnswers = []
        currentQuestion = nil
        questions = []
        isNextButtonEnabled = false
        isLoading = false
        currentQuestion = nil
    }
}

private extension QuizViewModel {
    
    func makeQuestions(with response: [Quiz]) {
        self.questions = response.enumerated().map { (index, quiz) in
 
            var options: [QuizOption] = quiz.incorrectAnswers.map {
                QuizOption(id: UUID().uuidString, title: $0, isSelected: false)
            }

            let correctOption = QuizOption(id: UUID().uuidString, title: quiz.correctAnswer, isSelected: false)
            options.append(correctOption)
            options.shuffle()

            return QuizQuestion(
                title: "Вопрос \(index + 1) из \(response.count)",
                question: quiz.question,
                options: options,
                correctAnswer: correctOption
            )
        }
    }
    private func showResult() {
        guard let questions else { return }
        correctAnswersCount = userAnswers.filter { $0.isCorrect }.count
        let ratingImage = ratingRenderer.ratingImage(correctAnswersCount)
        let result = ResultConfig(score: correctAnswersCount, total: questions.count, ratingImage: ratingImage)
        onShowResult?(result)
        
        service.saveQuiz(with: correctAnswersCount)
        
        // отладка
        print("✅ Тест завершён!")
        print("Правильных ответов: \(correctAnswersCount) из \(userAnswers.count)")
        
        for (index, answer) in userAnswers.enumerated() {
            print("""
            Вопрос \(index + 1):
            \(answer.question)
            ➤ Выбранный ответ: \(answer.selectedOption.title)
            \(answer.isCorrect ? "✅ Верно" : "❌ Неверно")
            """)
        }
    }
}
