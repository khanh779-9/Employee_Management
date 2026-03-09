package Utils;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public final class JpaConfig {

	private static final EntityManagerFactory EMF = buildEntityManagerFactory();

	private JpaConfig() {
	}

	public static EntityManagerFactory getEntityManagerFactory() {
		return EMF;
	}

	private static EntityManagerFactory buildEntityManagerFactory() {
		Map<String, String> properties = new HashMap<>();
		properties.put("javax.persistence.jdbc.url", EnvConfig.get("DB_URL", "jdbc:mysql://localhost:3306/ltudcsdl_doan"));
		properties.put("javax.persistence.jdbc.user", EnvConfig.get("DB_USER", "root"));
		properties.put("javax.persistence.jdbc.password", EnvConfig.get("DB_PASSWORD", ""));
		properties.put("javax.persistence.jdbc.driver", EnvConfig.get("DB_DRIVER", "com.mysql.cj.jdbc.Driver"));
		properties.put("hibernate.dialect", EnvConfig.get("HIBERNATE_DIALECT", "org.hibernate.dialect.MySQL8Dialect"));
		properties.put("hibernate.temp.use_jdbc_metadata_defaults", "false");
		return Persistence.createEntityManagerFactory("Z_DoAn", properties);
	}
}