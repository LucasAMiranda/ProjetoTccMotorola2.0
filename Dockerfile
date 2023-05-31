# Use uma imagem base Python
FROM python:3.10

# Defina o diretório de trabalho no contêiner
WORKDIR /ProjetoTccMotorola

# Copie apenas os arquivos necessários para o contêiner
COPY app.py /ProjetoTccMotorola
COPY database_creation.py /ProjetoTccMotorola/
COPY smartphones_models_scraping.py /ProjetoTccMotorola/
COPY webscraping_monograph.py /ProjetoTccMotorola/
COPY Phones_Models_List.json /ProjetoTccMotorola/
COPY collected_data.csv /ProjetoTccMotorola/
COPY requirements.txt /ProjetoTccMotorola/

# Copie os arquivos estáticos e templates para diretórios separados
COPY static /ProjetoTccMotorola/static/
COPY templates /ProjetoTccMotorola/templates/

# Instale as dependências, incluindo o pacote do MySQL
RUN apt-get update && \
    apt-get install -y default-libmysqlclient-dev && \
    pip install --no-cache-dir -r requirements.txt

# Defina a variável de ambiente para o arquivo .env
ENV PYTHONPATH=.
ENV DB_HOST=localhost
ENV DB_PORT=3306
ENV DB_USER=admindb
ENV DB_PASSWORD=sysadmin
ENV DB_DATABASE=monograph

# Defina o comando a ser executado quando o contêiner for iniciado
CMD ["python", "app.py"]
