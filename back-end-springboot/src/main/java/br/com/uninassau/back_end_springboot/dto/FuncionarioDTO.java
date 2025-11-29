package br.com.uninassau.back_end_springboot.dto;

import lombok.Data;

import java.util.UUID;

@Data
public class FuncionarioDTO {
    private UUID id;

    private String nome;

    private String email;

    private String senha;
}
