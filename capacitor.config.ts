import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.saeta.saetapp',
  appName: 'Saetapp',
  webDir: 'www',
  server: {
    androidScheme: 'https',
    cleartext: true
  },
  android: {
    allowMixedContent: true
  }
};

export default config;
