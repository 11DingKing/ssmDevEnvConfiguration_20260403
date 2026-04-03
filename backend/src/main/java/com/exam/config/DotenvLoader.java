package com.exam.config;

import io.github.cdimascio.dotenv.Dotenv;
import io.github.cdimascio.dotenv.DotenvEntry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class DotenvLoader implements ServletContextListener {

    private static final Logger log = LoggerFactory.getLogger(DotenvLoader.class);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            Dotenv dotenv = Dotenv.configure()
                    .ignoreIfMissing()
                    .load();

            for (DotenvEntry entry : dotenv.entries()) {
                String key = entry.getKey();
                String value = entry.getValue();
                
                if (System.getProperty(key) == null && System.getenv(key) == null) {
                    System.setProperty(key, value);
                    log.info("Loaded environment variable from .env: {}", key);
                }
            }
            
            log.info(".env file loaded successfully (if present)");
        } catch (Exception e) {
            log.warn("Failed to load .env file: {}", e.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
