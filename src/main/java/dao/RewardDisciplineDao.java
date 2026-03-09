package dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import Utils.JpaConfig;

import model.RewardsDiscipline;

public class RewardDisciplineDao {
	private EntityManagerFactory emf = JpaConfig.getEntityManagerFactory();
	private EntityManager em = emf.createEntityManager();

	public List<RewardsDiscipline> getAll() {
		List<RewardsDiscipline> re= new ArrayList<>();
		try
		{
			re= em.createQuery("SELECT r FROM RewardsDiscipline r", RewardsDiscipline.class).getResultList();
		}
		catch (Exception ex)
		{
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			ex.printStackTrace();
		}
		return re;
	}

	public RewardsDiscipline getById(int id) {
		return em.find(RewardsDiscipline.class, id);
	}

	public void addRewardsDiscipline(RewardsDiscipline r) {
		try {
			em.getTransaction().begin();
			em.persist(r);
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		}
	}

	public void updateRewardsDiscipline(RewardsDiscipline r) {
		try {
			em.getTransaction().begin();
			em.merge(r);
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		}
	}

	public void deleteRewardsDiscipline(int id) {
		try {
			em.getTransaction().begin();
			RewardsDiscipline r = em.find(RewardsDiscipline.class, id);
			if (r != null) {
				em.remove(r);
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
