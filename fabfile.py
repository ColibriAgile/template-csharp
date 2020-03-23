
import os

def obter_caminho(pasta=''):
    caminho = os.path.normpath(os.path.join(os.path.dirname(__file__), pasta))
    return caminho

def substituir_macro(arquivo, macro, valor):
    
    with open(arquivo, 'r', encoding='utf-8-sig') as arq:
        data = arq.read()
        
    data = data.replace(macro, valor)

    with open(arquivo, 'w', encoding='utf-8-sig') as arq:
        arq.write(data)

def iniciar_projeto(nome, nome_exibicao, produto='master'):
    manifesto = obter_caminho(r'_build\pacote\manifesto.server')
    arquivos = [
        obter_caminho(r'_build\server.ini'), 
        obter_caminho(r'_build\builder.bld'), 
        obter_caminho(r'_build\installer.iss'),
        manifesto
    ] 
    for arquivo in arquivos:
        print(arquivo)
        substituir_macro(arquivo, '%projeto%', nome)

    substituir_macro(manifesto, '%nomeExibicao%', nome_exibicao)
    substituir_macro(manifesto, '%produto%', produto)
    