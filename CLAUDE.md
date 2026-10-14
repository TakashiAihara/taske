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

## MCP Servers

This project is configured with multiple Model Context Protocol (MCP) servers to enhance AI assistance capabilities. Always prefer using MCP servers when available for tasks instead of manual operations.

### Available MCP Servers

Core Utilities:

- fetch - Web content retrieval and markdown extraction
- filesystem - Local file operations (mounted to project workspace)
- time - Time and timezone operations
- playwright - Browser automation and web scraping

Development & Code:

- desktop-commander - File management and terminal command execution
- sequential-thinking - Dynamic problem-solving through thought sequences
- github - GitHub API integration (via Copilot)
- deepwiki - Documentation and knowledge base access

Cloud & Infrastructure:

- aws-core-mcp-server - AWS core services
- aws-documentation - AWS documentation access
- aws-diagram - AWS architecture diagram creation
- aws-terraform - Terraform on AWS best practices
- redis - Redis database operations
- grafana - Monitoring and observability

Productivity & Communication:

- notion - Notion workspace integration
- obsidian - Obsidian knowledge management
- line - LINE messaging platform integration
- docker - Docker operations and container management

### MCP Usage Guidelines

1. Prefer MCP over manual operations - Always check if an MCP server can handle the task
2. Filesystem operations - Use `filesystem` MCP for file operations within the project
3. Web content - Use `fetch` MCP for retrieving web content
4. AWS operations - Use AWS MCP servers for cloud infrastructure tasks
5. Documentation - Use `deepwiki` for accessing comprehensive documentation
6. Browser automation - Use `playwright` MCP for web scraping and testing

### Configuration

MCP servers are configured in `.mcp.json` and run via Docker containers. Most servers use standard Docker flags (`-i`, `--rm`) with the filesystem server having workspace volume mounting for local file access.

## Development Notes

- Use Node.js ≥22.14.0
- Each application has independent package.json with consistent script patterns
- All packages use ES modules (`"type": "module"`)
- Biome configuration is workspace-aware with project-specific settings