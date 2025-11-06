package br.com.nassauburgers;

import javax.faces.bean.ManagedBean;

@ManagedBean (name = "usuario")
public class Usuario {
	private String nome;
	private String senha;
	


	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}


	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	

	public void acao() {
		System.out.println("Clique do botão");
		System.out.println("Nome: " + nome);
		System.out.println("Matrícula: " + senha);
		System.out.println("CADASTRADO REALIZADO COM SUCESSO!!");
	}
}
