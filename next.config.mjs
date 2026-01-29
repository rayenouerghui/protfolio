
const nextConfig = {
  images: {
    unoptimized: true,
  },
  trailingSlash: true,
  eslint: {
    ignoreDuringBuilds: true,
  },
  output: 'export',
  distDir: 'out',
};

export default nextConfig;
