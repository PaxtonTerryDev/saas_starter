import dotenv from "dotenv";
import path from "path";

dotenv.config({
  path: [
    path.resolve(process.cwd(), ".env.local"),
    path.resolve(process.cwd(), ".env"),
    path.resolve(__dirname, "../.env.local"),
    path.resolve(__dirname, "../.env"),
  ],
});

function env(env_var: string, required: boolean = true): string {
  const conf = process.env[env_var];
  if (!conf && required) {
    throw new Error(`Missing required env variable ${env_var}`);
  }
  return conf ?? "";
}

interface AppConfig {
  server: {
    port: number;
    nodeEnv: string;
    isDevelopment: boolean;
    isProduction: boolean;
  };
  cors: {
    origins: string[];
  };
  rateLimit: {
    windowMs: number;
    maxRequests: number;
  };
  supabase: {
    url: string;
    anonKey: string;
    serviceRoleKey: string;
    jwtSecret: string;
  };
  ai: {
    openaiApiKey: string;
    maxTokens: number;
    temperature: number;
    model: string;
  };
  app: {
    name: string;
    version: string;
    description: string;
  };
}

const config: AppConfig = {
  server: {
    port: parseInt(env("PORT") || "3001", 10),
    nodeEnv: env("NODE_ENV") || "development",
    isDevelopment: env("NODE_ENV") === "development",
    isProduction: env("NODE_ENV") === "production",
  },
  cors: {
    origins:
      env("NODE_ENV") === "production"
        ? env("CORS_ORIGINS")?.split(",") || []
        : ["http://localhost:3000", "http://localhost:8080"],
  },
  rateLimit: {
    windowMs: parseInt("900000", 10), // 15 minutes
    maxRequests: parseInt("100", 10),
  },
  supabase: {
    url: env("SUPABASE_URL"),
    anonKey: env("SUPABASE_ANON_KEY"),
    serviceRoleKey: env("SUPABASE_SERVICE_ROLE_KEY"),
    jwtSecret: env("SUPABASE_JWT_SECRET"),
  },
  ai: {
    openaiApiKey: env("OPEN_AI_API_KEY"),
    maxTokens: 1000,
    temperature: 0.7,
    model: "gpt-3.5-turbo",
  },
  app: {
    name: "Saas Starter",
    version: "1.0.0",
    description:
      "A starter template for SaaS web applications utilizing subdomain routing with a nextjs frontend and supabase backend.",
  },
};

// Validation function for required environment variables
export const validateConfig = () => {
  const requiredEnvVars: { [key: string]: any } = {};

  // Only validate required vars based on environment
  if (config.server.isProduction) {
    requiredEnvVars.SUPABASE_URL = config.supabase.url;
    requiredEnvVars.SUPABASE_SERVICE_ROLE_KEY = config.supabase.serviceRoleKey;
    requiredEnvVars.OPENAI_API_KEY = config.ai.openaiApiKey;
  }

  const missingVars = Object.entries(requiredEnvVars)
    .filter(([_, value]) => !value)
    .map(([key, _]) => key);

  if (missingVars.length > 0) {
    throw new Error(
      `Missing required environment variables: ${missingVars.join(", ")}`
    );
  }
};

// Helper functions for common config access patterns
export const isDevelopment = () => config.server.isDevelopment;
export const isProduction = () => config.server.isProduction;
export const getPort = () => config.server.port;
export const getCorsOrigins = () => config.cors.origins;

export default config;
