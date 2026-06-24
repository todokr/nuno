import { createSystem, defaultConfig, defineConfig } from '@chakra-ui/react';

// Chakra UI v3 のテーマ。旧 extendTheme の global styles を globalCss で再現する。
const config = defineConfig({
  globalCss: {
    body: {
      bg: '#eeeae4',
      color: '#444',
    },
    a: {
      color: '#354e59',
      textDecoration: 'underline',
      _hover: {
        textDecoration: 'none',
      },
    },
  },
});

export const system = createSystem(defaultConfig, config);
