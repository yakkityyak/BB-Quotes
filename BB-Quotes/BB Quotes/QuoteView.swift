//
//  QuoteView.swift
//  BB Quotes
//
//  Created by Jakob Hjortshøj on 30/08/2022.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var viewModel = ViewModel(controller: FetchController())
    let show: String
    @State var showCharacterScreen = false
    
    var body: some View {
        ZStack {
            Image(show.lowercased().filter { $0 != " "})
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 2.7, height: UIScreen.main.bounds.height * 1.1)
            VStack {
                VStack {
                    Spacer()
                    Spacer()
                    
                    switch viewModel.status {
                    case .success(let data):
                        Text("\"\(data.0.quote)\"")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                        
                        ZStack {
                            AsyncImage(url: data.1.image) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/1.8)
                            } placeholder: {
                                ProgressView()
                            }
                            .onTapGesture {
                                showCharacterScreen.toggle()
                            }
                            .sheet(isPresented: $showCharacterScreen) {
                                CharacterView(show: show, character: data.1)
                            }
                            VStack {
                                Spacer()
                                
                                Text(data.0.author)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.gray.opacity(0.33))
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/1.8)
                        .cornerRadius(80)
                        
                    case .fetching:
                        ProgressView()
                            .padding([.top, .bottom], 270)
                        
                    default:
                        EmptyView()
                    }
                    Spacer()
                }
                Button("Get Random Quote") {
                    Task {
                        await viewModel.getData(from: show)
                    }
                }
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color(show.filter { $0 != " "} + "Button"))
                .cornerRadius(7)
                .shadow(color: Color(show.filter {  $0 != " "} + "Shadow"), radius: 2, x: 0, y: 0)
                .padding(.bottom, 100)
                
                Spacer()
                Spacer()
                
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(show: "Breaking Bad")
    }
}
