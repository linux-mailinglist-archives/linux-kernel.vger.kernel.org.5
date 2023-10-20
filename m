Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A687D0A79
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbjJTIWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJTIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:22:10 -0400
X-Greylist: delayed 897 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Oct 2023 01:22:06 PDT
Received: from correo.hgj.gob.ec (correo.hgj.gob.ec [181.196.185.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84119119
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:22:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by correo.hgj.gob.ec (Postfix) with ESMTP id 75E5B4048E688;
        Fri, 20 Oct 2023 02:53:51 -0500 (-05)
Received: from correo.hgj.gob.ec ([127.0.0.1])
        by localhost (correo.hgj.gob.ec [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QHgfwWdx0IFB; Fri, 20 Oct 2023 02:53:50 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by correo.hgj.gob.ec (Postfix) with ESMTP id 9CF944048F3A6;
        Fri, 20 Oct 2023 02:53:50 -0500 (-05)
DKIM-Filter: OpenDKIM Filter v2.10.3 correo.hgj.gob.ec 9CF944048F3A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hgj.gob.ec;
        s=AE113AC8-D929-11ED-97A4-E896B0C4411E; t=1697788430;
        bh=mAhvhhVt0FojqIoI5vUL967LmtKhh/nKngvxnrO5ImE=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=oiebwtYmDcLM64OunHQuxbdvuNdxJS+/iKba50tyZp9A6lWfyYeIzC9mSFWVCE5Mh
         ZuRJXEK3QLt4b2qYuKIHDaam2LOBo6UCxrVsDW1hhtAyKmpukZFa8A0tKZJx2+/Gmj
         p4xEuf1NddlBIMWVhi2BOmmqqrhLJBuFMlo+K2yl9i/wAA4naVpIps4pG7EAyhm0vb
         XYP0AsdRdTIOXsdIgXpc0DoLaSq7n1wkK6LXZ7U2Yq+kso99w+ujotAgT709CxXKD2
         2+ZcxgxNA+q2MlIGVGsrR2kQ1WvTQOXthju9rAM4tS5Ar9V9OTQmOMNRJYTRv8Zh6x
         3hhE1hmroaV2g==
X-Virus-Scanned: amavisd-new at correo.hgj.gob.ec
Received: from correo.hgj.gob.ec ([127.0.0.1])
        by localhost (correo.hgj.gob.ec [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jan24jBQHdEK; Fri, 20 Oct 2023 02:53:50 -0500 (-05)
Received: from [23.146.243.38] (unknown [23.146.243.38])
        by correo.hgj.gob.ec (Postfix) with ESMTPSA id 53E664048E686;
        Fri, 20 Oct 2023 02:53:43 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?QVRFTkNJw5NO?=
To:     Recipients <rocio.choez@hgj.gob.ec>
From:   "zimbra" <rocio.choez@hgj.gob.ec>
Date:   Fri, 20 Oct 2023 00:53:35 -0700
Reply-To: franyeoman101@gmail.com
Message-Id: <20231020075343.53E664048E686@correo.hgj.gob.ec>
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
