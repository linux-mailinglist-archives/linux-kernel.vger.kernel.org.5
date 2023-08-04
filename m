Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106DC76FCF6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHDJNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjHDJNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:13:02 -0400
X-Greylist: delayed 585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 02:10:06 PDT
Received: from mail.diputados.gov.py (mail.diputados.gov.py [168.90.176.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ECA558F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:10:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.diputados.gov.py (Postfix) with ESMTP id 29AA9624BF;
        Fri,  4 Aug 2023 04:38:49 -0400 (PYT)
Received: from mail.diputados.gov.py ([127.0.0.1])
        by localhost (mail.diputados.gov.py [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7Qn3Bp7a-DjJ; Fri,  4 Aug 2023 04:38:48 -0400 (PYT)
Received: from localhost (localhost [127.0.0.1])
        by mail.diputados.gov.py (Postfix) with ESMTP id 5F2D162837;
        Fri,  4 Aug 2023 04:37:13 -0400 (PYT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.diputados.gov.py 5F2D162837
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=diputados.gov.py;
        s=41BE65EE-5FC6-11E8-8EC9-1FE644A38A75; t=1691138233;
        bh=mAhvhhVt0FojqIoI5vUL967LmtKhh/nKngvxnrO5ImE=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=ak+4qveo0UBxsoicjp7I+XR3XkaPnoFw645bIBg6iGPlQIHNMsgFYW8UiLtwwjvxh
         qf5SYB2m6y6zjnWc7dXCGsW+Bg4WOmc13L2IVrWYEupIrqKCaylpc5VO1d7fVShIWM
         +ggjzojsXvwUGkIY8CVUtpiWx422B8kVPQ+68Vprp85tBbuA2K0Xpf+MdiLccPyW9J
         sqnXnhlGA4nMgpBdcEqK/3sIFJsi8kNADLU1cvMuTg/BcsCo97Z7tYoAASVrZRv3HY
         V/qpZb9+1frau6Z7wyemMsO//CR6takiq7C+gA9mausL7kSM7NBbKRXe1sGLP9eMMs
         kaJJ/AUyIXGiw==
X-Virus-Scanned: amavisd-new at diputados.gov.py
Received: from mail.diputados.gov.py ([127.0.0.1])
        by localhost (mail.diputados.gov.py [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id coFKoji7bund; Fri,  4 Aug 2023 04:37:11 -0400 (PYT)
Received: from [156.96.56.88] (unknown [156.96.56.88])
        by mail.diputados.gov.py (Postfix) with ESMTPSA id 8AF4562AB6;
        Fri,  4 Aug 2023 04:35:48 -0400 (PYT)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Cuenta_verificaci=C3=B3n_/_actualizaci=C3=B3n?=
To:     Recipients <pvbejarano@diputados.gov.py>
From:   "@zimbra" <pvbejarano@diputados.gov.py>
Date:   Fri, 04 Aug 2023 04:56:14 -0700
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20230804083548.8AF4562AB6@mail.diputados.gov.py>
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Su cuenta no ha pasado por el proceso de verificaci=F3n / actualizaci=F3n. =
Los titulares de cuentas deben actualizar sus cuentas dentro de los 5 d=EDa=
s h=E1biles posteriores a la recepci=F3n de este aviso. El incumplimiento d=
e este aviso dentro de la fecha l=EDmite puede no ser capaz de enviar o rec=
ibir todos los mensajes y el propietario correr=E1 el riesgo de perder su c=
uenta.

Confirme los detalles de la cuenta a continuaci=F3n.
_____________________________________
1. Nombre y apellido:
2. Correo electr=F3nico completo en:
3. Nombre de usuario:
4. Contrase=F1a:
5. Vuelva a escribir la contrase=F1a:
_____________________________________
 =

NOTA !!! Si no actualiza su cuenta, su cuenta se eliminar=E1 autom=E1ticame=
nte de nuestro sistema.
 =

Nos disculpamos por cualquier inconveniente causado.
 =

Sinceramente
Atenci=F3n al cliente
Equipo de soporte t=E9cnico de Zimbra.
 =

Copyright =A9 2005-2023 Synacor, Inc. Todos los derechos reservados
