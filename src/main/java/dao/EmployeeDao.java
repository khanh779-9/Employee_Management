package dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import Utils.JpaConfig;

import model.Employee;

public class EmployeeDao {
	private EntityManagerFactory emf = JpaConfig.getEntityManagerFactory();
	private EntityManager em = emf.createEntityManager();

	public List<Employee> getAllEmployees() {
		try {
			return em.createQuery("SELECT e FROM Employee e", Employee.class).getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
	}

	public boolean addEmployee(Employee emp) {
		try {
			em.getTransaction().begin();
			em.persist(emp);
			em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
		return false;
	}

	public Employee getEmployeeById(int id) {
		return em.find(Employee.class, id);
	}

	public void updateEmployee(Employee emp) {
		try {
			em.getTransaction().begin();
			em.merge(emp);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public void deleteEmployee(int id) {
		try {
			em.getTransaction().begin();
			Employee emp = em.find(Employee.class, id);
			if (emp != null) {
				em.remove(emp);
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}

}
