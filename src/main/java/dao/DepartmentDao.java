package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import Utils.JpaConfig;

import model.Department;

public class DepartmentDao {
	private EntityManagerFactory emf = JpaConfig.getEntityManagerFactory();
	private EntityManager em = emf.createEntityManager();

	public List<Department> getAllDepartments() {
		return em.createQuery("SELECT d FROM Department d", Department.class).getResultList();
	}

	public void addDepartment(Department dept) {
		try {
			em.getTransaction().begin();
			em.persist(dept);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public Department getDepartmentById(int id) {
		return em.find(Department.class, id);
	}

	public void updateDepartment(Department dept) {
		try {
			em.getTransaction().begin();
			em.merge(dept);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public void deleteDepartment(int id) {
		try {
			em.getTransaction().begin();
			Department dept = em.find(Department.class, id);
			if (dept != null) {
				em.remove(dept);
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}
}
