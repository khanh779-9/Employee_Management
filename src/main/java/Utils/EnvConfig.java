package Utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public final class EnvConfig {

	private static final Map<String, String> DOT_ENV = loadDotEnv();

	private EnvConfig() {
	}

	public static String get(String key, String defaultValue) {
		String systemValue = System.getenv(key);
		if (systemValue != null && !systemValue.trim().isEmpty()) {
			return systemValue;
		}

		String dotEnvValue = DOT_ENV.get(key);
		if (dotEnvValue != null) {
			return dotEnvValue;
		}

		return defaultValue;
	}

	private static Map<String, String> loadDotEnv() {
		Path envPath = Paths.get(System.getProperty("user.dir"), ".env");
		if (!Files.exists(envPath)) {
			return Collections.emptyMap();
		}

		Map<String, String> values = new HashMap<>();
		try (BufferedReader reader = Files.newBufferedReader(envPath, StandardCharsets.UTF_8)) {
			String line;
			while ((line = reader.readLine()) != null) {
				String trimmed = line.trim();
				if (trimmed.isEmpty() || trimmed.startsWith("#") || !trimmed.contains("=")) {
					continue;
				}

				int splitIndex = trimmed.indexOf('=');
				String key = trimmed.substring(0, splitIndex).trim();
				String value = trimmed.substring(splitIndex + 1).trim();
				values.put(key, value);
			}
		} catch (IOException ex) {
			ex.printStackTrace();
		}

		return values;
	}
}