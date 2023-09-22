//
// MyCreativeCollection
// Created by: itsjagnezi on 29/07/23
// Copyright (c) today and beyond
//

import SwiftUI

struct ToolbarItemButton: View {
	
	@Binding var toggleSomething: Bool
	let label: LocalizedStringKey
	
    var body: some View {
			Button {
				toggleSomething = true
			} label: {
				Image(systemName: "plus")
					.bold()
					.font(.caption)
					.foregroundColor(.white)
					.background(.black)
					.clipShape(Circle())
				Text(label)
					.bold()
					.foregroundColor(.white)
			}
			.padding(.vertical, 8)
			.padding(.horizontal, 16)
			.background(LinearGradient(colors: [Color.darkOcean, Color.lightOcean], startPoint: UnitPoint(x:0,y:0), endPoint: UnitPoint(x:1,y:1)))
			.clipShape(Capsule())
    }
}

struct ToolbarItemButton_Previews: PreviewProvider {
    static var previews: some View {
			ToolbarItemButton(toggleSomething: .constant(true), label: "common.newThing")
				.previewLayout(PreviewLayout.sizeThatFits)
				.previewDisplayName("Default preview")
    }
}
