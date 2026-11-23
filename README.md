# rotav2-osrm

Servidor de rotas (OSRM) do ROTAV3 com o mapa do Brasil inteiro. Substitui o servidor público
do OSRM, que é só para uso não comercial.

- **Action "Preparar mapa do Brasil"** (`.github/workflows/preparar.yml`): baixa o mapa do Brasil
  do OpenStreetMap (Geofabrik), prepara para rotas de carro (`osrm-extract`, `osrm-partition`,
  `osrm-customize`, algoritmo MLD), mede tempo e memória, testa uma rota em Guarulhos e
  São Paulo → Recife e publica a imagem `ghcr.io/hesantss-pixel/rotav2-osrm:latest`. Roda à mão e
  todo dia 3 de cada mês. O resumo de cada execução mostra as medidas.
- **Dockerfile**: a imagem que o Railway roda. Variáveis: `PORT` (padrão 5000) e `OSRM_MMAP=1`
  (lê o mapa do disco: menos memória, um pouco mais lento).

## No Railway

1. No projeto do ROTAV3: **New → Docker Image** → `ghcr.io/hesantss-pixel/rotav2-osrm:latest`.
2. Nome do serviço: `osrm`. Não precisa de domínio público: o servidor do ROTAV3 fala com ele pela
   rede interna (`osrm.railway.internal`).
3. No serviço do servidor do ROTAV3, variável
   `OSRM_URL=http://osrm.railway.internal:5000/table/v1/driving` e `OSRM_LIMIT=500`.
   O traçado (`/route`) e o km pelo GPS (`/match`) usam o mesmo endereço sozinhos.

## Licença dos dados

Mapa © colaboradores do OpenStreetMap, sob a Open Database License (ODbL 1.0):
https://www.openstreetmap.org/copyright. O OSRM é software livre (licença BSD-2).
