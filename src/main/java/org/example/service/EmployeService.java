package org.example.service;

import org.example.entity.Employe;
import org.example.repository.EmployeRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EmployeService {

    private final EmployeRepository employeRepository;

    public EmployeService(EmployeRepository employeRepository) {
        this.employeRepository = employeRepository;
    }

    // Liste tous les employés
    public List<Employe> findAll() {
        return employeRepository.findAll();
    }

    // Trouve un employé par id
    public Optional<Employe> findById(Integer id) {
        return employeRepository.findById(id);
    }
    
    // Sauvegarde un employé (create ou update)
    public Employe save(Employe employe) {
        return employeRepository.save(employe);
    }

    // Supprimer un employé
    public void deleteById(Integer id) {
        employeRepository.deleteById(id);
    }
}
