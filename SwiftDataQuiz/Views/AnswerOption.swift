import SwiftUI

struct AnswerOption: View {
    @Environment(GameManager.self) private var gameManager
    @State var isSelected = false
    var option: Option

    var body: some View {
        HStack(spacing: 20) {
            if isSelected {
                Image(systemName: option.isCorrect ? "checkmark.seal.fill" : "xmark.square.fill")
                    .font(.title3)
                    .foregroundColor(option.isCorrect ? .green : .red)

            } else {
                Image(systemName: "square")
            }
            
            Text(option.text)
                .bold()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(gameManager.isQuestionTried ? (isSelected ? .blue : .gray) : .gray)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: isSelected ? option.isCorrect ? .green : .red : .gray, radius: 5, x: 0.6, y: 0.6)
        .onTapGesture {
            if !gameManager.isQuestionTried {
                isSelected = true
                gameManager.chooseOption(option: option)
            }
        }
    }
}
