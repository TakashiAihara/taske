import { mergeConfig } from 'vitest/config';
import base from './vitest.config';

export default mergeConfig(base, {
  test: {
    include: ['test/**/*.integration-test.ts'],
  },
});
