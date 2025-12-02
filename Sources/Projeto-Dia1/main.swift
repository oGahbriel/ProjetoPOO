import Foundation

// enum NivelAluno
enum NivelAluno{
    case iniciante
    case intermediario
    case avancado
}

// Criação classe base
class Pessoa{
    var nome: String
    var email: String
   
    init(nome: String, email: String){
        self.nome = nome
        self.email = email
    }
   
    func getDescricao() -> String{
        return """
        Informações Pessoais:
        Nome: \(self.nome)
        Email: \(self.email)
        """
    }
}

// Criação da classe Aluno
class Aluno: Pessoa{
    let matricula: String
    var nivel: NivelAluno
    private(set) var plano: Plano
    
    init(nome: String, email: String, matricula: String, plano: Plano){
        self.matricula = matricula
        self.nivel = .iniciante
        self.plano = plano
        super.init(nome: nome, email: email)
    }
}

// Criação da classe Instrutor
class Instrutor: Pessoa{
    let especialidade: String
    
    init(nome: String, email: String, especialidade: String){
        self.especialidade = especialidade
        super.init(nome: nome, email: email)
    }
    
    override func getDescricao() -> String{
        return """
        Nome: \(nome)
        Email: \(email) 
        Especialidade: \(especialidade)
        """
    }
}

// Criação classe plano
class Plano{
    var nome: String

    init(nome: String){
        self.nome = nome
    }

    func calcularMensalidade() -> Double{
        return 0.0
    }
}

let plano: Plano = Plano(nome:"Anual")
let aluno: Aluno = Aluno(nome:"Gabriel", email:"Gabriel69@gmail.com", matricula:"SM2025", plano:plano)

let descricao: String = aluno.getDescricao()
print(descricao)

let inst: Instrutor = Instrutor(nome:"Pedro", email:"pedro67@gmail.com", especialidade:"Musculacao")
let desc: String = inst.getDescricao()
print(desc)



