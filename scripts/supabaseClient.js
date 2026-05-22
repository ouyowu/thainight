import { createClient as createSbClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';

const envPath = path.resolve(process.cwd(), '.env.local');
if (fs.existsSync(envPath)) {
  const envBuffer = fs.readFileSync(envPath, 'utf8');
  const lines = envBuffer.split('\n');
  lines.forEach(line => {
    const match = line.match(/^([^=]+)=(.*)$/);
    if (match) {
      const key = match[1].trim();
      const value = match[2].trim();
      // Remove surrounding quotes if present
      const cleanedValue = value.replace(/^['"]|['"]$/g, '');
      process.env[key] = cleanedValue;
    }
  });
}

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!url || !serviceRoleKey) {
  console.error('Missing Supabase environment variables');
  console.error('NEXT_PUBLIC_SUPABASE_URL:', url ? 'set' : 'missing');
  console.error('SUPABASE_SERVICE_ROLE_KEY:', serviceRoleKey ? 'set' : 'missing');
  process.exit(1);
}

export const supabase = createSbClient(url, serviceRoleKey, {
  auth: { persistSession: false, autoRefreshToken: false }
});