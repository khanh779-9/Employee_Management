package dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import Utils.JpaConfig;

import model.User;

public class UserDao {

	private EntityManagerFactory emf = JpaConfig.getEntityManagerFactory();
	private EntityManager em = emf.createEntityManager();

	boolean isLogin = false;

	public boolean getLoginStatus() {
		return isLogin;
	}

	public void setLoginStatus(boolean isLogin) {
		this.isLogin = isLogin;
	}

	public UserDao() {
		em = emf.createEntityManager();
	}

	public User getUserByUsername(String username) {
		User user = null;
		try {
			em.getTransaction().begin();
			user = em.createQuery("SELECT u FROM User u WHERE u.username = :username", User.class)
					.setParameter("username", username).getSingleResult();
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		}
		return user;
	}

	public List<User> getAllUsers() {
		List<User> users = new ArrayList<>();
		try {
			em.getTransaction().begin();
			users = em.createQuery("SELECT u FROM User u", User.class).getResultList();
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		}
		return users;
	}

	public void addUser(User user) {
		try {
			em.getTransaction().begin();
			em.persist(user);
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		}
	}

	public User getUserById(int id) {
		return em.find(User.class, id);
	}

	public void updateUser(User user) {
		try {
			em.getTransaction().begin();
			em.merge(user);
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
			throw e;
		}

	}

	public void deleteUser(int id) {
		try {
			em.getTransaction().begin();
			User user = em.find(User.class, id);
			if (user != null) {
				em.remove(user);
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		}
	}

	public boolean checkLogin(String username, String password) {
		boolean isValid = false;
		try {
			em.getTransaction().begin();
			User user = em
					.createQuery("SELECT u FROM User u WHERE u.username = :username AND u.password = :password",
							User.class)
					.setParameter("username", username).setParameter("password", password).getSingleResult();
			if (user != null) {
				isValid = true;
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		}
		return isValid;
	}
}