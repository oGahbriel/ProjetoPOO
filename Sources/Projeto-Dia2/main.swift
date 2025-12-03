/*
Crie a classe AulaColetiva, que também herda de Aula:
○ Esta é outra especialização, representando uma aula em grupo com regras
específicas.

○ Propriedades Adicionais:
■ alunosInscritos: Um dicionário ([String: Aluno]) para
armazenar os alunos usando a matrícula como chave. A lista deve ser
private(set).

■ capacidadeMaxima (Int), com um valor padrão de 25.

○ Método Adicional: Crie a função inscrever(aluno: Aluno) -> Bool.
Ela deve conter a seguinte lógica:

○ Sobrescrita de Método: Sobrescreva getDescricao() para incluir o
número de vagas ocupadas e a capacidade máxima da turma.
*/





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
}

■ Verificar se a aula já atingiu a capacidade máxima.
■ Verificar se o aluno já não está inscrito.
■ Adicionar o aluno ao dicionário alunosInscritos.
■ Imprimir mensagens de sucesso, aviso ou erro para cada caso.
