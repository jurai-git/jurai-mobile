import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(25, 24, 29, 1),
      appBar: AppBar(
          title: Text("Política de Privacidade", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF387FB9)),
          backgroundColor: Colors.transparent,
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                    "Última atualização: 01 de junho de 2025",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              const SizedBox(height: 20),
                  // Section 1: Introduction
                  _buildSectionTitle("1. Introdução"),
                  _buildSectionContent(
                    "Bem-vindo(a) ao JurAI, uma aplicação desenvolvida para otimizar a gestão de processos administrativos no setor público. Na JurAI, privacidade e segurança são prioridades, e estamos comprometidos com a transparência no tratamento dos dados pessoais dos nossos usuários. Este documento explica como coletamos, usamos, armazenamos e protegemos seus dados, em conformidade com a Lei Geral de Proteção de Dados Pessoais (LGPD - Lei nº 13.709/2018) e o Marco Civil da Internet (Lei nº 12.965/2014).\n\n"
                    "Ao utilizar o JurAI, você confirma que leu, entendeu e concorda com os termos descritos nesta Política de Privacidade. Caso não concorde, recomendamos que não utilize nossos serviços.",
                  ),
                  const SizedBox(height: 20),
                  // Section 2: Dados Coletados
                  _buildSectionTitle("2. Dados Coletados"),
                  _buildSectionContent(
                    "Coletamos apenas os dados necessários para a prestação dos serviços do JurAI. Esses dados incluem:\n\n"
                    "- **Dados de identificação**: Nome, e-mail, CPF, e outras informações fornecidas ao criar uma conta ou realizar login.\n"
                    "- **Dados de autenticação**: Senha (criptografada) e informações de login.\n"
                    "- **Dados de navegação**: Informações coletadas por cookies, como horário de acesso, tipo de dispositivo e endereço IP, para melhorar a experiência do usuário.\n"
                    "- **Dados de uso**: Informações sobre interações com a aplicação, como histórico de ações realizadas, para fins de auditoria e aprimoramento do serviço.\n\n"
                    "Os dados são coletados quando você:\n"
                    "- Cria uma conta ou faz login no JurAI.\n"
                    "- Interage com funcionalidades da aplicação.\n"
                    "- Navega na plataforma, permitindo o uso de cookies (quando aplicável).",
                  ),
                  const SizedBox(height: 20),
                  // Section 3: Finalidade
                  _buildSectionTitle("3. Finalidade do Tratamento de Dados"),
                  _buildSectionContent(
                    "Os dados coletados são utilizados para:\n\n"
                    "- **Autenticação e acesso**: Garantir que apenas usuários autorizados acessem a aplicação.\n"
                    "- **Prestação de serviços**: Permitir o uso das funcionalidades do JurAI, como gestão de processos administrativos.\n"
                    "- **Melhoria da experiência**: Analisar o uso da aplicação para otimizar sua usabilidade e desempenho.\n"
                    "- **Cumprimento legal**: Atender a obrigações legais ou judiciais, como auditorias ou investigações, conforme exigido pela LGPD.\n"
                    "- **Segurança**: Proteger a aplicação contra fraudes ou acessos não autorizados.",
                  ),
                  const SizedBox(height: 20),
                  // Section 4: Compartilhamento
                  _buildSectionTitle("4. Compartilhamento de Dados"),
                  _buildSectionContent(
                    "Seus dados pessoais só serão compartilhados nas seguintes situações:\n\n"
                    "- **Com parceiros ou prestadores de serviço**: Empresas contratadas para suporte técnico ou manutenção da aplicação, sob acordos de confidencialidade.\n"
                    "- **Por exigência legal**: Quando solicitado por ordens judiciais ou para cumprir obrigações legais, como investigações de atividades ilícitas.\n"
                    "- **Com órgãos públicos**: Para fins de auditoria ou monitoramento de políticas públicas, respeitando os limites legais.\n\n"
                    "Não compartilhamos seus dados com terceiros para fins comerciais ou publicitários sem seu consentimento expresso.",
                  ),
                  const SizedBox(height: 20),
                  // Section 5: Armazenamento e Segurança
                  _buildSectionTitle("5. Armazenamento e Segurança"),
                  _buildSectionContent(
                    "- **Armazenamento**: Os dados são armazenados em servidores seguros no Brasil, durante o período necessário para a prestação do serviço ou conforme exigido por lei (art. 15, LGPD).\n"
                    "- **Segurança**: Utilizamos criptografia (SSL/TLS) e outras medidas de segurança para proteger seus dados contra acesso não autorizado, perda ou alteração.\n"
                    "- **Anonimização**: Quando possível, anonimizamos dados para análises internas, garantindo que não sejam vinculados a você.",
                  ),
                  const SizedBox(height: 20),
                  // Section 6: Direitos
                  _buildSectionTitle("6. Seus Direitos"),
                  _buildSectionContent(
                    "De acordo com o artigo 18 da LGPD, você tem os seguintes direitos:\n\n"
                    "- Confirmar a existência de tratamento de seus dados.\n"
                    "- Acessar seus dados pessoais armazenados.\n"
                    "- Corrigir dados incompletos, inexatos ou desatualizados.\n"
                    "- Solicitar a anonimização, bloqueio ou eliminação de dados desnecessários, exceto quando exigido por lei.\n"
                    "- Revogar o consentimento para o tratamento de dados, ciente de que isso pode impactar o uso de algumas funcionalidades.\n"
                    "- Solicitar a portabilidade dos dados a outro serviço, quando tecnicamente viável.\n\n"
                    "Para exercer esses direitos, entre em contato conosco pelo e-mail suporte@jurai.com.br.",
                  ),
                  const SizedBox(height: 20),
                  // Section 7: Cookies
                  _buildSectionTitle("7. Cookies"),
                  _buildSectionContent(
                    "O JurAI utiliza cookies para melhorar a experiência do usuário e garantir o funcionamento adequado da aplicação. Os cookies podem armazenar:\n\n"
                    "- Dados de login para manter a sessão ativa (se você optar por 'Manter-me conectado').\n"
                    "- Informações de navegação, como preferências de idioma ou configurações do dispositivo.\n\n"
                    "Você pode gerenciar os cookies nas configurações do seu navegador, mas desativá-los pode limitar algumas funcionalidades.",
                  ),
                  const SizedBox(height: 20),
                  // Section 8: Atualizações
                  _buildSectionTitle("8. Atualizações desta Política"),
                  _buildSectionContent(
                    "Esta Política de Privacidade pode ser atualizada para refletir mudanças na legislação ou melhorias na aplicação. Alterações significativas serão comunicadas por e-mail ou notificação na plataforma. Recomendamos consultar este documento periodicamente.",
                  ),
                  const SizedBox(height: 20),
                  // Section 9: Responsabilidades
                  _buildSectionTitle("9. Responsabilidades"),
                  _buildSectionContent(
                    "- **Do usuário**: Você é responsável por fornecer dados precisos e verdadeiros e por proteger suas credenciais de acesso.\n"
                    "- **Do JurAI**: Não somos responsáveis por danos causados por códigos maliciosos (como vírus) em seu dispositivo decorrentes da navegação na internet.",
                  ),
                  const SizedBox(height: 20),
                  // Section 10: Contato
                  _buildSectionTitle("10. Contato"),
                  _buildSectionContent(
                    "Para dúvidas, reclamações ou solicitações relacionadas a esta Política de Privacidade, entre em contato pelo e-mail suporte@jurai.com.br ou através do canal de suporte da aplicação.",
                  ),
                  const SizedBox(height: 20),
                  // Section 11: Foro
                  _buildSectionTitle("11. Foro"),
                  _buildSectionContent(
                    "Quaisquer disputas relacionadas a este documento serão processadas pela Justiça Federal, em conformidade com a legislação brasileira.",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      textAlign: TextAlign.justify,
    );
  }
}