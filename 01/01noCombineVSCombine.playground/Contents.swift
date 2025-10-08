// no Combine 일반적인 비동기 코드
import Foundation

struct CatFact: Decodable {
    let fact: String
    let length: Int
}

func fetchCatFact(completion: @escaping (CatFact) -> Void) {
    let url = URL(string: "https://catfact.ninja/fact")!

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        //에러 처리 코드 생략
        let decoder = JSONDecoder()
        let catFact = try! decoder.decode(CatFact.self, from: data!)
        completion(catFact)
    }
    task.resume()
}

fetchCatFact { catFactString in
    DispatchQueue.main.async {
        //뷰에 데이터 장착하는 부분
        print(catFactString)
    }
}

