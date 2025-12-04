import Foundation

// Entidades relacionadas a pessoa física

// Enum que representa nivel do aluno na academia
enum NivelAluno{
    case iniciante
    case intermediario
    case avancado
}

// Criação classe base
class Pessoa{
    private(set) var nome: String
    private(set) var email: String
   
    // Construtor da classe base
    init(nome: String, email: String){
        self.nome = nome
        self.email = email
    }
   
    // Função retorna nome e email
    func getDescricao() -> String{
        return """
        Informações Pessoais:
        Nome: \(self.nome)
        Email: \(self.email)
        """
    }
}

// Criação da subclasse Aluno
class Aluno: Pessoa{
    let matricula: String
    var nivel: NivelAluno
    private(set) var plano: Plano
    

    // Contrutor da subclasse
    init(nome: String, email: String, matricula: String, plano: Plano){
        self.matricula = matricula
        self.nivel = .iniciante
        self.plano = plano
        super.init(nome: nome, email: email)
    }
}

// Criação da subclasse Instrutor
class Instrutor: Pessoa{
    let especialidade: String
    
    // Construtor da subclasse
    init(nome: String, email: String, especialidade: String){
        self.especialidade = especialidade
        super.init(nome: nome, email: email)
    }
    
    // Sobreescrita da função retorn nome, emial e especialidade
    override func getDescricao() -> String{
        return """
        Nome: \(nome)
        Email: \(email) 
        Especialidade: \(especialidade)
        """
    }
}

// Fim das entidades relacionadas a pessoa física


// Definição do modelo de planos da academia

// Criação classe plano
class Plano{
    var nome: String

    // Construtor da classe
    init(nome: String){
        self.nome = nome
    }

    // Função retorna valor da mensalidade
    func calcularMensalidade() -> Double{
        return 0.0
    }
}

// Criação da subclasse PlanoMensal
class PlanoMensal: Plano{
    init(){
        super.init(nome: "Plano Mensal")
    }

    // Soobercrita da função retorna valor da mensalidade do plano mensal
    override func calcularMensalidade() -> Double {
        return 120.0
    }
}

// Criação da subclasse PlanoAnual
class PlanoAnual: Plano{

    // Contrutor da subclasse
    init(){
        super.init (nome: "Plano Anual(Promocional)")
    }

    // Sobreescrita de função retorna mensalidade do plano anual
    override func calcularMensalidade() -> Double{
        let mensalidade: Double = (120 * 0.8)
        return mensalidade
    }
}

// Fim da definição do modelo de planos da academia

// Definição dos aparelhos

// Criação do protocolo para manutenção de aparelhos
protocol Manutencao{
    var nomeItem: String {get}
    var dataUltimaManutencao: String {get}
    func realizarManutencao() -> Bool
}

// Criação classe Aparelho
class Aparelho: Manutencao{
    let nomeItem: String
    private (set) var dataUltimaManutencao: String

    // Construtor da classe
    init(nomeItem: String){
        self.nomeItem = nomeItem
        self.dataUltimaManutencao = "Nenhuma"
    }

    // Função retorna booleano a depender se a manutenção foi bem sucessida (true) ou não (false)
    func realizarManutencao() -> Bool{
        print("Manutenção em andamento...")
        print("1...")
        print("2...")
        print("3...")
        print("Manutenção realizada!")

        self.dataUltimaManutencao = "30/08/2025"

        return true // Mudar essa bomba, ta errado
    }
}

// Fim da definição dos aparelhos

// Definição da estrutura de aulas 

class Aula{
    let nome: String
    var instrutor: Instrutor

    init(nome: String, instrutor: Instrutor){
        self.nome = nome
        self.instrutor = instrutor
    }

    func getDescricao() -> String{
        return """
        Nome da aula: \(self.nome)
        Nome do instrutor: \(self.instrutor.nome)
        """
    }
}

class AulaPersonal: Aula{
    let aluno: Aluno

    init(aluno: Aluno, nome: String, instrutor: Instrutor){
        self.aluno = aluno
        super.init(nome: nome, instrutor: instrutor)
    }

    override func getDescricao() -> String{
        return """
        Nome do aluno \(self.aluno.nome)
        Nome da aula: \(self.nome)
        Nome do instrutor: \(instrutor.nome)
        """
    }
}

class AulaColetiva: Aula{
    private (set) var alunosInscritos: [String: Aluno] = [:]
    let capacidadeMaxima: Int

    override init(nome: String, instrutor: Instrutor){
        self.capacidadeMaxima = 2 // Para fins de teste
        super.init(nome: nome, instrutor: instrutor)
    }

    func inscrever(aluno: Aluno) -> Bool{
        if self.alunosInscritos.count < capacidadeMaxima {
            if !self.alunosInscritos.keys.contains(aluno.matricula){
                alunosInscritos[aluno.matricula] = aluno
                print("Aluno registrado com sucesso!")
                return true
            } else{
                print("Aluno já registrado")
            }
        } else{
            print("A capacidade máxima de alunos já foi alcançada, falha no registro")
        }

        return false
    }

    override func getDescricao() -> String{
        return """
        Nome da aula: \(self.nome)
        Nome do instrutor: \(self.instrutor.nome)
        Numero de vagas ocupadas: \(self.alunosInscritos.count)
        Capacidade maxima: \(self.capacidadeMaxima)
        """
    }
}

// Fim da definição da estrutura de aulas