// Script para manter menu expandido após navegação
(function() {
    // Previne execução múltipla
    if (window.menuJsExecutado) {
        console.log('Script já foi executado, ignorando...');
        return;
    }
    window.menuJsExecutado = true;

    // BLOQUEIO PREVENTIVO: Impede Bootstrap de abrir múltiplos menus
    document.addEventListener('DOMContentLoaded', function() {
        var todosMenus = ['financeiro', 'relatorio', 'auth'];

        // Remove show de todos os menus IMEDIATAMENTE
        for (var i = 0; i < todosMenus.length; i++) {
            var menu = document.getElementById(todosMenus[i]);
            if (menu && menu.classList.contains('show')) {
                menu.classList.remove('show');
                console.log('🚫 Bloqueio preventivo:', todosMenus[i]);
            }
        }
    });

    // Executa IMEDIATAMENTE (não espera DOMContentLoaded)
    if (document.getElementById('financeiro')) {
        var todosMenus = ['financeiro', 'relatorio', 'auth'];
        for (var i = 0; i < todosMenus.length; i++) {
            var menu = document.getElementById(todosMenus[i]);
            if (menu && menu.classList.contains('show')) {
                menu.classList.remove('show');
                console.log('🚫 Bloqueio IMEDIATO:', todosMenus[i]);
            }
        }
    }

    function expandirMenu() {
        var currentPath = window.location.pathname.toLowerCase();
        console.log('=== INÍCIO SCRIPT MENU ===');
        console.log('URL atual:', currentPath);

        // PREVENÇÃO IMEDIATA: Fecha tudo antes mesmo de começar
        var todosMenus = ['financeiro', 'relatorio', 'auth'];
        for (var i = 0; i < todosMenus.length; i++) {
            var menu = document.getElementById(todosMenus[i]);
            if (menu) {
                menu.classList.remove('show');
                var elementos = menu.querySelectorAll('.active');
                for (var j = 0; j < elementos.length; j++) {
                    elementos[j].classList.remove('active');
                }
            }
        }

        // Mapeamento PRECISO: path -> menu (mais específico primeiro)
        var pathToMenu = {
            // Financeiro - ORDEM IMPORTA: mais específico primeiro
            'servletcontas': 'financeiro',
            'contas.jsp': 'financeiro',
            'servletfechadia': 'financeiro',
            'fechadia.jsp': 'financeiro',
            'servletconfdiario': 'financeiro',
            'confdiario.jsp': 'financeiro',
            'servletfechames': 'financeiro',
            'fechames.jsp': 'financeiro',
            'servletdre': 'financeiro',
            'dre.jsp': 'financeiro',
            'servletdespesas': 'financeiro',
            'despesas.jsp': 'financeiro',
            'servletsalarios': 'financeiro',
            'salarios.jsp': 'financeiro',
            'servletvales': 'financeiro',
            'vales.jsp': 'financeiro',

            // Relatório - ORDEM IMPORTA: mais específico primeiro
            'servletcontasdespesasrel': 'relatorio', // MAIS ESPECÍFICO
            'contasdespesasrel.jsp': 'relatorio',    // MAIS ESPECÍFICO
            'servletrelvenda': 'relatorio',
            'relvenda.jsp': 'relatorio',
            'servletrelmes': 'relatorio',
            'relmes.jsp': 'relatorio',
            'servletcomparativoyoy': 'relatorio',
            'comparativoyoy.jsp': 'relatorio',
            'servletranking': 'relatorio',
            'ranking.jsp': 'relatorio',

            // Admin
            'servletusuariocontroller': 'auth',
            'usuario.jsp': 'auth',
            'servletconfig': 'auth',
            'config.jsp': 'auth',
            'servletcontroleribbon': 'auth',
            'controleribbon.jsp': 'auth',
            'servletmedidasdisciplinares': 'auth',
            'medidasdisciplinares.jsp': 'auth'
        };

        // Mapeamento servlet -> JSP para correspondência reversa
        var servletToJsp = {
            'servletcontas': 'contas.jsp',
            'servletcontasdespesasrel': 'contasdespesasrel.jsp',
            'servletdre': 'dre.jsp',
            'servletrelmes': 'relmes.jsp'
        };

        // Extrai o último segmento da URL
        var pathParts = currentPath.split('/');
        var lastPart = pathParts[pathParts.length - 1].toLowerCase();
        console.log('Último segmento da URL:', lastPart);

        // Encontra o menu correto - ORDEM IMPORTA
        var menuAtivo = null;
        var pathEncontrado = null;

        // 1. Tenta match EXATO primeiro (prioridade máxima)
        for (var path in pathToMenu) {
            if (lastPart === path || lastPart === path.replace('.jsp', '')) {
                menuAtivo = pathToMenu[path];
                pathEncontrado = path;
                console.log('✓ Match EXATO:', path, '-> menu:', menuAtivo);
                break;
            }
        }

        // 2. Se não achou exato, tenta match PARCIAL (apenas se não for ambíguo)
        if (!menuAtivo) {
            // Ordena paths por tamanho (mais longo primeiro) para priorizar matches mais específicos
            var pathsOrdenados = Object.keys(pathToMenu).sort(function(a, b) {
                return b.length - a.length;
            });

            for (var i = 0; i < pathsOrdenados.length; i++) {
                var path = pathsOrdenados[i];
                if (currentPath.indexOf(path) !== -1) {
                    menuAtivo = pathToMenu[path];
                    pathEncontrado = path;
                    console.log('✓ Match PARCIAL:', path, '-> menu:', menuAtivo);
                    break;
                }
            }
        }

        if (!menuAtivo) {
            console.log('✗ Nenhum menu correspondente');
            return;
        }

        console.log('Menu escolhido:', menuAtivo);

        // FECHA TODOS os menus primeiro (reset completo)
        var todosMenus = ['financeiro', 'relatorio', 'auth'];
        console.log('Fechando todos os menus...');

        for (var i = 0; i < todosMenus.length; i++) {
            var menuId = todosMenus[i];
            var menu = document.getElementById(menuId);

            if (menu) {
                menu.classList.remove('show');

                // Remove active de TODOS os elementos do menu
                var elementos = menu.querySelectorAll('.active');
                for (var j = 0; j < elementos.length; j++) {
                    elementos[j].classList.remove('active');
                }

                // Remove active do link pai
                var linkPai = document.querySelector('[href="#' + menuId + '"]');
                if (linkPai) {
                    linkPai.classList.remove('active');
                    linkPai.setAttribute('aria-expanded', 'false');
                    var liPai = linkPai.closest('li.nav-item');
                    if (liPai) liPai.classList.remove('active');
                }

                console.log('  - Fechado:', menuId);
            }
        }

        // ABRE apenas o menu correto
        var menuElement = document.getElementById(menuAtivo);
        if (menuElement) {
            menuElement.classList.add('show');
            console.log('✓ Menu aberto:', menuAtivo);

            // Ativa o link pai
            var parentLink = document.querySelector('[href="#' + menuAtivo + '"]');
            if (parentLink) {
                parentLink.setAttribute('aria-expanded', 'true');
                parentLink.classList.add('active');
                var parentLi = parentLink.closest('li.nav-item');
                if (parentLi) parentLi.classList.add('active');
                console.log('✓ Link pai ativado');
            }

            // ATIVA o submenu específico
            var subMenuLinks = menuElement.querySelectorAll('a.nav-link');
            var linkAtivado = false;

            for (var i = 0; i < subMenuLinks.length; i++) {
                var link = subMenuLinks[i];
                var href = link.getAttribute('href');
                if (!href) continue;

                var hrefLower = href.toLowerCase();
                var servletName = href.split('/').pop().toLowerCase();
                var jspCorrespondente = servletToJsp[servletName];

                var ativo = false;

                console.log('  Analisando link:', servletName, '| URL:', lastPart);

                // REGRA ESPECIAL: ServletContas != ServletContasDespesasRel
                if (lastPart === 'servletcontas' || lastPart === 'contas.jsp') {
                    // Só ativa se o link for EXATAMENTE ServletContas
                    if (servletName === 'servletcontas') {
                        ativo = true;
                        console.log('  ✓ Match EXATO para Contas (Financeiro)');
                    }
                }
                // REGRA ESPECIAL: ServletContasDespesasRel
                else if (lastPart === 'servletcontasdespesasrel' || lastPart === 'contasdespesasrel.jsp') {
                    // Só ativa se o link for EXATAMENTE ServletContasDespesasRel
                    if (servletName === 'servletcontasdespesasrel') {
                        ativo = true;
                        console.log('  ✓ Match EXATO para Contas e Despesas (Relatório)');
                    }
                }
                // Outros casos
                else {
                    // 1. Match exato do servlet na URL
                    if (lastPart === servletName) {
                        ativo = true;
                        console.log('  ✓ Match servlet exato:', servletName);
                    }
                    // 2. Servlet corresponde ao JSP atual
                    else if (jspCorrespondente && lastPart === jspCorrespondente.replace('.jsp', '')) {
                        ativo = true;
                        console.log('  ✓ Match JSP correspondente:', jspCorrespondente);
                    }
                    // 3. URL contém o servlet (apenas se não for ambíguo e for longo o suficiente)
                    else if (currentPath.indexOf(servletName) !== -1 && servletName.length > 10) {
                        ativo = true;
                        console.log('  ✓ Match parcial (específico):', servletName);
                    }
                }

                if (ativo) {
                    link.classList.add('active');
                    var li = link.closest('li.nav-item');
                    if (li) li.classList.add('active');
                    console.log('✓ Link ativado:', href);
                    linkAtivado = true;
                    break; // Ativa apenas UM link
                }
            }

            if (!linkAtivado) {
                console.log('✗ Nenhum link específico ativado');
            }
        }

        console.log('=== FIM SCRIPT MENU ===');
    }

    // Executa apenas uma vez quando o DOM estiver pronto
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', expandirMenu);
    } else {
        expandirMenu();
    }

    // ADICIONAL: Previne que cliques em links do menu abram outros menus
    setTimeout(function() {
        var todosLinksMenu = document.querySelectorAll('.sidebar a[data-bs-toggle="collapse"]');

        for (var i = 0; i < todosLinksMenu.length; i++) {
            todosLinksMenu[i].addEventListener('click', function(e) {
                console.log('Click detectado no menu:', this.getAttribute('href'));

                // Fecha todos os outros menus quando um for clicado
                var targetId = this.getAttribute('href').substring(1);
                var todosMenus = ['financeiro', 'relatorio', 'auth'];

                for (var j = 0; j < todosMenus.length; j++) {
                    if (todosMenus[j] !== targetId) {
                        var outroMenu = document.getElementById(todosMenus[j]);
                        if (outroMenu) {
                            // Remove a classe show
                            outroMenu.classList.remove('show');

                            // Remove TODOS os active desse menu
                            var elementosAtivos = outroMenu.querySelectorAll('.active');
                            for (var k = 0; k < elementosAtivos.length; k++) {
                                elementosAtivos[k].classList.remove('active');
                            }

                            // Remove active do link pai do menu
                            var linkPaiOutro = document.querySelector('[href="#' + todosMenus[j] + '"]');
                            if (linkPaiOutro) {
                                linkPaiOutro.classList.remove('active');
                                linkPaiOutro.setAttribute('aria-expanded', 'false');
                                var liPaiOutro = linkPaiOutro.closest('li.nav-item');
                                if (liPaiOutro) liPaiOutro.classList.remove('active');
                            }

                            console.log('Fechando menu ao clicar (e removendo active):', todosMenus[j]);
                        }
                    }
                }
            });
        }
        console.log('Listeners de click instalados nos menus');
    }, 500);

    // FORCE: Monitora apenas MÚLTIPLOS menus abertos simultaneamente (não interfere com cliques)
    var ultimaVerificacao = Date.now();
    setInterval(function() {
        // Só verifica se já passou tempo suficiente desde o último click (evita interferir com navegação)
        if (Date.now() - ultimaVerificacao < 2000) {
            return;
        }

        var menusAbertos = [];
        var todosMenus = ['financeiro', 'relatorio', 'auth'];

        // Conta quantos menus estão abertos
        for (var i = 0; i < todosMenus.length; i++) {
            var menu = document.getElementById(todosMenus[i]);
            if (menu && menu.classList.contains('show')) {
                menusAbertos.push(todosMenus[i]);
            }
        }

        // Se há MAIS DE UM menu aberto, fecha os incorretos
        if (menusAbertos.length > 1) {
            console.log('⚠️ MÚLTIPLOS MENUS ABERTOS:', menusAbertos);

            var currentPath = window.location.pathname.toLowerCase();
            var lastPart = currentPath.split('/').pop();

            // Determina qual menu DEVERIA estar aberto
            var menuCorreto = null;

            if (lastPart.indexOf('servletcontas') === 0 && lastPart !== 'servletcontasdespesasrel') {
                menuCorreto = 'financeiro';
            } else if (lastPart === 'servletcontasdespesasrel' || lastPart === 'contasdespesasrel.jsp') {
                menuCorreto = 'relatorio';
            } else if (['servletfechadia', 'servletconfdiario', 'servletfechames', 'servletdre',
                'servletdespesas', 'servletsalarios', 'servletvales'].indexOf(lastPart) !== -1) {
                menuCorreto = 'financeiro';
            } else if (['servletrelvenda', 'servletrelmes', 'servletcomparativoyoy', 'servletranking'].indexOf(lastPart) !== -1) {
                menuCorreto = 'relatorio';
            } else if (['servletusuariocontroller', 'servletconfig', 'servletcontroleribbon',
                'servletmedidasdisciplinares'].indexOf(lastPart) !== -1) {
                menuCorreto = 'auth';
            }

            if (menuCorreto) {
                // Fecha apenas os menus que NÃO deveriam estar abertos
                for (var i = 0; i < menusAbertos.length; i++) {
                    if (menusAbertos[i] !== menuCorreto) {
                        var menu = document.getElementById(menusAbertos[i]);
                        if (menu) {
                            menu.classList.remove('show');

                            // Remove TODOS os active desse menu
                            var elementosAtivos = menu.querySelectorAll('.active');
                            for (var k = 0; k < elementosAtivos.length; k++) {
                                elementosAtivos[k].classList.remove('active');
                            }

                            // Remove active do link pai
                            var linkPai = document.querySelector('[href="#' + menusAbertos[i] + '"]');
                            if (linkPai) {
                                linkPai.classList.remove('active');
                                linkPai.setAttribute('aria-expanded', 'false');
                                var liPai = linkPai.closest('li.nav-item');
                                if (liPai) liPai.classList.remove('active');
                            }

                            console.log('  → Fechou:', menusAbertos[i], '(removeu active)');
                        }
                    }
                }
            }
        }
    }, 500); // Verifica a cada 0.5 segundo

    // Reseta o timer ao detectar clicks
    document.addEventListener('click', function() {
        ultimaVerificacao = Date.now();
    });
})();