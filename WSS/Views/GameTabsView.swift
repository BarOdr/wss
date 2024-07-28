//
//  GameTabsView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 23/07/2024.
//

import SwiftUI

final class GameTabsViewModel: ObservableObject {
    @Published var decks: BaseDecks
    init(decks: BaseDecks) {
        self.decks = decks
    }
}

struct GameTabsView: View {

    enum Tab: Equatable {
        case actions
        case challenges
        case ability(witcher: Witcher)

        var imageName: String {
            switch self {
            case .actions:
                return "back_automa_action"
            case .challenges:
                return "back_automa_challenge"
            case .ability(let witcher):
                return witcher.backImageName
            }
        }
    }

    @State var selectedTab: Tab = .actions
    @StateObject var viewModel: GameTabsViewModel

    var body: some View {
        ZStack(alignment: .top) {
            WoodenBackgroundView()
            VStack {
                topBarView
                    .padding()
                slidableDecks
            }
        }
    }

    private func deckOpacity(for tab: Tab) -> CGFloat {
        (selectedTab == tab) ? 1 : 0
    }

    private func zIndex(for tab: Tab) -> CGFloat {
        (selectedTab == tab) ? 1 : 0
    }

    private var topBarView: some View {
        HStack(spacing: 10) {
            ActionableCardView(imageName: Tab.actions.imageName, size: .small, singleTapGesture: {
                withAnimation {
                    selectedTab = .actions
                }
            })
            .scaleEffect((selectedTab == .actions ? 1.2 : 1))
            .frame(width: 50)
            ActionableCardView(imageName: Tab.challenges.imageName, size: .small, singleTapGesture: {
                withAnimation {
                    selectedTab = .challenges
                }
            })
            .scaleEffect((selectedTab == .challenges ? 1.2 : 1))
            .frame(width: 50)
            ActionableCardView(imageName: Witcher.ciri.backImageName, size: .small, singleTapGesture: {
                withAnimation {
                    selectedTab = .ability(witcher: .ciri)
                }
            })
            .scaleEffect((selectedTab == .ability(witcher: .ciri) ? 1.2 : 1))
            .frame(width: 50)
        }
    }

    private func zIndexForTab(_ tab: Tab) -> Double {
        return selectedTab == tab ? 1 : 0
    }

    private func offsetForTab(_ tab: Tab) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        switch selectedTab {
        case .actions:
            switch tab {
            case .actions: return 0
            case .challenges: return screenWidth
            case .ability: return screenWidth * 2
            }
        case .challenges:
            switch tab {
            case .actions: return -screenWidth
            case .challenges: return 0
            case .ability: return screenWidth
            }
        case .ability:
            switch tab {
            case .actions: return -screenWidth * 2
            case .challenges: return -screenWidth
            case .ability: return 0
            }
        }
    }

    private var slidableDecks: some View {
        // Views with slide transition
        ZStack {
            ActionDeckView(deck: viewModel.decks.actionDeck)
                .offset(x: offsetForTab(.actions))
                .zIndex(zIndexForTab(.actions))
            ChallengesDeckView(deck: viewModel.decks.challengesDeck)
                .offset(x: offsetForTab(.challenges))
                .zIndex(zIndexForTab(.challenges))
            ActionableCardView(imageName: Witcher.ciri.imageName, size: .big)
                .offset(x: offsetForTab(.ability(witcher: .ciri)))
                .zIndex(zIndexForTab(.ability(witcher: .ciri)))
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 70, trailing: 40))
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.3), value: selectedTab)
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure full screen coverage
        .clipped() // Ensure views do not bleed outside their bounds
    }
}
