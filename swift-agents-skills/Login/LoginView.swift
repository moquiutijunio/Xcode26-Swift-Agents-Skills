//
//  LoginView.swift
//  swift-agents-skills
//
//  Created by Junio Cesar Moquiuti on 10/04/26.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    let onRegisterTapped: () -> Void

    init(onRegisterTapped: @escaping () -> Void = {}) {
        self.onRegisterTapped = onRegisterTapped
    }

    var body: some View {
        let bindableViewModel = Bindable(viewModel)

        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Login")
                    .font(.largeTitle.bold())

                Group {
                    validatedField(
                        title: "E-mail",
                        text: bindableViewModel.email,
                        hasEdited: viewModel.didEditEmail,
                        errorMessage: viewModel.emailError,
                        autocapitalization: .never,
                        keyboardType: .emailAddress,
                        onChanged: viewModel.markEmailAsEdited
                    )

                    secureValidatedField(
                        title: "Senha",
                        text: bindableViewModel.password,
                        hasEdited: viewModel.didEditPassword,
                        errorMessage: viewModel.passwordError,
                        onChanged: viewModel.markPasswordAsEdited
                    )
                }

                Button(action: viewModel.login) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isFormValid ? Color.blue : Color.gray)
                        .cornerRadius(12)
                }
                .disabled(!viewModel.isFormValid)
                .padding(.top, 8)

                Button(action: onRegisterTapped) {
                    Text("Cadastrar")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.blue)
                        .underline()
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 4)
            }
            .padding()
        }
    }
}

private extension LoginView {
    func validatedField(
        title: String,
        text: Binding<String>,
        hasEdited: Bool,
        errorMessage: String?,
        autocapitalization: TextInputAutocapitalization,
        keyboardType: UIKeyboardType,
        onChanged: @escaping () -> Void
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline.weight(.semibold))

            TextField("Digite aqui", text: text)
                .textInputAutocapitalization(autocapitalization)
                .keyboardType(keyboardType)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.secondarySystemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            hasEdited && errorMessage != nil
                            ? Color.red
                            : Color.gray.opacity(0.3),
                            lineWidth: 1
                        )
                )
                .cornerRadius(10)
                .onChange(of: text.wrappedValue) { _, _ in
                    onChanged()
                }

            if hasEdited, let errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    func secureValidatedField(
        title: String,
        text: Binding<String>,
        hasEdited: Bool,
        errorMessage: String?,
        onChanged: @escaping () -> Void
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline.weight(.semibold))

            SecureField("Digite aqui", text: text)
                .padding()
                .background(Color(.secondarySystemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            hasEdited && errorMessage != nil
                            ? Color.red
                            : Color.gray.opacity(0.3),
                            lineWidth: 1
                        )
                )
                .cornerRadius(10)
                .onChange(of: text.wrappedValue) { _, _ in
                    onChanged()
                }

            if hasEdited, let errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    LoginView()
}
