Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCC87B7D28
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjJDKar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjJDKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:30:45 -0400
X-Greylist: delayed 3200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 03:30:39 PDT
Received: from correo.hgj.gob.ec (correo.hgj.gob.ec [181.196.185.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8052A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 03:30:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by correo.hgj.gob.ec (Postfix) with ESMTP id 2802840455082;
        Wed,  4 Oct 2023 04:19:36 -0500 (-05)
Received: from correo.hgj.gob.ec ([127.0.0.1])
        by localhost (correo.hgj.gob.ec [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aD4FQbXZcXDX; Wed,  4 Oct 2023 04:19:35 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by correo.hgj.gob.ec (Postfix) with ESMTP id 5FEE540477967;
        Wed,  4 Oct 2023 04:19:35 -0500 (-05)
DKIM-Filter: OpenDKIM Filter v2.10.3 correo.hgj.gob.ec 5FEE540477967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hgj.gob.ec;
        s=AE113AC8-D929-11ED-97A4-E896B0C4411E; t=1696411175;
        bh=mAhvhhVt0FojqIoI5vUL967LmtKhh/nKngvxnrO5ImE=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=nXpEic9nTrKx40EnThY8EhpYONqJ4+LJi3cHqFwN3O3gBT3XgA1DDpLXq7sO1q9Z8
         r35ajXl7LRR4bYNMzuTqbaXzv8mr3+6dK20lFok/FoMMhArFQFq9zYGKeTgcDuFeya
         6PyX/vH44y+cWB0cR+fE29nlzgnY7ZCVHka6hd1xDv99InASaRtdFjPH8kCiP0wQb7
         31hquZlhnLqyCXjYM11yQ4x0AkBz1OezVwkR5c9jngu5nrh8u3DQ0f3DjNTiiYgpWh
         TApvU69F4dUt/G/kMFFhSV7itfvAJRJv0/fkLueBURHKTeGTlAbfkhqytxvu2/b5SZ
         30RauxQpxR+mA==
X-Virus-Scanned: amavisd-new at correo.hgj.gob.ec
Received: from correo.hgj.gob.ec ([127.0.0.1])
        by localhost (correo.hgj.gob.ec [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I6P9k69fG6de; Wed,  4 Oct 2023 04:19:35 -0500 (-05)
Received: from [156.96.56.93] (unknown [156.96.56.93])
        by correo.hgj.gob.ec (Postfix) with ESMTPSA id E5B6640468B25;
        Wed,  4 Oct 2023 04:19:27 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Atenci=C3=B3n_al_cliente?=
To:     Recipients <cesar.pibaque@hgj.gob.ec>
From:   "@zimbra" <cesar.pibaque@hgj.gob.ec>
Date:   Wed, 04 Oct 2023 02:19:15 -0700
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20231004091927.E5B6640468B25@correo.hgj.gob.ec>
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
