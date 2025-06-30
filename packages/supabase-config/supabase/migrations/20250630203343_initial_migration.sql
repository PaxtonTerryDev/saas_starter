create table "public"."tenant_profiles" (
    "id" uuid not null default gen_random_uuid(),
    "tenant_id" uuid not null,
    "subdomain" character varying not null,
    "display_name" character varying not null,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


alter table "public"."tenant_profiles" enable row level security;

create table "public"."tenants" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone default now()
);


alter table "public"."tenants" enable row level security;

create table "public"."user_profiles" (
    "user_id" uuid not null,
    "tenant_id" uuid,
    "given_name" character varying,
    "family_name" character varying,
    "email" character varying,
    "date_of_birth" date,
    "updated_at" timestamp with time zone not null default now(),
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."user_profiles" enable row level security;

CREATE UNIQUE INDEX tenant_profiles_pkey ON public.tenant_profiles USING btree (id);

CREATE UNIQUE INDEX tenant_profiles_subdomain_key ON public.tenant_profiles USING btree (subdomain);

CREATE UNIQUE INDEX tenants_pkey ON public.tenants USING btree (id);

CREATE UNIQUE INDEX user_profiles_pkey ON public.user_profiles USING btree (user_id);

alter table "public"."tenant_profiles" add constraint "tenant_profiles_pkey" PRIMARY KEY using index "tenant_profiles_pkey";

alter table "public"."tenants" add constraint "tenants_pkey" PRIMARY KEY using index "tenants_pkey";

alter table "public"."user_profiles" add constraint "user_profiles_pkey" PRIMARY KEY using index "user_profiles_pkey";

alter table "public"."tenant_profiles" add constraint "tenant_profiles_subdomain_key" UNIQUE using index "tenant_profiles_subdomain_key";

alter table "public"."tenant_profiles" add constraint "tenant_profiles_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."tenant_profiles" validate constraint "tenant_profiles_tenant_id_fkey";

alter table "public"."user_profiles" add constraint "user_profiles_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."user_profiles" validate constraint "user_profiles_id_fkey";

alter table "public"."user_profiles" add constraint "user_profiles_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON UPDATE CASCADE ON DELETE SET NULL not valid;

alter table "public"."user_profiles" validate constraint "user_profiles_tenant_id_fkey";

grant delete on table "public"."tenant_profiles" to "anon";

grant insert on table "public"."tenant_profiles" to "anon";

grant references on table "public"."tenant_profiles" to "anon";

grant select on table "public"."tenant_profiles" to "anon";

grant trigger on table "public"."tenant_profiles" to "anon";

grant truncate on table "public"."tenant_profiles" to "anon";

grant update on table "public"."tenant_profiles" to "anon";

grant delete on table "public"."tenant_profiles" to "authenticated";

grant insert on table "public"."tenant_profiles" to "authenticated";

grant references on table "public"."tenant_profiles" to "authenticated";

grant select on table "public"."tenant_profiles" to "authenticated";

grant trigger on table "public"."tenant_profiles" to "authenticated";

grant truncate on table "public"."tenant_profiles" to "authenticated";

grant update on table "public"."tenant_profiles" to "authenticated";

grant delete on table "public"."tenant_profiles" to "service_role";

grant insert on table "public"."tenant_profiles" to "service_role";

grant references on table "public"."tenant_profiles" to "service_role";

grant select on table "public"."tenant_profiles" to "service_role";

grant trigger on table "public"."tenant_profiles" to "service_role";

grant truncate on table "public"."tenant_profiles" to "service_role";

grant update on table "public"."tenant_profiles" to "service_role";

grant delete on table "public"."tenants" to "anon";

grant insert on table "public"."tenants" to "anon";

grant references on table "public"."tenants" to "anon";

grant select on table "public"."tenants" to "anon";

grant trigger on table "public"."tenants" to "anon";

grant truncate on table "public"."tenants" to "anon";

grant update on table "public"."tenants" to "anon";

grant delete on table "public"."tenants" to "authenticated";

grant insert on table "public"."tenants" to "authenticated";

grant references on table "public"."tenants" to "authenticated";

grant select on table "public"."tenants" to "authenticated";

grant trigger on table "public"."tenants" to "authenticated";

grant truncate on table "public"."tenants" to "authenticated";

grant update on table "public"."tenants" to "authenticated";

grant delete on table "public"."tenants" to "service_role";

grant insert on table "public"."tenants" to "service_role";

grant references on table "public"."tenants" to "service_role";

grant select on table "public"."tenants" to "service_role";

grant trigger on table "public"."tenants" to "service_role";

grant truncate on table "public"."tenants" to "service_role";

grant update on table "public"."tenants" to "service_role";

grant delete on table "public"."user_profiles" to "anon";

grant insert on table "public"."user_profiles" to "anon";

grant references on table "public"."user_profiles" to "anon";

grant select on table "public"."user_profiles" to "anon";

grant trigger on table "public"."user_profiles" to "anon";

grant truncate on table "public"."user_profiles" to "anon";

grant update on table "public"."user_profiles" to "anon";

grant delete on table "public"."user_profiles" to "authenticated";

grant insert on table "public"."user_profiles" to "authenticated";

grant references on table "public"."user_profiles" to "authenticated";

grant select on table "public"."user_profiles" to "authenticated";

grant trigger on table "public"."user_profiles" to "authenticated";

grant truncate on table "public"."user_profiles" to "authenticated";

grant update on table "public"."user_profiles" to "authenticated";

grant delete on table "public"."user_profiles" to "service_role";

grant insert on table "public"."user_profiles" to "service_role";

grant references on table "public"."user_profiles" to "service_role";

grant select on table "public"."user_profiles" to "service_role";

grant trigger on table "public"."user_profiles" to "service_role";

grant truncate on table "public"."user_profiles" to "service_role";

grant update on table "public"."user_profiles" to "service_role";


