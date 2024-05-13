

import SwiftUI

/// Custom View
///
/// 
///
/// 
///
///
///
///
struct LoopingScrollView2<Content: View, SlotItem: RandomAccessCollection>: View where SlotItem.Element: Identifiable {
    
    private var animation: Animation {
         .linear
         .speed(0.01)
         .repeatForever(autoreverses: true)
     }

    /// Customization Properties
    var height: CGFloat
    var spacing: CGFloat = 0
    var SlotItems: SlotItem
    @State var spinValue: Int = 0
    @State var scrolledID: Int?
    @State var addedValue: Int = 0
    @State private var timerCount = 0
    @ViewBuilder var content: (SlotItem.Element) -> Content
    @State private var selectedIndex: Int?
    @EnvironmentObject var spinners: SpinViews
    let timer1 = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            /// Saftey Check
            let repeatingCount = height > 0 ? 100 : 1
           
                ScrollView(.vertical) {
               
                        LazyVStack(spacing: spacing) {
                            ScrollViewReader { scrollViewProxy in
                            
                            ForEach(SlotItems) { SlotItem in
                                content(SlotItem)
                                    .frame(height: height)
                            }
                            
                            ForEach(0..<repeatingCount, id: \.self) { index in
                                let SlotItem = Array(SlotItems)[index % SlotItems.count]
                                content(SlotItem)
                                    .frame(height: height)
                                    .scrollTargetLayout()
                            }
                                
                            .onReceive(timer1) { _ in
                                       if timerCount < spinValue { // 30 * 0.1 seconds = 3 seconds
                                           if let index = selectedIndex {
                                               withAnimation(animation) {
                                          
                                                   selectedIndex = (index % (addedValue + SlotItems.count))
                                                   
                                                   let z = print("Check selected", selectedIndex, index)
                                                   scrollViewProxy.scrollTo(index, anchor: .center)
                                                   
                                                   
                                                   //0 = 0, 1 = 3, 2 = 1, 3 = 4, 4 = 2
                                               }
                                           } else {
                                          
                                               selectedIndex = 0
                                           }
                                           timerCount += 1
                                       } else {
                                           withAnimation{
                                               let m = print("In here 2", selectedIndex)
                                               selectedIndex! += addedValue
                                               if let index = selectedIndex{
                                                   scrollViewProxy.scrollTo(index, anchor: .center)
                                               }
                                               spinners.spinner1.toggle()
                                               timer1.upstream.connect().cancel()
                                           }// Stop the timer
                                         
                                           // Stop the timer
                                       }
                                   }
                        }             .scrollTargetBehavior(.paging)
                                .scrollPosition(id: $scrolledID)
                      
                        }.scrollTargetLayout()
                        .onChange(of: scrolledID){
                            print("scrolledID: \(scrolledID)")
                        }
                    //.scrollTargetLayout(){
                
                    .background {
                        ScrollViewHelper(
                            height: height,
                            spacing: spacing,
                            SlotItemsCount: SlotItems.count,
                            repeatingCount: repeatingCount
                        )
                    }
                }.disabled(true)
   
                .scrollIndicators(.hidden)
              
          
        } .onAppear{
            spinValue = 100
            addedValue = randomInteger1()
            let m = print("Added value 1", addedValue)
        }
    }
       
}

func randomInteger1() -> Int {
    return Int.random(in: 0...4)
}




fileprivate struct ScrollViewHelper: UIViewRepresentable {
    var height: CGFloat
    var spacing: CGFloat
    var SlotItemsCount: Int
    var repeatingCount: Int
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            height: height,
            spacing: spacing,
            SlotItemsCount: SlotItemsCount,
            repeatingCount: repeatingCount
        )
    }
    
    func makeUIView(context: Context) -> UIView {
        return .init()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView, !context.coordinator.isAdded {
                context.coordinator.defaultDelegate = scrollView.delegate
                scrollView.delegate = context.coordinator
                context.coordinator.isAdded = true
            }
        }
        
        context.coordinator.height = height
        context.coordinator.spacing = spacing
        context.coordinator.SlotItemsCount = SlotItemsCount
        context.coordinator.repeatingCount = repeatingCount
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var height: CGFloat
        var spacing: CGFloat
        var SlotItemsCount: Int
        var repeatingCount: Int
        
        /// Optional SwiftUI Default Delegate
        weak var defaultDelegate: UIScrollViewDelegate?
        
        init(height: CGFloat, spacing: CGFloat, SlotItemsCount: Int, repeatingCount: Int) {
            self.height = height
            self.spacing = spacing
            self.SlotItemsCount = SlotItemsCount
            self.repeatingCount = repeatingCount
        }
        
        /// Tells us whether the delegate is added or not
        var isAdded: Bool = false
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard SlotItemsCount > 0 else { return }
            
            let minY = scrollView.contentOffset.y
            let mainContentSize = CGFloat(SlotItemsCount) * height
            let spacingSize = CGFloat(SlotItemsCount) * spacing
            
            if minY > (mainContentSize + spacingSize) {
                scrollView.contentOffset.y -= (mainContentSize + spacingSize)
            }
            
            if minY < 0 {
                scrollView.contentOffset.y += (mainContentSize + spacingSize)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
