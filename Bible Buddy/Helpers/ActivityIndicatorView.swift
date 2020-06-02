import Foundation
import SwiftUI




struct ActivitiyIndicatorView: UIViewRepresentable {
    
    @Binding var loading: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        //var color = UIColor(red: 0.22, green: 0.28, blue: 0.31, alpha: 1.00)
        let indicator = UIActivityIndicatorView(style: style)
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        loading ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

