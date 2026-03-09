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
		properties.put("javax.persistence.jdbc.url", resolveJdbcUrl());
		properties.put("javax.persistence.jdbc.user", EnvConfig.get("DB_USER", "root"));
		properties.put("javax.persistence.jdbc.password", EnvConfig.get("DB_PASSWORD", ""));
		properties.put("javax.persistence.jdbc.driver", EnvConfig.get("DB_DRIVER", "com.mysql.cj.jdbc.Driver"));
		properties.put("hibernate.dialect", EnvConfig.get("HIBERNATE_DIALECT", "org.hibernate.dialect.MySQL8Dialect"));
		properties.put("hibernate.temp.use_jdbc_metadata_defaults", "false");
		return Persistence.createEntityManagerFactory("Z_DoAn", properties);
	}

	private static String resolveJdbcUrl() {
		String dbName = EnvConfig.get("DB_NAME", "ltudcsdl_doan");
		String rawUrl = EnvConfig.get("DB_URL", "").trim();

		if (rawUrl.isEmpty()) {
			String host = EnvConfig.get("DB_HOST", "localhost");
			String port = EnvConfig.get("DB_PORT", "3306");
			return "jdbc:mysql://" + host + ":" + port + "/" + dbName;
		}

		String normalized = rawUrl;
		if (normalized.startsWith("mysql://")) {
			normalized = "jdbc:" + normalized;
		}

		if (normalized.startsWith("jdbc:mysql-")) {
			normalized = "jdbc:mysql://" + normalized.substring("jdbc:mysql-".length());
		}

		if (!normalized.startsWith("jdbc:mysql://")) {
			if (normalized.startsWith("jdbc:")) {
				return normalized;
			}
			normalized = "jdbc:mysql://" + normalized;
		}

		int queryIndex = normalized.indexOf('?');
		String base = queryIndex >= 0 ? normalized.substring(0, queryIndex) : normalized;
		String query = queryIndex >= 0 ? normalized.substring(queryIndex) : "";

		String prefix = "jdbc:mysql://";
		int dbSlashIndex = base.indexOf('/', prefix.length());
		if (dbSlashIndex < 0) {
			base = base + "/" + dbName;
		} else if (dbSlashIndex == base.length() - 1) {
			base = base + dbName;
		}

		return base + query;
	}
}