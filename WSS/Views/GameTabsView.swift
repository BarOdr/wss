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
    }

    @State var selectedTab: Tab = .actions
    @StateObject var viewModel: GameTabsViewModel

    var body: some View {
        ZStack {
            Image("wooden_background", bundle: .main)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            ZStack {
                VStack {
                    HStack {
                        Button {
                            withAnimation {
                                selectedTab = .actions
                            }
                        } label: {
                            Text("Akcje")
                                .font(.witcherHeader(size: 30))
                                .foregroundStyle(tabButtonColor(for: .actions))
                                .opacity(tabBarButtonOpacity(for: .actions))
                        }
                        Button {
                            withAnimation(.easeInOut) {
                                selectedTab = .challenges
                            }
                        } label: {
                            withAnimation(.easeInOut) {
                                Text("Wyzwania")
                                    .font(.witcherHeader(size: 30))
                                    .foregroundStyle(tabButtonColor(for: .challenges))
                                    .opacity(tabBarButtonOpacity(for: .challenges))
                            }
                        }
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
                .zIndex(1)
                HStack(alignment: .bottom) {
                    Spacer()
                    slidableDecks
                }
            }
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
