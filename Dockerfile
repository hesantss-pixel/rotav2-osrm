# Servidor de rotas do ROTAV3: OSRM com o mapa do Brasil já preparado (pasta dados/,
# gerada pela Action "Preparar mapa do Brasil"). Mapa © colaboradores do OpenStreetMap (ODbL).
FROM ghcr.io/project-osrm/osrm-backend:v5.27.1
COPY dados/ /data/
# PORT vem do Railway (padrão 5000). OSRM_MMAP=1 lê o mapa do disco em vez de carregar tudo
# na memória (gasta menos memória, responde um pouco mais devagar). OSRM_IP=:: se a rede interna
# do Railway pedir IPv6.
ENV PORT=5000
EXPOSE 5000
CMD ["sh", "-c", "exec osrm-routed --algorithm mld --ip ${OSRM_IP:-0.0.0.0} --port ${PORT:-5000} --max-table-size 1000 --max-matching-size 2000 --max-viaroute-size 2000 ${OSRM_MMAP:+--mmap} /data/brasil.osrm"]
