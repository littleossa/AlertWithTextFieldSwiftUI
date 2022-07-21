//
//  ContentView.swift
//  AlertWithTextFieldSwiftUI
//
//  Created by 平岡修 on 2022/07/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = "入力されたテキスト"
    @State private var shouldPresentAlert = false
    
    var body: some View {
        
        VStack(spacing: 50) {
            Text(text)
                .bold()
            
            Button {
                shouldPresentAlert.toggle()
            } label: {
                Text("アラート表示")
            }
        }
        .alertWithTextField($text,
                            isPresented: $shouldPresentAlert,
                            title: "テキスト入力",
                            message: nil,
                            placeholderText: "")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    
    
}
