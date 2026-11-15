create extension if not exists pgcrypto;

create table if not exists public.staff (
  id uuid primary key default gen_random_uuid(),
  full_name text not null unique,
  email text unique,
  created_at timestamptz not null default now()
);

create table if not exists public.courses (
  id uuid primary key default gen_random_uuid(),
  course_code text,
  course_name text not null,
  created_at timestamptz not null default now(),
  unique(course_code, course_name)
);

create table if not exists public.staff_courses (
  id uuid primary key default gen_random_uuid(),
  staff_id uuid not null references public.staff(id) on delete cascade,
  course_id uuid not null references public.courses(id) on delete cascade,
  academic_year text not null,
  semester text not null,
  unique(staff_id, course_id, academic_year, semester)
);

create table if not exists public.course_files (
  id uuid primary key default gen_random_uuid(),
  assignment_id uuid not null references public.staff_courses(id) on delete cascade,
  file_type text not null check (file_type in ('course_results','course_survey','other')),
  display_name text not null,
  storage_path text not null unique,
  created_at timestamptz not null default now()
);

alter table public.staff enable row level security;
alter table public.courses enable row level security;
alter table public.staff_courses enable row level security;
alter table public.course_files enable row level security;

create policy "authenticated read staff" on public.staff for select to authenticated using (true);
create policy "authenticated read courses" on public.courses for select to authenticated using (true);
create policy "authenticated read assignments" on public.staff_courses for select to authenticated using (true);
create policy "authenticated read files" on public.course_files for select to authenticated using (true);

create policy "authenticated insert staff" on public.staff for insert to authenticated with check (true);
create policy "authenticated insert courses" on public.courses for insert to authenticated with check (true);
create policy "authenticated insert assignments" on public.staff_courses for insert to authenticated with check (true);
create policy "authenticated insert files" on public.course_files for insert to authenticated with check (true);
create policy "authenticated delete files" on public.course_files for delete to authenticated using (true);

insert into storage.buckets (id, name, public)
values ('course-files', 'course-files', false)
on conflict (id) do nothing;

create policy "authenticated upload course PDFs"
on storage.objects for insert to authenticated
with check (bucket_id = 'course-files');

create policy "authenticated read course PDFs"
on storage.objects for select to authenticated
using (bucket_id = 'course-files');

create policy "authenticated delete course PDFs"
on storage.objects for delete to authenticated
using (bucket_id = 'course-files');
