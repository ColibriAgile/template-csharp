
import os
from fabric.api import local, task, puts
import string

def obter_caminho(pasta=''):
    caminho = os.path.normpath(os.path.join(os.path.dirname(__file__), pasta))
    return caminho

def substituir_macro(arquivo, macro, valor):
    
    with open(arquivo, 'r', encoding='utf-8-sig') as arq:
        data = arq.read()
        
    data = data.replace(macro, valor)

    with open(arquivo, 'w', encoding='utf-8-sig') as arq:
        arq.write(data)

def substituir_macros(nome, nome_exibicao, produto):
    manifesto = obter_caminho(r'_build\pacote\manifesto.server')
    builder = obter_caminho(r'_build\builder.bld')
    arquivos = [
        obter_caminho(r'_build\server.ini'), 
        obter_caminho(r'_build\installer.iss'),
        builder, 
        manifesto
    ] 
    for arquivo in arquivos:
        puts(arquivo)
        substituir_macro(arquivo, '%projeto%', nome)

    substituir_macro(builder, '%nomeExibicao%', nome_exibicao)
    substituir_macro(manifesto, '%nomeExibicao%', nome_exibicao)
    substituir_macro(manifesto, '%produto%', produto)

@task
def iniciar_projeto(nome=None, nome_exibicao=None, produto='master', tipo='winforms'):
    pasta = os.path.basename(os.path.dirname(__file__))
    if not nome:
        nome = string.capwords(pasta.replace('-', '.'), sep='.')
    
    if not nome_exibicao:
        nome_exibicao = nome.replace('.', ' ')

    local('dotnet new {} -n {}'.format(tipo, nome))
    local('dotnet new sln -n "{}"'.format(nome_exibicao))
    local('dotnet sln add {}'.format(nome))
    substituir_macros(nome, nome_exibicao, produto)
    