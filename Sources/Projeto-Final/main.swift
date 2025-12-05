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
    
    // Sobrescreve a descrição para incluir detalhes do aluno
    override func getDescricao() -> String {
        return """
        \(super.getDescricao())
        Matrícula: \(self.matricula)
        Nível: \(self.nivel)
        Plano: \(self.plano.obterNome())
        """
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

enum TipoPlano {
    case aulaExperimental
    case mensal
    case anual
}

class Plano {
    let tipo: TipoPlano

    init(tipo: TipoPlano) {
        self.tipo = tipo
    }

    // obter o nome do plano.
    func obterNome() -> String {
        switch self.tipo {
        case .mensal:
            return "Plano Mensal"
        case .anual:
            return "Plano Anual (Promocional)"
        case .aulaExperimental:
            return "Experimental"
        }
    }

    // calcular a mensalidade.
    func calcularMensalidade() -> Double {
        switch self.tipo {
        case .mensal:
            return 120.0
        case .anual:
            let valorMensal = 120.0
            let desconto = 0.20
            let valorComDesconto = valorMensal - (valorMensal * desconto)
            return valorComDesconto
        case .aulaExperimental:
            return 0.0
        }
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

        // Atualiza a data de manutenção para a data atual
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.dataUltimaManutencao = dateFormatter.string(from: Date())

        return true
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

    init(nome: String, instrutor: Instrutor, capacidadeMaxima: Int = 2){
        self.capacidadeMaxima = capacidadeMaxima // Para fins de teste
        super.init(nome: nome, instrutor: instrutor)
    }

    func inscrever(aluno: Aluno) -> Bool{
        if self.alunosInscritos.count < capacidadeMaxima {
            if !self.alunosInscritos.keys.contains(aluno.matricula){
                alunosInscritos[aluno.matricula] = aluno
                print("Aluno \(aluno.nome) inscrito na aula \(self.nome) com sucesso!")
                return true
            } else{
                print("Aluno já está inscrito nesta aula.")
            }
        } else{
            print("A capacidade máxima de alunos já foi alcançada, falha no registro.")
        }

        return false
    }

    override func getDescricao() -> String{
        return """
        Nome da aula: \(self.nome)
        Nome do instrutor: \(self.instrutor.nome)
        Vagas ocupadas: \(self.alunosInscritos.count)
        Capacidade maxima: \(self.capacidadeMaxima)
        """
    }
}

// Fim da definição da estrutura de aulas

class Academia {
    let nome: String
    private var alunosMatriculados: [String: Aluno]
    private var intrutoresContratados: [String: Instrutor]
    private var aparelhos: [Aparelho]
    private var aulasDisponiveis: [Aula]

    // Construtor corrigido: inicializa as coleções como vazias
    init(nome: String){
        self.nome = nome
        self.alunosMatriculados = [:]
        self.intrutoresContratados = [:]
        self.aparelhos = []
        self.aulasDisponiveis = []
    }
    
    func adicionarAparelho(_ aparelho: Aparelho){
        self.aparelhos.append(aparelho)
        print("Aparelho '\(aparelho.nomeItem)' adicionado.")
    }

    func adicionarAula(_ aula: Aula){
        self.aulasDisponiveis.append(aula)
        print("Aula '\(aula.nome)' adicionada.")
    }

    func contratarInstrutor(_ instrutor: Instrutor){
        // Usa o email como chave única para o instrutor
        if self.intrutoresContratados[instrutor.email] == nil {
            self.intrutoresContratados[instrutor.email] = instrutor
            print("Instrutor \(instrutor.nome) contratado com sucesso.")
        } else {
            print("Erro: Já existe um instrutor com o email \(instrutor.email).")
        }
    }

    func matricularAluno(_ aluno: Aluno){
        // Usa a matrícula como chave única para o aluno
        if !self.alunosMatriculados.keys.contains(aluno.matricula){
            alunosMatriculados[aluno.matricula] = aluno
            print("Aluno \(aluno.nome) matriculado com sucesso!")
        } else{
            print("Erro: Aluno com matrícula \(aluno.matricula) já está matriculado.")
        }
    }

    // Sobrecarga de método para criar e matricular um novo aluno diretamente
    func matricularAluno(nome: String, email: String, matricula: String, plano: Plano) -> Aluno {
        let novoAluno = Aluno(nome: nome, email: email, matricula: matricula, plano: plano)
        self.matricularAluno(novoAluno)
        return novoAluno
    }

    func buscarAluno(matricula: String) -> Aluno? {
        return alunosMatriculados[matricula]
    }

    func listarAlunos(){
        print ("\n--- Lista de Alunos Matriculados ---")
        
        if alunosMatriculados.isEmpty {
            print("Nenhum aluno matriculado.")
        } else {
            // Ordena os alunos pelo nome para exibição
            let alunosOrdenados = alunosMatriculados.values.sorted { $0.nome < $1.nome }

            for aluno in alunosOrdenados {
                print (aluno.getDescricao())
                print("---")
            }
        }
        print("------------------------------------")
    }

    func listarAulas(){
        print ("\n--- Lista de Aulas Disponíveis ---")
        
        if aulasDisponiveis.isEmpty {
            print("Nenhuma aula disponível.")
        } else {
            for aula in aulasDisponiveis {
                print (aula.getDescricao())
                print("---")
            }
        }
        print("----------------------------------")
    }
    
      //criação da função gerarRelatorio usando tupla 
    func gerarRelatorio() -> (Int, Int, Int) {
        let totalAlunos: Int 
        let totalInstrutores: Int
        let totalAulas: Int

        totalAlunos = alunosMatriculados.count
        totalInstrutores = intrutoresContratados.count 
        totalAulas = aulasDisponiveis.count 

        return (totalAlunos, totalInstrutores, totalAulas)
    }
   
}
    let montion: Academia = Academia(nome: "montion")
   print(montion.gerarRelatorio())