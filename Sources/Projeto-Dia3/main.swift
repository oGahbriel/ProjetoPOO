class Academia {
    let nome: String 
    private var alunosMatriculados: [String: Aluno]
    private var intrutoresContratados: [String: Instrutor]
    private var aparelhos: [Aparelho]
    private var aulasDisponiveis: [Aula]

    init(nome: String, alunosMatriculados: String, intrutoresContratados: String,
         aparelhos: aparelho, aulasDisponiveis: Aula){
                self.nome = nome
                self.alunosMatriculados = alunosMatriculados
                self.intrutoresContratados = intrutoresContratados
                self.aparelhos = aparelhos
                self.aulasDisponiveis = aulasDisponiveis
    }
}