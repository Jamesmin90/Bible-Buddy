import SwiftUI

struct TextMessage: View {
    
    var textMessage: String
    
    var body: some View {
        Text(textMessage)
            .font(.system(size: 18))
            .foregroundColor(Color.black)
            .padding(.top, 60)
            .padding(.bottom, 30)
            .multilineTextAlignment(.center)
    }
}

struct TextMessage_Previews: PreviewProvider {
    static var previews: some View {
        TextMessage(textMessage: "Do you really want to delete your profile?")
    }
}
