package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import Utils.JpaConfig;

import model.Leave;

public class LeaveDao {
	private EntityManagerFactory emf = JpaConfig.getEntityManagerFactory();
	private EntityManager em = emf.createEntityManager();

	public List<Leave> getAllLeaves() {
		return em.createQuery("SELECT l FROM Leave l", Leave.class).getResultList();
	}

	public void addLeave(Leave leave) {
		try {
			em.getTransaction().begin();
			em.persist(leave);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public void updateLeave(Leave leave) {
		try {
			em.getTransaction().begin();
			em.merge(leave);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public void deleteLeave(int id) {
		try {
			em.getTransaction().begin();
			Leave leave = em.find(Leave.class, id);
			if (leave != null) {
				em.remove(leave);
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public Leave getById(int id) {
		return em.find(Leave.class, id);
	}
}
