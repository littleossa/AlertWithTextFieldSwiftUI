//
//  AlertWithTextField.swift
//  AlertWithTextFieldSwiftUI
//
//  Created by 平岡修 on 2022/07/21.
//

import SwiftUI

// カスタムModifierの定義
struct AlertWithTextField: ViewModifier {
    @Binding var textFieldText: String
    @Binding var isPresented: Bool
    
    let title: String?
    let message: String?
    let placeholderText: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                AlertControllerWithTextFieldContainer(textFieldText: $textFieldText,
                                                      isPresented: $isPresented,
                                                      title: title,
                                                      message: message,
                                                      placeholderText: placeholderText)
            }
        }
    }
}

extension View {
    // カスタムModifierのメソッド名を alertWithTextField に置き換え
    func alertWithTextField(_ text: Binding<String>, isPresented: Binding<Bool>, title: String?, message: String?, placeholderText: String) -> some View {
        self.modifier(AlertWithTextField(textFieldText: text,
                                         isPresented: isPresented,
                                         title: title,
                                         message: message,
                                         placeholderText: placeholderText))
    }
}

struct AlertControllerWithTextFieldContainer: UIViewControllerRepresentable {
    
    @Binding var textFieldText: String
    @Binding var isPresented: Bool
    
    let title: String?
    let message: String?
    let placeholderText: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    // SwiftUIから新しい情報を受け、viewControllerが更新されるタイミングで呼ばれる
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // TextFieldの追加
        alert.addTextField { textField in
            textField.placeholder = placeholderText
            textField.returnKeyType = .done
        }
        
        // 決定ボタンアクション
        let doneAction = UIAlertAction(title: "決定", style: .default) { _ in
            if let textField = alert.textFields?.first,
               let text = textField.text {
                textFieldText = text
            }
        }
        
        // キャンセルボタンアクション
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        
        DispatchQueue.main.async {
            uiViewController.present(alert, animated: true, completion: {
                self.isPresented = false
            })
        }
    }
}
