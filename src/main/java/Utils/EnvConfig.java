package Utils;

public final class EnvConfig {

	private EnvConfig() {
	}

	public static String get(String key, String defaultValue) {
		String value = System.getenv(key);
		if (value == null || value.trim().isEmpty()) {
			return defaultValue;
		}
		return value;
	}
}