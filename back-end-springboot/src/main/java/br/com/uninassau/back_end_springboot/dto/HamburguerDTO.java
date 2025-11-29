package br.com.uninassau.back_end_springboot.dto;

import lombok.Data;
import java.util.UUID;

@Data
public class HamburguerDTO {
    private UUID id;
    private String nome;
    private Float preco;
}
