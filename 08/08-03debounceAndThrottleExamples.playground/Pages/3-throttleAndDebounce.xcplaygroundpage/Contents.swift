import SwiftUI
import Combine
import PlaygroundSupport

class ViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var debouncedText: String = ""
    @Published var throttleText: String = ""
    
    init() {
        $text
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .assign(to: &self.$debouncedText)
        
        $text
            .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
            .assign(to: &self.$throttleText)
    }
}

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("텍스트를 입력하세요", text: $viewModel.text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
            VStack(alignment: .leading) {
                Text("실시간 입력")
                    .font(.headline)
                Text(viewModel.text)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text("디바운스된 입력(1초후)")
                    .font(.headline)
                Text(viewModel.debouncedText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.blue.opacity(0.2))
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text("쓰로틀된 입력(1초마다)")
                    .font(.headline)
                Text(viewModel.throttleText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.green.opacity(0.2))
                    .cornerRadius(8)
            }
            
            Spacer()
            
        }
        .padding()
    }
}

PlaygroundPage.current.setLiveView(ContentView())
