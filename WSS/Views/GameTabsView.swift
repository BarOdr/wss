//
//  GameTabsView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 23/07/2024.
//

import SwiftUI

struct GameTabsView: View {

    enum Tab {
        case actions
        case challenges
    }

    @State var selectedTab: Tab = .actions

    var body: some View {
        ZStack {
            Image("wooden_background", bundle: .main)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            selectedTab = .actions
                        }
                        print("Show action deck")
                    } label: {
                        Text("Akcje")
                            .font(.witcherHeader(size: 30))
                            .foregroundStyle(tabButtonColor(for: .actions))
                            .opacity(opacity(for: .actions))
                    }
                    Button {
                        withAnimation(.easeInOut) {
                            selectedTab = .challenges
                        }
                        print("Show challenges deck")
                    } label: {
                        withAnimation(.easeInOut) {
                            Text("Wyzwania")
                                .font(.witcherHeader(size: 30))
                                .foregroundStyle(tabButtonColor(for: .challenges))
                                .opacity(opacity(for: .challenges))
                        }
                    }
                }

                // Views with slide transition
                ZStack {
                    View1()
                        .offset(x: selectedTab == .actions ? 0 : UIScreen.main.bounds.width)
                        .zIndex(selectedTab == .actions ? 1 : 0) // Ensure the active view is on top
                    View2()
                        .offset(x: selectedTab == .challenges ? 0 : -UIScreen.main.bounds.width)
                        .zIndex(selectedTab == .challenges ? 1 : 0) // Ensure the active view is on top
                }
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.3), value: selectedTab)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure full screen coverage

                .clipped() // Ensure views do not bleed outside their bounds
            }
        }
    }

    private func tabButtonColor(for tab: Tab) -> Color {
        (selectedTab == tab) ? .white : .gray
    }

    private func opacity(for tab: Tab) -> CGFloat {
        (selectedTab == tab) ? 1 : 0.5
    }
}

#Preview {
    GameTabsView()
}

struct View1: View {
    var body: some View {
        Color.red
            .overlay(Text("View 1").font(.largeTitle).foregroundColor(.white))
            .edgesIgnoringSafeArea(.all)
    }
}

struct View2: View {
    var body: some View {
        Color.green
            .overlay(Text("View 2").font(.largeTitle).foregroundColor(.white))
            .edgesIgnoringSafeArea(.all)
    }
}
