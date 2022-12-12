/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  typescript: {
    ignoreBuildErrors: true,
  },
  env: {
    NEXT_PUBLIC_API_URL: "https://egator-backend-o67hbk3fqa-uc.a.run.app",
  },
}

module.exports = nextConfig
