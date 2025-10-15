import SwiftUI
import Combine
import PlaygroundSupport

class StockPriceViewModel: ObservableObject {
    @Published var stockPrice: Int = 100
    @Published var throttleStockPrice: Int = 100

    init() {
        let publisher = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .map { _ in
                let randomNum = Int.random(in: -5...5)
                return self.stockPrice + randomNum
            }
        
        publisher
            .assign(to: &self.$stockPrice)
        
        publisher
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .assign(to: &self.$throttleStockPrice)
    }
}

struct ContentView: View {
    
    @ObservedObject var viewModel: StockPriceViewModel = StockPriceViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("주식 가격 (no throttle)")
                Spacer()
                Text("\(viewModel.stockPrice)")
            }
            .background(.yellow.opacity(0.3))
            .frame(maxWidth: .infinity)
            .padding()
            
            HStack {
                Text("주식 가격 (throttle)")
                Spacer()
                Text("\(viewModel.throttleStockPrice)")
            }
            .background(.blue.opacity(0.3))
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
