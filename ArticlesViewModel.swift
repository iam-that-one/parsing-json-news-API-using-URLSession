//
//  ArticlesViewModel.swift
//  articles-API
//
//  Created by Abdullah Alnutayfi on 03/04/2021.
//

import Foundation


class AriclesViewModel: ObservableObject{
   
    @Published var articles = [Articles]()
    
   func fetchData(){
    let API_KEY = ""
    let API_URL = "https://newsapi.org/v2/everything?q=apple&from=2021-04-02&to=2021-04-02&sortBy=popularity&apiKey=\(API_KEY)"
        guard let url = URL(string: API_URL)else{
            return
        }
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        URLSession.shared.dataTask(with: request) { (data, _, error) in
          
            if let data = data{
                do{
                let response = try decoder.decode(News.self, from: data)
                    DispatchQueue.main.async {
                        self.articles =  (response.articles?.compactMap(){$0})!
                    }
               
                   print(response)
                }catch{
                    print(error.localizedDescription)
                }
            }
            print(error?.localizedDescription as Any)
        }.resume()
    }

}

struct News : Codable{

    var status : String?
    var totalResults : Int = 0
    var articles : [Articles]?
   
   
}


struct Articles : Codable,Identifiable {
    var title : String?
    var author : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var content : String?
    var id : String?{
        url
    }
}
