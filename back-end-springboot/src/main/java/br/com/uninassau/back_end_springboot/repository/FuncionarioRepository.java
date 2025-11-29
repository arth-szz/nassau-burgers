package br.com.uninassau.back_end_springboot.repository;

import br.com.uninassau.back_end_springboot.model.Funcionario;
import br.com.uninassau.back_end_springboot.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface FuncionarioRepository extends JpaRepository<Funcionario, UUID> {
    Optional<Funcionario> findByEmail(String email);
}
