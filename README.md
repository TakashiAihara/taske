# Directories

```
.
├── apps                  # Base application workspaces
│   └── core              # Core domain (back-end)
│       └── task-organizer-read  # Backend
│       └── task-organizer-write # Back
│           ├── prisma        # Database schema and migration files
│           ├── src           # Main application source code
│           │   ├── sendgrid  # SendGrid-related processing
│           │   ├── tracking  # Email tracking logic
│           │   └── utility   # Utility modules
│           │       ├── Config      # Configuration utilities
│           │       └── HealthCheck # Health check utilities
│           └── test           # Unit and integration tests
├── packages               # Shared codes and database implementation
│   └── shared             # Shared code modules
│       └── types          # Shared TypeScript types
├── testing                # Browser (E2E) testing and manual testing
│   └── api               # Bruno API request collection
└── tooling                # Tool settings for development
    ├── biome            # Configuration for Biome (code formatting and linting)
    └── tsconfig         # Shared TypeScript configurations
```

# Development

## VSCode

### Extension

#### Biome

* `biome.projects` を動作させるには `biomejs.biome` を Pre Release バージョンに変更する必要があります。（2025/03/10 現在）
