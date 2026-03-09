package dao;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import Utils.JpaConfig;

import model.Report;

public class ReportDao {

	EntityManagerFactory emf= JpaConfig.getEntityManagerFactory();
	EntityManager em = emf.createEntityManager();


	public ReportDao()
	{

	}


	public List<Report> getAllReports()
	{
		List<Report> repos= new ArrayList<>();
		try
		{
			em.getTransaction().begin();
			repos= em.createQuery("SELECT r FROM Report r", Report.class).getResultList();
		}
		catch (Exception ex)
		{

		}
		return repos;
	}

	public void addReport(Report re)
	{
		try
		{
			em.getTransaction().begin();
			em.persist(re);
			em.getTransaction().commit();
		}
		catch (Exception ex)
		{
			if(em.getTransaction().isActive())
			{
				em.getTransaction().rollback();
			}
		}
	}

	public void deleteReport(int reportIndex)
	{
		try
		{
			em.getTransaction().begin();
			Report re= findById(reportIndex);
			if(re!=null) {
				em.remove(re);
			}
			em.getTransaction().commit();
		}
		catch (Exception ex)
		{
			if(em.getTransaction().isActive())
			{
				em.getTransaction().rollback();
			}
		}
	}

	public void updateReport(Report re)
	{
		try
		{
			em.getTransaction().begin();
			em.merge(re);
			em.getTransaction().commit();
		}
		catch (Exception ex)
		{
			if(em.getTransaction().isActive())
			{
				em.getTransaction().rollback();
			}
		}
	}

	public Report findById(int reportIndex)
	{
		Report re= null;
		try
		{
			em.getTransaction().begin();
			re= em.find(Report.class, reportIndex);
			em.getTransaction().commit();
		}
		catch (Exception ex)
		{
			if(em.getTransaction().isActive())
			{
				em.getTransaction().rollback();
			}
		}
		return re;
	}
}
