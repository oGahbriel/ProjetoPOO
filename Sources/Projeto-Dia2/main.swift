protocol Manutencao {
    var nomeItem: String {get set}
    var dataUltimaManutencao: String {get set}
    func realizarManutencao() -> Bool
}

class Aparelho: Manutencao{
    var nomeItem: String
    var dataUltimaManutencao: String
    
    init(nome: String){
        self.nome = nome
    }
    
    realizarManutencao(){
        print("A última atualização foi feita em \(dataUltimaManutencao)")
    }
}

class Aula{
    var nome: String
    var instrutor: Instrutor
    
    init(nome: String, instrutor: Instrutor){
        self.nome = nome
        self.instrutor = instrutor
    }
    
     func getDescricao() -> String{
        return """
        Descricao: 
        Aula: \(self.nome)
        Instrutor: \(self.instrutor)
        """
    }
}

class AulaPersonal: Aula{
    var aluno: Aluno
    
    init(nome: String, instrutor: Instrutor, aluno: Aluno){
        self.aluno = aluno
        super.init(nome: nome, instrutor: instrutor)
    }
    
    override func getDescricao() -> String{
       return """
        Descricao: 
        Aluno: \(self.aluno)
        Aula Matriculada: \(nome)
        Instrutor: \(instrutor)
        """ 
    }
}


class AulaColetiva: Aula{

    private(set) var alunosInscritos:  [String: Aluno] =[:]
    var capacidadeMaxima: Int

    init(alunosInscritos: [String: Aluno]){
        self.alunosInscritos = alunosInscritos
        self.capacidadeMaxima = 25

    }

    func inscrever(aluno: Aluno) -> Bool{
        var contadora = alunosInscritos.count
        if contadora <= capacidadeMaxima{
            if !alunosInscritos.keys.contains(aluno.nome){
                alunosInscritos[aluno.nome] = aluno
                print("ALuno cadastrado com sucesso!")
                return true
            }
            else{
                print("Erro: Aluno ja cadastrado")
                return false
            }
        } else{
             print ("Erro: Capacidade Maxima Excedida")
             return false 
        }
    }

    override func getDescricao() -> String{
        return """
        Informações Pessoais:
        Nome: \(self.nome)
        Email: \(self.email)
        Vagas: \(alunosInscritos.count) / \(capacidadeMaxima)

        """
    }
}