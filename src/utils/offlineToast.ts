/**
 * Mensagem de sucesso "normal" quando online, ou o aviso padrão de que a
 * alteração ficou na fila quando offline — usado depois de qualquer escrita
 * (criar/editar/excluir/concluir) para o usuário nunca ficar em dúvida se
 * algo foi perdido.
 */
export function actionToastMessage(successMessage: string, isOnline: boolean): string {
  return isOnline ? successMessage : "Você está offline. A alteração será sincronizada quando a conexão voltar.";
}
