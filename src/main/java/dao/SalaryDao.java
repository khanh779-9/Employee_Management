package dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import Utils.JpaConfig;

import model.Salary;

public class SalaryDao {

	private EntityManagerFactory emf = JpaConfig.getEntityManagerFactory();
	private EntityManager em = emf.createEntityManager();

	public SalaryDao() {

	}

	public List<Salary> getAllSalaries() {
		List<Salary> salaries = new ArrayList<>();
		try {
			em.getTransaction().begin();
			salaries = em.createQuery("SELECT s FROM Salary s", Salary.class).getResultList();
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		}
		return salaries;

	}

	public void addSalary(Salary salary) {
		try {
			em.getTransaction().begin();
			em.persist(salary);
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		}
	}

	public Salary getSalaryById(int id) {
		return em.find(Salary.class, id);
	}

	public void updateSalary(Salary salary) {
		try {
			em.getTransaction().begin();
			em.merge(salary);
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
			throw e;
		}
	}

	public void deleteSalary(int id) {
		try {
			em.getTransaction().begin();
			Salary salary = em.find(Salary.class, id);
			if (salary != null) {
				em.remove(salary);
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();

		}
	}
}