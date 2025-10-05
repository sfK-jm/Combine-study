import Foundation
import Combine

struct CatFact: Decodable {
    let fact: String
    let length: Int
}

// 정상 주소
let url = URL(string: "https://catfact.ninja/fact")!
// 오류 주소
//let url = URL(string: "httpcatfact.ninja/fact")!


let subscription = URLSession.shared.dataTaskPublisher(for: url)
    .map { (data, response) in
        return data
    }
    .decode(type: CatFact.self, decoder: JSONDecoder())
    .receive(on: DispatchQueue.main)
    .sink { completion in
        switch completion {
        case .finished:
            print("정상적으로 완료")
        case .failure(let error):
            print("에러 발생: \(error)")
        }
    } receiveValue: { catFact in
        print(catFact)
    }

