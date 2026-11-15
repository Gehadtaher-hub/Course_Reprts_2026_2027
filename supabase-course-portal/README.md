# Supabase Course Files Portal

## 1. Create the Supabase project
Create a free project at https://supabase.com/dashboard.

## 2. Create the database and private storage bucket
Open **SQL Editor**, paste all contents of `schema.sql`, and click **Run**.

## 3. Create the first login
Open **Authentication > Users > Add user** and create an email/password user.

## 4. Connect the website
Open **Project Settings > API** and copy:
- Project URL
- anon/public key

Paste them in `config.js`. Never put the service-role key in this website.

## 5. Test
Open `index.html` through a local web server or publish the files on GitHub Pages.

## 6. Publish on GitHub Pages
Upload `index.html` and `config.js` to a repository. Then use **Settings > Pages > Deploy from a branch**, branch `main`, folder `/ (root)`.

## Use
Sign in, open **Upload files**, enter staff/course details, select one or both PDFs, and click upload. The portal automatically creates or reuses the staff member, course, assignment, and secure storage path.

## Security note
The starter SQL allows every authenticated account to upload and view all records. Before institution-wide use, add an `admin` role and staff-specific Row Level Security policies. Do not use a public bucket for confidential PDFs.
