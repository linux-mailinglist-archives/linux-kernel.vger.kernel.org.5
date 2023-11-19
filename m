Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE517F076B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjKSQVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:21:13 -0500
X-Greylist: delayed 5427 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Nov 2023 08:21:09 PST
Received: from correo.hgj.gob.ec (correo.hgj.gob.ec [181.196.185.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9514CC4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 08:21:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by correo.hgj.gob.ec (Postfix) with ESMTP id 2F19640EFC0AF;
        Sun, 19 Nov 2023 08:59:52 -0500 (-05)
Received: from correo.hgj.gob.ec ([127.0.0.1])
        by localhost (correo.hgj.gob.ec [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id a09Q_5oXgsTH; Sun, 19 Nov 2023 08:59:51 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by correo.hgj.gob.ec (Postfix) with ESMTP id B3DFD4093FC8F;
        Sun, 19 Nov 2023 08:57:06 -0500 (-05)
DKIM-Filter: OpenDKIM Filter v2.10.3 correo.hgj.gob.ec B3DFD4093FC8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hgj.gob.ec;
        s=AE113AC8-D929-11ED-97A4-E896B0C4411E; t=1700402226;
        bh=mAhvhhVt0FojqIoI5vUL967LmtKhh/nKngvxnrO5ImE=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=xTRdMVgORjp50vqnsETEIguZnALRt1DbTFIvRauXpyX2EruVgY9jLj6ObrHY3zEmT
         DeEdbp+sZPwuif7zIheoVdGOpNaQ/hYFpZ864J4gSu9gy69yDeCFg70yL3DRWcsBDN
         liwlj8U1qKjkV7KFRV2HSnqKZxpLNWP1wCpN7OCWIPRri3Xt82zZkfyepezJmQBgSE
         A8EPLyC+4klF4TDRivmP4aGDrMz9ASBrm6fxSS3vWY4XifqLCPJsOd64lbvN59c+XR
         /DFPtF7BCuT7gd2ApLW5b2opa0JTJGwxVXpe1pe18Zan+vBMhn3w0FMc48h1p6Awro
         ilhhZu4N341Ig==
X-Virus-Scanned: amavisd-new at correo.hgj.gob.ec
Received: from correo.hgj.gob.ec ([127.0.0.1])
        by localhost (correo.hgj.gob.ec [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lZBhThmtGcQc; Sun, 19 Nov 2023 08:57:06 -0500 (-05)
Received: from [23.146.243.12] (unknown [23.146.243.12])
        by correo.hgj.gob.ec (Postfix) with ESMTPSA id 7293340D81CCA;
        Sun, 19 Nov 2023 08:54:28 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Se requiere respuesta urgente.
To:     Recipients <sully.mera@hgj.gob.ec>
From:   "ZIMBRA" <sully.mera@hgj.gob.ec>
Date:   Sun, 19 Nov 2023 05:54:47 -0800
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20231119135428.7293340D81CCA@correo.hgj.gob.ec>
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
