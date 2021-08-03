//
//  ErrorView.swift
//  NewsApp
//
//  Created by Vinsi on 01/08/2021.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    
    typealias ErrorViewActionHandler = () -> Void
    
    let error: Error
    let handler: ErrorViewActionHandler
    
    init(error: Error, handler: @escaping ErrorView.ErrorViewActionHandler) {
        self.error = error
        self.handler = handler
    }
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.icloud.fill")
                .foregroundColor(.gray)
                .font(.system(size: 50, weight: .heavy))
            Text("Ooops")
                .foregroundColor(.black)
                .font(.system(size: 30, weight: .heavy))
            Button("Retry") {
                handler()
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: APIError.decodingError) {}
            .previewLayout(.sizeThatFits)
    }
}
