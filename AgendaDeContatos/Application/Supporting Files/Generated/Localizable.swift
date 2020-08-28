// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// fechar
  internal static let f = L10n.tr("Localizable", "f")
  /// aplicacao
  internal static let title = L10n.tr("Localizable", "Title")

  internal enum Common {
    /// Sim
    internal static let ok = L10n.tr("Localizable", "Common.ok")
  }

  internal enum Contatos {
    /// Contatos
    internal static let title = L10n.tr("Localizable", "Contatos.title")
  }

  internal enum Msg {
    /// FALHA!
    internal static let fracasso = L10n.tr("Localizable", "Msg.fracasso")
    /// OK!
    internal static let ok = L10n.tr("Localizable", "Msg.OK")
    /// SUCESSO!
    internal static let sucesso = L10n.tr("Localizable", "Msg.sucesso")
    internal enum Fracasso {
      /// Falha ao cadastrar um usuario!
      internal static let cadastro = L10n.tr("Localizable", "Msg.fracasso.cadastro")
      /// Falha ao logar: Verifique seu email ou sua senha e repita o processo!
      internal static let login = L10n.tr("Localizable", "Msg.fracasso.login")
      internal enum Cadastro {
        /// Email não confere!
        internal static let email = L10n.tr("Localizable", "Msg.fracasso.cadastro.email")
        /// Email invalido!
        internal static let emailInvalido = L10n.tr("Localizable", "Msg.fracasso.cadastro.emailInvalido")
        /// Senha não confere!
        internal static let senha = L10n.tr("Localizable", "Msg.fracasso.cadastro.senha")
        /// Sua senha não contem todos os requesitos: Minimo 8 caracteres(Uma maiuscula e um caractere especial Ex: Gabriel@987)
        internal static let senhaInvalido = L10n.tr("Localizable", "Msg.fracasso.cadastro.senhaInvalido")
      }
      internal enum Contato {
        /// Falha ao atualizar um contato, por favor repetir mais tarde
        internal static let atualizar = L10n.tr("Localizable", "Msg.fracasso.contato.atualizar")
        /// Falha ao criar um contato, por favor repetir mais tarde
        internal static let cadastro = L10n.tr("Localizable", "Msg.fracasso.contato.cadastro")
        /// Falha a deletar esse contato, por favor repetir mais tarde
        internal static let deletar = L10n.tr("Localizable", "Msg.fracasso.contato.deletar")
      }
    }
    internal enum Sucesso {
      /// Usuario cadastrado com sucesso!
      internal static let cadastro = L10n.tr("Localizable", "Msg.sucesso.cadastro")
      /// Sucesso ao logar
      internal static let login = L10n.tr("Localizable", "Msg.sucesso.login")
      internal enum Contato {
        ///  Sucesso ao atualizar o contato!
        internal static let atualizar = L10n.tr("Localizable", "Msg.sucesso.contato.atualizar")
        /// Contato criado com sucesso!
        internal static let cadastro = L10n.tr("Localizable", "Msg.sucesso.contato.cadastro")
        /// Sucesso ao deletar o contato
        internal static let deletar = L10n.tr("Localizable", "Msg.sucesso.contato.deletar")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle = Bundle(for: BundleToken.self)
}
// swiftlint:enable convenience_type
