import SwiftUI

public struct Carousel<Data, Content>: View where Data: RandomAccessCollection, Data.Index: Hashable, Content: View {
    @State private var currentIndex = 0
    @State private var offsetX: CGFloat = 0

    let items: Data
    let itemWidth: CGFloat
    let content: (Data.Element) -> Content
    var onIndexChanged: (Int) -> Void

    public init(items: Data, itemWidth: CGFloat, @ViewBuilder content: @escaping (Data.Element) -> Content, onIndexChanged: @escaping (Int) -> Void) {
        self.items = items
        self.itemWidth = itemWidth
        self.content = content
        self.onIndexChanged = onIndexChanged
    }

    public var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: 0) {
                ForEach(items.indices, id: \.self) { index in
                    content(items[index])
                        .frame(width: itemWidth)
                }
            }
            .padding(.horizontal, (geometry.size.width - itemWidth) / 2)
            .offset(x: offsetX)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offsetX = value.translation.width - CGFloat(currentIndex) * itemWidth
                    }
                    .onEnded { value in
                        let speedThreshold: CGFloat = 100 // if the final velocity is below threshold, treat as a drag (snap in place) instead of swipe
                        if abs(value.predictedEndLocation.x - value.location.x) < speedThreshold {
                            let indexOffset = Int(round(offsetX / -itemWidth))
                            currentIndex = max(0, min(items.count - 1, indexOffset))
                        } else {
                            let predictedEndOffset = value.predictedEndTranslation.width + offsetX
                            let predictedIndexOffset = Int(round(predictedEndOffset / -itemWidth))
                            currentIndex = max(0, min(items.count - 1, predictedIndexOffset))
                        }
                        withAnimation(.spring()) {
                            offsetX = CGFloat(currentIndex) * -itemWidth
                        }
                        onIndexChanged(currentIndex)
                    }
            )
        }
    }
}


