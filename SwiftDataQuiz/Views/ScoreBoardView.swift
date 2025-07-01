//
//  ScoreBoardView.swift
//  TestForEach
//
//  Created by Young Jin Ju on 6/30/25.
//

import SwiftUI

struct ScoreBoardView: View {
    @Environment(GameManager.self) private var gameManager
    
    var body: some View {
        HStack {
            ForEach(gameManager.boxes, id: \.id) { box in
                ScoreBoxView(scoreBox: box)
            }
        }
    }
}

struct ScoreBoxView: View {
    var scoreBox: ScoreBox
    
    var body: some View {
        if let hasScored = scoreBox.hasScored {
            if hasScored {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.green)
            } else {
                Image(systemName: "x.square.fill")
                    .foregroundStyle(.red)
            }
        }
        else {
            Image(systemName: "square")
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    ScoreBoardView()
        .environment(GameManager())
}
