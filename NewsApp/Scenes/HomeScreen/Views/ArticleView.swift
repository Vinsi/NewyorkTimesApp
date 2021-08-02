//
//  ArticleView.swift
//  NewsApp
//
//  Created by Vinsi on 01/08/2021.
//

import Foundation
import SwiftUI
import URLImage

struct ArticleView: View {
    
    let article: Result
    
    var body: some View {
        HStack {
            if let imageURL = article.media?.first?.mediaMetadata?.first?.url,
               let url = URL(string: imageURL) {
                
                URLImage(url,
                         failure: { error, _ in
                            PlaceholderImageView()
                         },
                         content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                })
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
              
            } else {
                PlaceholderImageView()
            }
            VStack(alignment: .leading, spacing: 4, content: {
                Text(article.title ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                Text(article.source?.rawValue ?? "")
                    .foregroundColor(.gray)
                    .font(.footnote)
            })
        }
    }
}

struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 100, height: 100)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Result.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
extension Result {
    static var dummyData: Result { undefined()}
}

func undefined<T>() -> T {
    fatalError("undefined")
}
