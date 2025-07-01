import SwiftUI

struct AnswerRow: View {
    @Environment(GameManager.self) private var gameManager
    var option: Option
    @State var isSelected = false

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "circle.fill")
                .font(.caption)
            
            Text(option.text)
                .bold()
            
            if isSelected {
                Spacer()
                
                Image(systemName: option.isCorrect ? "checkmark.square" : "x.square")
                    .foregroundColor(option.isCorrect ? .green : .red)
            }
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
