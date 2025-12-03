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