// 1 //
class Academia {
    let nome: String 
    private var alunosMatriculados: [String: Aluno]
    private var intrutoresContratados: [String: Instrutor]
    private var aparelhos: [Aparelho]
    private var aulasDisponiveis: [Aula]

    init(nome: String, alunosMatriculados: String, intrutoresContratados: String,
         aparelhos: Aparelho, aulasDisponiveis: Aula){
                self.nome = nome
                self.alunosMatriculados = alunosMatriculados
                self.intrutoresContratados = intrutoresContratados
                self.aparelhos = aparelhos
                self.aulasDisponiveis = aulasDisponiveis
    }

// 2 //

    func buscarAluno(matricula: String) -> Aluno?{
        if alunosMatriculados.keys.contains(aluno.matricula){
            return alunosMatriculados[aluno.matricula]
        }else {
            return nil
        }
    }

    func listarAlunos(){
        print ("--- Lista de Alunos Matriculados ---")
        let alunos: infoAlunos (alunosMatriculados.values)

        if alunos.empty{
            print("Nenhum aluno matriculado")
        }else{
            let alunosOrdenados = alunos.sorted

            for aluno in alunosOrdenados {
                print (aluno.getDescricao())
            }
        }
        print("---------------------------------------------------")
    }

    func listarAulas(){
        print ("--- Lista de Aulas ---")
        let aulas: listaAulas (aulasDisponiveis.values)

        for aula in listaAulas{
            print (aula.getDescricao())
        }

        print("---------------------------------------------------")
    }
}