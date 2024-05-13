//
//  Home.swift
//  Dice
//
//  Created by Waring, Nicholas S on 5/10/24.
//

import SwiftUI

class SpinViews: ObservableObject{
    @Published var spinner1: Bool = false
    @Published var spinner2: Bool = false
    @Published var spinner3: Bool = false
}

struct Home: View {
    /// Sample Items
    @State private var items: [SlotItem] = [.red, .blue, .green, .yellow, .cyan].compactMap { return .init(color: $0) }
    var body: some View {
        ScrollView(.vertical) {
            ScrollViewReader{ value in
                VStack {
                    GeometryReader {
                        let size = $0.size
                        
                        
                        HStack{
                            
                            LoopingScrollView2(height: 100, spacing: 8, SlotItems: items) { item in
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(item.color.gradient)
                                    .overlay {
                                        if let index = items.firstIndex(where: { $0.id == item.id }) {
                                            Text("\(index)")
                                                .font(.largeTitle.bold())
                                        }
                                    }
                            }
                            LoopingScrollView(height: 100, spacing: 8, SlotItems: items) { item in
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(item.color.gradient)
                                    .overlay {
                                        if let index = items.firstIndex(where: { $0.id == item.id }) {
                                            Text("\(index)")
                                                .font(.largeTitle.bold())
                                        }
                                    }
                            }
                          
                            LoopingScrollView3(height: 100, spacing: 8, SlotItems: items) { item in
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(item.color.gradient)
                                    .overlay {
                                        if let index = items.firstIndex(where: { $0.id == item.id }) {
                                            Text("\(index)")
                                                .font(.largeTitle.bold())
                                        }
                                    }
                            }
                        }.padding(.horizontal)
                        .contentMargins(.horizontal, 5, for: .scrollContent)
                    }
                    .frame(height: 150)
                }
            }
            .padding(.vertical, 25)
            
        }
        .scrollIndicators(.hidden)
    }
}


