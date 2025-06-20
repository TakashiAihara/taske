# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Architecture

Taske is a monorepo task management application with a CQRS (Command Query Responsibility Segregation) architecture:

- **Core Domain**: Two NestJS microservices using CQRS pattern
  - `task-organizer-read`: Query/read operations (port 3000)
  - `task-organizer-write`: Command/write operations (port 3000)
- **User Interface**: Next.js web application with tRPC API layer
- **Database**: CockroachDB with Prisma ORM
- **Shared Libraries**: Common types, schemas, and database access patterns

## Essential Commands

### Development Setup

- Install dependencies: `pnpm install`
- Start development servers: `pnpm start:dev`
- Build entire project: `pnpm build`

### Testing

- Run all tests: `pnpm test`
- Run unit tests: `pnpm test:unit`
- Run integration tests: `pnpm test:integration`
- Run tests with coverage: `pnpm test:cov`
- Run single test file: `pnpm test -- path/to/test.test.ts`

### Code Quality

- Format code: `pnpm format:write`
- Check formatting: `pnpm format:check`
- Lint and fix: `pnpm lint:write`
- Check linting: `pnpm lint:check`
- Type checking: `pnpm type:check`
- Run all analysis: `pnpm analyze:write`

### Database Operations

- Generate Prisma client: `pnpm db:generate`
- Run migrations: `pnpm db:migrate`
- Deploy migrations: `pnpm db:migrate:deploy`
- Database studio: `pnpm db:studio`
- Seed database: `pnpm db:seed`

### Docker Development

- Use `docker-compose.yml` for local development with services
- Database runs on configurable port (default 5432)

## Package Manager

- **Required**: pnpm 10.6.3
- **Forbidden**: npm and yarn are explicitly blocked
- Uses pnpm workspaces with catalog for dependency management

## Code Standards (from copilot-instructions.md)

- Follow existing code design and conventions
- Apply "Clean Code" best practices
- Add meaningful comments explaining intent and background
- Use JSDoc for functions
- Reference existing implementations when creating new features

## Tooling

- **Code Quality**: Biome (replaces ESLint + Prettier)
- **Testing**: Vitest
- **Build**: SWC (NestJS), Next.js native builder
- **Type System**: TypeScript with strictest configuration
- **Database**: Prisma with CockroachDB
- **API**: tRPC for type-safe client-server communication

## Workspace Structure

```text
apps/
├── core/
│   ├── task-organizer-read/    # Read-side microservice
│   └── task-organizer-write/   # Write-side microservice
└── user/
    └── web/                    # Next.js frontend
packages/
├── db/                         # Prisma schema and client
├── env/                        # Environment configuration
└── shared/
    ├── schemas/                # Zod validation schemas
    └── types/                  # Shared TypeScript types
tooling/
├── biome/                      # Code formatting/linting config
└── tsconfig/                   # Shared TypeScript configs
```

## Domain Model

Currently implements a simple Task entity with:

- `id`: Auto-increment primary key
- `name`: Task name (indexed)
- `createdAt`/`updatedAt`: Timestamps

## Development Notes

- Use Node.js ≥22.14.0
- Each application has independent package.json with consistent script patterns
- All packages use ES modules (`"type": "module"`)
- Biome configuration is workspace-aware with project-specific settings