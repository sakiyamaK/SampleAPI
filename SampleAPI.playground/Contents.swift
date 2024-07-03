import UIKit

//let urlStr: String = "https://picsum.photos/200/300"
//
//let url = URL(string: urlStr)!
//
//// 古い書き方
//// URLSession.sharedはシングルトンパターン
let session = URLSession.shared
let task = session.dataTask(with: url) { data, response, error in
    // errorがnilじゃないならifがtrueになる
    if let error {
        print(error)
        return
    }
    
    // 古い書き方
    // errorが_errorに代入して値があるようならifがtrue
    if let _error = error {
        print(_error)
        return
    }
    
    guard let data, let image = UIImage(data: data) else {
        print("dataは画像じゃないよ")
        return
    }
    
    //　本当はここでUI側に渡して画面に表示したりする
    image
}

task.resume()



let urlStr = "https://picsum.photos/200/300"

let url = URL(string: urlStr)!

Task {
    do {
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "dataは画像じゃないよ", code: 100)
        }
        
        //　本当はここでUI側に渡して画面に表示したりする
        image
        print(image.size)
    } catch let error {
        print(error)
    }
}
