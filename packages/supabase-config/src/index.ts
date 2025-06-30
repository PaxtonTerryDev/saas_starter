import { createClient, SupabaseClient } from "@supabase/supabase-js";
import config from "@workspace/app-config";
import { Database as db } from "./database.types";

const supabaseUrl = config.supabase.url;
const supabaseAnonKey = config.supabase.anonKey;
const supabaseServiceRoleKey = config.supabase.serviceRoleKey;

if (!supabaseUrl || !supabaseAnonKey || !supabaseServiceRoleKey) {
  throw new Error(
    "Missing Supabase configuration. Please check your environment variables."
  );
}

// Client for general operations (with RLS enabled)
export const supabase: SupabaseClient<db> = createClient(
  supabaseUrl,
  supabaseAnonKey,
  {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  }
);

// Admin client for operations that need to bypass RLS
export const supabaseAdmin: SupabaseClient<db> = createClient(
  supabaseUrl,
  supabaseServiceRoleKey,
  {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  }
);

export type Database = db;
