# Carousel

Implementing a snapping carousel in #SwiftUI. Surprisingly (to me), none of the existing carousels I found use `ScrollView`. It looks like the trick is to use `HStack`, `DragGesture` and `offset(x:)`.

What do you know, it works great.
@jarwarren1
