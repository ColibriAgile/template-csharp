# Repósitorio modelo para projetos C#

## Como usar:

### Faça o download  deste repositório e renomeie a pasta seguindo o seguinte padrão:

```
br-nome-do-projeto
```
use sempre lowercase e separação por hifens.

### Inicie um terminal na pasta e rode o seguinte comando:
```
fab iniciar_projeto:produto=<produto>
```
Onde \<produto> pode ser: 
- master
- pos
- cbo
  
Uma nova solução .net sera criada contendo um projeto windows forms .net core 3 e os arquivos de build serão alterados para apontar para este projeto.

Por padrão o fab utiliza o nome da pasta para gerar o arquivo de solução de projeto da seguinte maneira:

- **nome da pasta:** br-um-projeto
- **nome da solução:** Br Um Projeto
- **nome do projeto:** Br.Um.Projeto

Mas é possivel customizar o nome do projeto e da solução passando alguns parametros para o metodo iniciar_projeto.

Ex: 
```
fab inicia_projeto:Br.UmNomeDiferente,nome_exibicao="Um Nome Diferente",produto=master
```
Ao final do processo suba o repositório para o bitbucket.