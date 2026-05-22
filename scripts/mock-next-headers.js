// Mock for next/headers to allow the Supabase server.ts to be imported in a non-Next.js environment
export const cookies = () => {
  return {
    getAll: () => [],
    setAll: () => {}
  };
};