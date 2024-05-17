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
    
    let equationA: (Int, Int, Int) -> Int = { intValue1, intValue2, intValue3 in
        if intValue1 >= 3 {
            return 10
        } else {
            return -10
        }
    }

    let equationB: (Int, Int, Int) -> Int = { intValue1, intValue2, intValue3 in
        if intValue1 % 2 == 1 && intValue2 % 2 == 1 && intValue3 % 2 == 1 {
            return 2
        } else if intValue1 % 2 == 0 && intValue2 % 2 == 0 && intValue3 % 2 == 0 {
            return -2
        } else {
            return 0
        }
    }

    let equationC: (Int, Int, Int) -> Int = { intValue1, intValue2, intValue3 in
        if intValue1 == intValue2 && intValue2 == intValue3 {
            return -3
        } else if intValue1 == intValue2 || intValue2 == intValue3 || intValue1 == intValue3 {
            return 3
        } else {
            return 0
        }
    }

    let equationD: (Int, Int, Int) -> Int = { intValue1, intValue2, intValue3 in
        if intValue1 == 0 && intValue2 == 0 && intValue3 == 0 {
            return 0
        } else {
            return intValue1 + intValue2 + intValue3
        }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    /// Sample Items
    @State private var items: [SlotItem] = [.red, .blue, .green, .yellow, .cyan].compactMap { return .init(color: $0) }
    
    @State var stocks: [Stock] = []
    
    
    
    
    var body: some View {
        
       
        
        VStack(spacing: 0){
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
                                .padding(.top)
                                .contentMargins(.horizontal, 5, for: .scrollContent)
                                .frame(height: 125)
                        }
                        .frame(height: 125)
                        
                        
                    }
                }
               // .padding(.vertical, 25)
                
            }.frame(height: 125)
            VStack{
                ForEach(stocks.indices, id: \.self){stock in
                    RoundedRectangle(cornerRadius: 15).foregroundColor(Color(red: 40/255, green: 40/255, blue: 40/255)).padding(5).shadow(radius: 5)
                        .frame(height: 120)
                        .overlay{
                            HStack{
                                Text(stocks[stock].name).foregroundColor(Color(red: 51/255, green: 255/255, blue: 0/255)).font(.custom("PixelOperator8", fixedSize: 20)).fontWeight(.semibold)
                                Spacer()
                                Text("\(stocks[stock].currentVal)").font(.custom("PixelOperator-Bold", fixedSize: 40)).foregroundColor(.white).fontWeight(.semibold)
                            }
                            .padding(.horizontal)
                        }
                }
            }.frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 10)
            
            Spacer()

        }
        .scrollIndicators(.hidden)
        .onAppear{
            
            var stockA = Stock(currentVal: 100, name: "Stock A", description: "", equation: equationA)
           // stockA.updateValue(with: 2, 3, 4)
            stocks.append(stockA)

            var stockB = Stock(currentVal: 50, name: "Stock B", description: "", equation: equationB)
            //stockB.updateValue(with: 1, 3, 5)
            stocks.append(stockB)

            var stockC = Stock(currentVal: 200, name: "Stock C", description: "", equation: equationC)
            //stockC.updateValue(with: 2, 2, 2)
            stocks.append(stockC)

            var stockD = Stock(currentVal: 20, name: "Stock D", description: "", equation: equationD)
            //stockD.updateValue(with: 1, 2, 3)
            stocks.append(stockD)
        }
    }
}


