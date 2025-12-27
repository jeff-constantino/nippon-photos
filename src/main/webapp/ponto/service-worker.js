// Service Worker para o sistema de ponto
// Versão 1.0

const CACHE_NAME = 'saas-ponto-v1';
const urlsToCache = [
  '/ponto/',
  '/ponto/index.jsp',
  '/ponto/registroponto.jsp',
  '/ponto/admin.jsp',
  '/ponto/manifest.json'
];

// Instalação - cacheia os arquivos essenciais
self.addEventListener('install', event => {
  console.log('[Service Worker] Instalando...');
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        console.log('[Service Worker] Cache aberto');
        return cache.addAll(urlsToCache);
      })
      .catch(err => {
        console.error('[Service Worker] Erro ao cachear:', err);
      })
  );
  self.skipWaiting();
});

// Ativação - limpa caches antigos
self.addEventListener('activate', event => {
  console.log('[Service Worker] Ativando...');
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CACHE_NAME) {
            console.log('[Service Worker] Removendo cache antigo:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  self.clients.claim();
});

// Estratégia de cache: Network First com fallback para cache
self.addEventListener('fetch', event => {
  // Ignorar requisições não-GET
  if (event.request.method !== 'GET') {
    return;
  }

  // Ignorar requisições de API que precisam estar sempre atualizadas
  if (event.request.url.includes('/ponto?acao=')) {
    return;
  }

  event.respondWith(
    fetch(event.request)
      .then(response => {
        // Se a resposta for válida, cacheia e retorna
        if (response && response.status === 200) {
          const responseToCache = response.clone();
          caches.open(CACHE_NAME)
            .then(cache => {
              cache.put(event.request, responseToCache);
            });
        }
        return response;
      })
      .catch(() => {
        // Se falhar (offline), tenta buscar do cache
        return caches.match(event.request)
          .then(cachedResponse => {
            if (cachedResponse) {
              console.log('[Service Worker] Servindo do cache:', event.request.url);
              return cachedResponse;
            }
            
            // Se não tiver no cache, retorna página offline
            return caches.match('/ponto/index.jsp');
          });
      })
  );
});

// Sincronização em background (quando voltar online)
self.addEventListener('sync', event => {
  console.log('[Service Worker] Sincronização em background');
  if (event.tag === 'sync-ponto') {
    event.waitUntil(syncPendingRecords());
  }
});

// Função para sincronizar registros pendentes
async function syncPendingRecords() {
  // Aqui você pode implementar lógica para enviar registros
  // que ficaram pendentes quando estava offline
  console.log('[Service Worker] Sincronizando registros pendentes...');
}

// Notificações push (opcional)
self.addEventListener('push', event => {
  const data = event.data ? event.data.json() : {};
  const title = data.title || 'SaaS Ponto';
  const options = {
    body: data.body || 'Nova notificação',
    icon: '/ponto/icon-192.png',
    badge: '/ponto/icon-192.png',
    vibrate: [200, 100, 200],
    data: data.url
  };

  event.waitUntil(
    self.registration.showNotification(title, options)
  );
});

// Quando clica na notificação
self.addEventListener('notificationclick', event => {
  event.notification.close();
  event.waitUntil(
    clients.openWindow(event.notification.data || '/ponto/')
  );
});
