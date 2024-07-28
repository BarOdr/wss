//
//  NewGameScreen.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 28/07/2024.
//

import Foundation
import SwiftUI

enum GameSetupState: Int, CaseIterable, Identifiable {
    case main
    case chooseWitcher
    case chooseDifficulty
    case summary

    var id: Int {
        rawValue
    }
}

struct GameSetupModel {
    private let witcher: Witcher
    private let difficulty: Difficulty
}

final class GameSetupViewModel: ObservableObject {
    @Published var state: GameSetupState = .main {
        didSet {
            print("Game setup state changed to: \(state)")
        }
    }
    @Published var setupDone: Bool = false

    var chosenWitcher: Witcher? {
        didSet {
            print("Witcher has been chosen and assigned")
        }
    }
    var chosenDifficulty: Difficulty?

    // MARK: - game setup management

    func set(_ witcher: Witcher) {
        chosenWitcher = witcher
        print("Witcher set: \(witcher.rawValue)")
    }

    func set(_ difficulty: Difficulty) {
        chosenDifficulty = difficulty
        print("Difficulty set: \(difficulty)")
    }

    func startGame(witcher: Witcher, difficulty: Difficulty) {
        setupDone = true
    }

    // MARK: - tab view management
    private var previousStep: GameSetupState? {
        guard let currentIndex = GameSetupState.allCases.firstIndex(of: state),
              currentIndex > 0 else { return nil }
        return GameSetupState.allCases[currentIndex - 1]
    }

    private var nextStep: GameSetupState? {
        guard let currentIndex = GameSetupState.allCases.firstIndex(of: state),
              currentIndex < GameSetupState.allCases.count - 1 else { return nil }
        return GameSetupState.allCases[currentIndex + 1]
    }

    func goToNextStep() {
        if let next = nextStep {
            state = next
        }
    }

    func goToPreviousStep() {
        if let previous = previousStep {
            state = previous
        }
    }
}

struct GameSetupView: View {

    @StateObject var viewModel: GameSetupViewModel
    @Namespace private var animationNamespace

    var body: some View {
        ZStack {
            WoodenBackgroundView()
            VStack {
                TabView(selection: customBinding) {
                    ForEach(GameSetupState.allCases) { state in
                        view(for: state)
                            .tag(state)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 0.3), value: viewModel.state)
                .background(Color.clear)
            }
        }
    }

    var customBinding: Binding<GameSetupState> {
        Binding(
            get: {
                viewModel.state
            },
            set: { newValue in
                withAnimation(.easeInOut(duration: 0.3)) {
                    viewModel.state = newValue
                }
            }
        )
    }

    func view(for state: GameSetupState) -> some View {
        switch state {
        case .main:
            let view = Text("Start")
                .onTapGesture {
                    viewModel.goToNextStep()
                }
                .foregroundStyle(.white)
                .font(.witcherHeader(size: 20))
            return AnyView(view)
        case .chooseWitcher:
            return AnyView(chooseWitcherView)
        case .chooseDifficulty:
            return AnyView(chooseDifficultyView)
        case .summary:
            return AnyView(summaryView)
        }
    }

    var chooseWitcherView: some View {
        ChooseWitcherView(witcherChosenBlock: { witcher in
            viewModel.set(witcher)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                viewModel.goToNextStep()
            }
        }, namespace: animationNamespace)
    }

    var chooseDifficultyView: some View {
        ChooseDifficultyView { difficulty in
            viewModel.set(difficulty)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                viewModel.goToNextStep()
            }
        }
    }

    var summaryView: some View {
        guard let witcher = viewModel.chosenWitcher, let difficulty = viewModel.chosenDifficulty else {
            return AnyView(Text("NIEPEŁNA KONFIGURACJA")
                .foregroundStyle(.white)
                .font(.witcherHeader(size: 20)))
        }
        return AnyView(GameSetupSummaryView(witcher: witcher, difficulty: difficulty, startGameBlock: { witcher, difficulty in
            viewModel.startGame(witcher: witcher, difficulty: difficulty)
        }))
    }
}
