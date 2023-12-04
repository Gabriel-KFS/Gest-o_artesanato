from sqlalchemy import create_engine

# Substitua 'database_url' pela URL do seu banco de dados
database_url = 'postgresql://usuario:senha@localhost/nome_do_banco'
engine = create_engine(database_url)


try:
   connection = engine.connect()
   print("Conexão estabelecida com sucesso!")
except Exception as e:
   print(f"Erro ao conectar ao banco de dados: {e}")
finally:
   connection.close()

   from sqlalchemy import create_engine, Column, Integer, String, ForeignKey
   from sqlalchemy.ext.declarative import declarative_base
   from sqlalchemy.orm import sessionmaker, relationship

   Base = declarative_base()


   class Produto(Base):
       __tablename__ = 'produto'
       produto_id = Column(Integer, primary_key=True)
       nome = Column(String)
       descricao = Column(String)
       preco = Column(Integer)
       quantidade_em_estoque = Column(Integer)
       fornecedor_id = Column(Integer, ForeignKey('fornecedor.fornecedor_id'))
       fornecedor = relationship("Fornecedor", back_populates="produtos")


   class Fornecedor(Base):
       __tablename__ = 'fornecedor'
       fornecedor_id = Column(Integer, primary_key=True)
       nome = Column(String)
       endereco = Column(String)
       informacoes_contato = Column(String)
       produtos = relationship("Produto", back_populates="fornecedor")





   Base.metadata.create_all(engine)


   from sqlalchemy.orm import sessionmaker

   Session = sessionmaker(bind=engine)
   session = Session()


   novo_produto = Produto(nome='Arte Abstrata', descricao='Pintura abstrata em tela', preco=100.0,
                          quantidade_em_estoque=10, fornecedor_id=1)
   session.add(novo_produto)
   session.commit()


   produtos = session.query(Produto).all()
   for produto in produtos:
       print(f"Produto: {produto.nome}, Preço: {produto.preco}")
