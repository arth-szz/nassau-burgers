package br.com.uninassau.back_end_springboot.repository;

import br.com.uninassau.back_end_springboot.model.Hamburguer;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface HamburguerRepository extends JpaRepository<Hamburguer, UUID> {
    boolean existsByNome(String nome);
}
