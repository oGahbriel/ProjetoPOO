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
   
    // Função retorna vazio para ser Sobreescrito
    func getDescricao(){
    }
}

// Criação da subclasse Aluno
class Aluno: Pessoa{
    let matricula: String
    var nivel: NivelAluno
    private(set) var plano: Plano
    
    // Contrutor da subclasse
    init(nome: String, email: String, matricula: String,nivel: NivelAluno, plano: Plano){
        self.matricula = matricula
        self.nivel = nivel
        self.plano = plano
        super.init(nome: nome, email: email)
    }
    
    // Sobrescreve a descrição para incluir detalhes do aluno
    override func getDescricao() {
        print("""
        Nome: \(nome)
        Email: \(email)
        Matrícula: \(self.matricula)
        Nível: \(self.nivel)
        Plano: \(self.plano.obterNome())
        -------------------------------------
        """)
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
    override func getDescricao() {
        print("""
        Nome: \(nome)
        Email: \(email)
        Especialidade: \(especialidade)
        -------------------------------------
        """)
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

    // obter o nome do plano
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

    // calcular a mensalidade
    func calcularMensalidade() {
        switch self.tipo {
        case .mensal:
            return print("Sua mensalidade: 120.0")
        case .anual:
            let valorMensal = 120.0
            let desconto = 0.20
            let valorComDesconto = valorMensal - (valorMensal * desconto)
            return print("Sua mensalidade: \(valorComDesconto)")
        case .aulaExperimental:
            return print("Sua mensalidade: 0.0")
        }
    }
}

// Fim da definição do modelo de planos da academia

// Definição dos aparelhos

// Criação do protocolo para manutenção de aparelhos
protocol Manutencao{
    var nomeItem: String {get}
    var dataUltimaManutencao: String {get}
    func realizarManutencao()
}

// Criação classe Aparelho
class Aparelho: Manutencao{
    let nomeItem: String
    private (set) var dataUltimaManutencao: String

    // Construtor da classe
    init(nomeItem: String){
        self.nomeItem = nomeItem
        self.dataUltimaManutencao = "---Nenhuma manutenção realizada!"
    }

    // Função retorna booleano a depender se a manutenção foi bem sucessida (true) ou não (false)
    func realizarManutencao(){

        // Atualiza a data de manutenção para a data atual
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.dataUltimaManutencao = dateFormatter.string(from: Date())

        print("""
        Manutenção em andamento...
        1...
        2...
        3...
        Manutenção realizada!
        -------------------------------------
        """)
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

    func getDescricao(){
        print( """
        Nome da aula: \(self.nome)
        Nome do instrutor: \(self.instrutor.nome)
        -------------------------------------
        """)
    }
}

class AulaPersonal: Aula{
    let aluno: Aluno

    init(aluno: Aluno, nome: String, instrutor: Instrutor){
        self.aluno = aluno
        super.init(nome: nome, instrutor: instrutor)
    }

    override func getDescricao(){
        print("""
        Aula de \(self.nome):
            Nome do aluno: \(self.aluno.nome)
            Nome do instrutor: \(instrutor.nome)
        -------------------------------------
        """)
    }
}

class AulaColetiva: Aula{
    private (set) var alunosInscritos: [String: Aluno] = [:]
    let capacidadeMaxima: Int

    init(nome: String, instrutor: Instrutor, capacidadeMaxima: Int){
        self.capacidadeMaxima = capacidadeMaxima
        super.init(nome: nome, instrutor: instrutor)
    }

    func inscrever(aluno: Aluno){
        if self.alunosInscritos.count < capacidadeMaxima {
            if !self.alunosInscritos.keys.contains(aluno.matricula){
                alunosInscritos[aluno.matricula] = aluno
                 print("---Aluno \(aluno.nome) inscrito na aula \(self.nome) com sucesso!")
            } else{
                print("---Aluno já está inscrito nesta aula.")
            }
        } else{
             print("---A capacidade máxima de alunos já foi alcançada, falha no registro.")
        }
    }

    override func getDescricao(){
        print("""
        Aula de \(self.nome):
            Nome do instrutor: \(self.instrutor.nome)
            Vagas ocupadas: \(self.alunosInscritos.count)
            Capacidade maxima: \(self.capacidadeMaxima)
        -------------------------------------
        """)
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
        print("---Aparelho '\(aparelho.nomeItem)' adicionado.")
    }

    func adicionarAula(_ aula: Aula){
        self.aulasDisponiveis.append(aula)
        print("---Aula '\(aula.nome)' adicionada.")
    }

    func contratarInstrutor(_ instrutor: Instrutor){
        // Usa o email como chave única para o instrutor
        if self.intrutoresContratados[instrutor.email] == nil {
            self.intrutoresContratados[instrutor.email] = instrutor
            print("---Instrutor \(instrutor.nome) contratado com sucesso.")
        } else {
            print("---Erro: Já existe um instrutor com o email \(instrutor.email).")
        }
    }

    func matricularAluno(_ aluno: Aluno){
        // Usa a matrícula como chave única para o aluno
        if !self.alunosMatriculados.keys.contains(aluno.matricula){
            alunosMatriculados[aluno.matricula] = aluno
            print("---Aluno \(aluno.nome) matriculado com sucesso!")
        } else{
            print("---Erro: Aluno com matrícula \(aluno.matricula) já está matriculado.")
        }
    }

    // Sobrecarga de método para criar e matricular um novo aluno diretamente
    func matricularAluno(nome: String, email: String, matricula: String,nivel: NivelAluno, plano: Plano) -> Aluno {
        let novoAluno = Aluno(nome: nome, email: email, matricula: matricula,nivel: nivel, plano: plano)
        self.matricularAluno(novoAluno)
        return novoAluno
    }

    func buscarAluno(matricula: String) -> Aluno? {
        return alunosMatriculados[matricula]
    }

    func listarAlunos(){
        print ("--- Lista de Alunos Matriculados---")
        
        if alunosMatriculados.isEmpty {
            print("---Nenhum aluno matriculado.")
        } else {
            // Ordena os alunos pelo nome para exibição
            let alunosOrdenados = alunosMatriculados.values.sorted { $0.nome < $1.nome }

            for aluno in alunosOrdenados {
                aluno.getDescricao()
            }
        }
        print("------------------------------------")
    }

    func listarAulas(){
        print ("--- Lista de Aulas Disponíveis ---")
        
        if aulasDisponiveis.isEmpty {
            print("---Nenhuma aula disponível.")
        } else {
            for aula: Aula in aulasDisponiveis {
                aula.getDescricao()
            }
        }
        print("----------------------------------")
    }
 
 //criação da função gerarRelatorio usando tupla 
    func gerarRelatorio(){
        let totalAlunos: Int 
        let totalInstrutores: Int
        let totalAulas: Int

        totalAlunos = alunosMatriculados.count
        totalInstrutores = intrutoresContratados.count 
        totalAulas = aulasDisponiveis.count 
    
        print("""
        ----------------------------------
        \(self.nome):
            Total de alunos: \(totalAlunos)
            Total de instrutores: \(totalInstrutores)
            Total de aulas: \(totalAulas)
        ----------------------------------  
        """)
    }
}

// 1. Inicialização do Sistema
    let academia: Academia = Academia(nome: "Academia POO 360")

// 2. Criação dos Planos
    let planoMensal: Plano = Plano(tipo: .mensal)
    let planoAnual: Plano = Plano(tipo: .anual)

// 3. Contratação de Instrutores
    let instrutor1: Instrutor = Instrutor(nome: "Carlos Silva", email: "carlos.silva@exemplo.com", especialidade: "Musculação")
    let instrutor2: Instrutor = Instrutor(nome: "Mariana Oliveira", email: "mariana.oliveira@exemplo.com", especialidade: "Pilates")
    
    academia.contratarInstrutor(instrutor1)
    academia.contratarInstrutor(instrutor2)

// 4. Matrícula de Alunos
    let aluno1: Aluno = academia.matricularAluno(nome: "João Santos", email: "joao.santos@exemplo.com", matricula: "A001", nivel: .iniciante, plano: planoMensal)
    let aluno2: Aluno  = academia.matricularAluno(nome: "Ana Pereira",  email: "ana.pereira@exemplo.com",  matricula: "A002", nivel: .avancado, plano: planoAnual)

  // Criação do terceiro e quarto aluno para testes
    let aluno3: Aluno = academia.matricularAluno(nome: "Diogo Enzo", email: "diogo.enzo@exemplo.com", matricula: "A003", nivel: .intermediario, plano: planoMensal)
    let aluno4: Aluno  = academia.matricularAluno(nome: "Pedro Brito", email: "pedro.brito@exemplo.com", matricula: "A004", nivel: .iniciante, plano: planoAnual)

// 5. Criação e agendamento de aulas
  //criação aula de msculação tipo AulaPersonal
    let  musculacao: AulaPersonal = AulaPersonal(aluno: aluno1,nome: "Musculaçao",instrutor: instrutor1)

  //criação aula de pilates tipo AulaColetiva    
    let pilates: AulaColetiva = AulaColetiva(nome: "Pilates", instrutor: instrutor2, capacidadeMaxima: 3)
    
  //Adicionando ambas as aulas para a academia    
    academia.adicionarAula(musculacao)
    academia.adicionarAula(pilates)
    
// 6. Interação com a Aula Coletiva
    pilates.inscrever(aluno: aluno1)
    pilates.inscrever(aluno: aluno2)
    pilates.inscrever(aluno: aluno3)
    pilates.inscrever(aluno: aluno4)
    
    // Fins de deixar padrão a ordem das chamadas    
    academia.gerarRelatorio()
    
     academia.listarAulas()
     academia.listarAlunos()
    
/* 7. Demonstração Prática de Polimorfismo com Aulas
    let listaDeAulas: [Aula] = [musculacao, pilates]
    
 print ("--- Lista de aulas---")
    for aula in listaDeAulas {
        aula.getDescricao()
    }
 
 8. Demonstração Prática de Polimorfismo com Pessoas
    let listaDePessoas: [Pessoa] = [aluno3, instrutor2]
    
 print ("--- Lista de pessoas(aluno o instrutor)---")
    for pessoa in listaDePessoas {
        pessoa.getDescricao()
    }*/
 
// 9. exibindo relatorio de ttAlunos, ttInstrutores e ttAulas
  // academia.gerarRelatorio()
    
// Chamadas para verificar o sistema
  // pilates.getDescricao()
  // musculacao.getDescricao()
  // academia.listarAulas()
  // academia.listarAlunos()
   