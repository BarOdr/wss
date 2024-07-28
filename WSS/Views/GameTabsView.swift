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

    enum Tab {
        case actions
        case challenges

        var imageName: String {
            switch self {
            case .actions:
                return "back_automa_action"
            case .challenges:
                return "back_automa_challenge"
            }
        }
    }

    @State var selectedTab: Tab = .actions
    @StateObject var viewModel: GameTabsViewModel

    var topBarView: some View {
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
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            WoodenBackgroundView()
            topBarView
                .padding()
            slidableDecks
        }
    }

    private func tabButtonColor(for tab: Tab) -> Color {
        (selectedTab == tab) ? .white : .gray
    }

    private func tabBarButtonOpacity(for tab: Tab) -> CGFloat {
        (selectedTab == tab) ? 1 : 0.5
    }

    private func deckOpacity(for tab: Tab) -> CGFloat {
        (selectedTab == tab) ? 1 : 0
    }

    private func zIndex(for tab: Tab) -> CGFloat {
        (selectedTab == tab) ? 1 : 0
    }

    private var slidableDecks: some View {
        // Views with slide transition
        ZStack {
            ActionDeckView(deck: viewModel.decks.actionDeck)
                .offset(x: selectedTab == .actions ? 0 : -UIScreen.main.bounds.width)
                .zIndex(selectedTab == .actions ? 1 : 0) // Ensure the active view is on top
            ChallengesDeckView(deck: viewModel.decks.challengesDeck)
                .offset(x: selectedTab == .challenges ? 0 : UIScreen.main.bounds.width)
                .zIndex(selectedTab == .challenges ? 1 : 0) // Ensure the active view is on top
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.3), value: selectedTab)
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure full screen coverage
        .clipped() // Ensure views do not bleed outside their bounds
    }
}
