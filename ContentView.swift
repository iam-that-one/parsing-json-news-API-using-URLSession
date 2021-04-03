//
//  ContentView.swift
//  articles-API
//
//  Created by Abdullah Alnutayfi on 03/04/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var avm = AriclesViewModel()
    var body: some View {
        NavigationView{
        ZStack{
           
            Color.green.opacity(0.30)
        VStack(alignment: .leading){
            ScrollView(showsIndicators: false){
           
            ForEach(avm.articles){ article in
                VStack(alignment: .leading){
                    HStack{
                    Image(uiImage: (UIImage(data: loadImage(ImageUrl: article.urlToImage ?? "https://i.pinimg.com/564x/6f/de/85/6fde85b86c86526af5e99ce85f57432e.jpg") ?? Data()) ?? UIImage(systemName: "star"))!)
                       
                    .resizable()
                        
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.leading)
                        Text(article.author ?? "")
                          
                        Spacer()
                    }.background(Color.yellow)
                 
                Text(article.title ?? "")
                    .fontWeight(.bold)
                    .padding(.leading)
                    Text(article.description ?? "")
                        .font(Font.system(size: 12,design: .serif))
                        .padding()
                   
                    Text(article.content ?? "")
                    .font(.body)
                        .padding(.leading)
                    Link("Read more",destination: URL(string: article.url ?? "")!)
                        .padding(.leading)
            }
            }
            
        }.navigationBarTitle(Text("News"), displayMode: .inline)
        .frame(height: UIScreen.main.bounds.height - 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .offset(y: 50)
        }.onAppear{avm.fetchData()}
       // .padding(.leading)
        
        }.ignoresSafeArea()
        }
    }
    func loadImage(ImageUrl: String) -> Data?{
        guard let url = URL(string: ImageUrl) else {return Data()}
        if let data = try? Data(contentsOf: url){
            return data
        }
        return nil
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
