// Script para manter menu expandido após navegação
(function() {
    function expandirMenu() {
        var currentPath = window.location.pathname.toLowerCase();
        console.log('Script carregado - URL:', currentPath);

        // Mapeamento: nome do arquivo/servlet -> ID do menu
        var pathToMenu = {
            // Financeiro
            'servletfechadia': 'financeiro',
            'fechadia.jsp': 'financeiro',
            'servletconfdiario': 'financeiro',
            'confdiario.jsp': 'financeiro',
            'servletfechames': 'financeiro',
            'fechames.jsp': 'financeiro',
            'servletdre': 'financeiro',
            'dre.jsp': 'financeiro',
            'servletcontas': 'financeiro',
            'contas.jsp': 'financeiro',
            'servletdespesas': 'financeiro',
            'despesas.jsp': 'financeiro',
            'servletsalarios': 'financeiro',
            'salarios.jsp': 'financeiro',
            'servletvales': 'financeiro',
            'vales.jsp': 'financeiro',

            // Relatório
            'servletrelvenda': 'relatorio',
            'relvenda.jsp': 'relatorio',
            'servletrelmes': 'relatorio',
            'relmes.jsp': 'relatorio',
            'servletcontasdespesasrel': 'relatorio',
            'contasdespesasrel.jsp': 'relatorio',
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

        // Mapeamento específico: qual servlet corresponde a qual JSP
        var servletToJsp = {
            'servletdre': 'dre.jsp',
            'servletrelmes': 'relmes.jsp',
            'servletcontasdespesasrel': 'contasdespesasrel.jsp'
        };

        // Encontra qual menu deve estar ativo
        var menuAtivo = null;
        var pathEncontrado = null;

        // Primeiro tenta encontrar um match exato (path completo)
        for (var path in pathToMenu) {
            var pathParts = currentPath.split('/');
            var lastPart = pathParts[pathParts.length - 1].toLowerCase();

            // Match exato: o path é exatamente o último segmento da URL
            if (lastPart === path || lastPart === path.replace('.jsp', '')) {
                menuAtivo = pathToMenu[path];
                pathEncontrado = path;
                console.log('Match EXATO encontrado:', path);
                break;
            }
        }

        // Se não encontrou match exato, tenta match parcial
        if (!menuAtivo) {
            for (var path in pathToMenu) {
                if (currentPath.indexOf(path) !== -1) {
                    menuAtivo = pathToMenu[path];
                    pathEncontrado = path;
                    console.log('Match PARCIAL encontrado:', path);
                    break;
                }
            }
        }

        console.log('Menu ativo determinado:', menuAtivo, 'Path:', pathEncontrado);
        if (!menuAtivo) {
            console.log('Nenhum menu correspondente encontrado');
            return;
        }

        // Expande o menu
        var menuElement = document.getElementById(menuAtivo);
        if (menuElement) {
            menuElement.classList.add('show');
            console.log('Menu expandido:', menuAtivo);

            // FORÇA o fechamento dos outros menus
            var todosMenus = ['financeiro', 'relatorio', 'auth'];
            for (var i = 0; i < todosMenus.length; i++) {
                if (todosMenus[i] !== menuAtivo) {
                    var outroMenu = document.getElementById(todosMenus[i]);
                    if (outroMenu) {
                        outroMenu.classList.remove('show');
                        console.log('Menu fechado:', todosMenus[i]);

                        // Remove active de todos os links desse menu
                        var outrosLinks = outroMenu.querySelectorAll('a.nav-link.active, li.nav-item.active');
                        for (var j = 0; j < outrosLinks.length; j++) {
                            outrosLinks[j].classList.remove('active');
                        }

                        // Remove active do link pai também
                        var outroPai = document.querySelector('[href="#' + todosMenus[i] + '"]');
                        if (outroPai) {
                            outroPai.classList.remove('active');
                            outroPai.setAttribute('aria-expanded', 'false');
                            var outroPaiLi = outroPai.closest('li.nav-item');
                            if (outroPaiLi) outroPaiLi.classList.remove('active');
                        }
                    }
                }
            }
        }

        // Ativa o link pai do menu
        var parentLink = document.querySelector('[href="#' + menuAtivo + '"]');
        if (parentLink) {
            parentLink.setAttribute('aria-expanded', 'true');
            parentLink.classList.add('active');
            var parentLi = parentLink.closest('li.nav-item');
            if (parentLi) parentLi.classList.add('active');
        }

        // Ativa o submenu específico
        if (menuElement) {
            var subMenuLinks = menuElement.querySelectorAll('a.nav-link');
            for (var i = 0; i < subMenuLinks.length; i++) {
                var link = subMenuLinks[i];
                var href = link.getAttribute('href');
                if (!href) continue;

                var hrefLower = href.toLowerCase();
                console.log('Verificando link:', href);

                // Extrai o nome do servlet do href (ex: ServletDre)
                var servletName = href.split('/').pop().toLowerCase();

                // Verifica se o servlet corresponde ao JSP atual
                var jspCorrespondente = servletToJsp[servletName];

                // Verifica múltiplas condições
                var ativo = false;

                // Condição 1: href está na URL atual
                if (currentPath.indexOf(hrefLower) !== -1) {
                    ativo = true;
                    console.log('Match 1: href está na URL');
                }

                // Condição 2: URL atual está no href
                if (hrefLower.indexOf(currentPath.split('/').pop()) !== -1) {
                    ativo = true;
                    console.log('Match 2: URL está no href');
                }

                // Condição 3: servlet corresponde ao JSP atual
                if (jspCorrespondente && currentPath.indexOf(jspCorrespondente) !== -1) {
                    ativo = true;
                    console.log('Match 3: servlet corresponde ao JSP -', servletName, '->', jspCorrespondente);
                }

                if (ativo) {
                    link.classList.add('active');
                    var parentLi = link.closest('li.nav-item');
                    if (parentLi) parentLi.classList.add('active');
                    console.log('Link ativado:', href);
                    break;
                }
            }
        }
    }

    // Executa quando o DOM estiver pronto
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', expandirMenu);
    } else {
        expandirMenu();
    }

    if (typeof jQuery !== 'undefined') {
        jQuery(document).ready(expandirMenu);
    }
})();