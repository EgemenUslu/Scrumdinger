//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by egemen uslu on 3/16/25.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occured!")
                    .font(.title)
                    .padding(.bottom)
                Text(
                    errorWrapper.error.localizedDescription
                )
                .font(.headline)
                Text(
                    errorWrapper.guidance
                )
                .font(.caption)
                .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var wrapper: ErrorWrapper {
        ErrorWrapper(
            error: SampleError.errorRequired,
            guidance: "You can safely ignore this error."
        )
    }

    static var previews: some View {
        ErrorView(
            errorWrapper: wrapper
        )
    }
}
