package dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import Utils.JpaConfig;

import model.Attendance;

public class AttendanceDao {
	private EntityManagerFactory emf = JpaConfig.getEntityManagerFactory();
	private EntityManager em = emf.createEntityManager();

	public List<Attendance> getAll() {
		List<Attendance> list = new ArrayList<>();
		try {
			em.getTransaction().begin();
			list = em.createQuery("SELECT a FROM Attendance a", Attendance.class).getResultList();
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
		return list;
	}

	public void add(Attendance a) {
		try {
			em.getTransaction().begin();
			em.persist(a);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public void update(Attendance a) {
		try {
			em.getTransaction().begin();
			em.merge(a);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public void delete(int id) {
		try {
			em.getTransaction().begin();
			Attendance a = em.find(Attendance.class, id);
			if (a != null) {
				em.remove(a);
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public Attendance getAttendanceById(int id) {
		Attendance a = em.find(Attendance.class, id);
		return a;
	}
}