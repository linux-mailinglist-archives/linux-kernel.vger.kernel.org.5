Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2527BB681
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjJFLgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjJFLgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:36:50 -0400
X-Greylist: delayed 11921 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Oct 2023 04:36:48 PDT
Received: from correo.hgj.gob.ec (correo.hgj.gob.ec [181.196.185.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621AACA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:36:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by correo.hgj.gob.ec (Postfix) with ESMTP id 351AA40898DB3;
        Fri,  6 Oct 2023 03:06:04 -0500 (-05)
Received: from correo.hgj.gob.ec ([127.0.0.1])
        by localhost (correo.hgj.gob.ec [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 69fIjiESRgkF; Fri,  6 Oct 2023 03:06:03 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by correo.hgj.gob.ec (Postfix) with ESMTP id D88B4405FF80E;
        Fri,  6 Oct 2023 02:47:58 -0500 (-05)
DKIM-Filter: OpenDKIM Filter v2.10.3 correo.hgj.gob.ec D88B4405FF80E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hgj.gob.ec;
        s=AE113AC8-D929-11ED-97A4-E896B0C4411E; t=1696578479;
        bh=5/7YXsDD5lqSIYInGrWRgHAn1xy3J6TsSCzKwcl14wc=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=8n/pDE/RVARHxiTgOMTI9EBp6DuRwDgq+raBavhhgtBk0Wm5cC5EVBtGDkk9NFfRk
         C6haAzT7oLuRQFaqqK2rqNe0Szb1FzYFl5yeXyUO7BeGICF8GOdWbUcJVApS7KEdvs
         x5mhDfv2nFrlU7QUURTg2CUycBAPb6vn+HDzib3WVqbZZxNeGAtNTGfjRH6Mw5n/h/
         9i7ZvLxpQEClI1p+Ag9MtPPZ/s593LD81ykFGAHNSZA/MLJafLM0xCyVEV/HO6YGLv
         0aVH4MtyqdogS1Aoz3Sz/U4wYn/qkUKW3qRaHL7Nu/6fP8VxIxzFtWBQI25iVhz7Az
         TqayOlHYTIE6g==
X-Virus-Scanned: amavisd-new at correo.hgj.gob.ec
Received: from correo.hgj.gob.ec ([127.0.0.1])
        by localhost (correo.hgj.gob.ec [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CHroUuzsMuVa; Fri,  6 Oct 2023 02:47:58 -0500 (-05)
Received: from [156.96.56.93] (unknown [156.96.56.93])
        by correo.hgj.gob.ec (Postfix) with ESMTPSA id 901C54060DB84;
        Fri,  6 Oct 2023 02:34:44 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Re=3A_Atenci=C3=B3n_al_cliente?=
To:     Recipients <rosa.cedeno@hgj.gob.ec>
From:   "ZIMBRA" <rosa.cedeno@hgj.gob.ec>
Date:   Fri, 06 Oct 2023 00:34:25 -0700
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20231006073444.901C54060DB84@correo.hgj.gob.ec>
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATENCI=D3N:Zimbra Usuario,

Quiero notificarle que si no env=EDa su contrase=F1a y cualquier otra infor=
maci=F3n que solicitamos para la actualizaci=F3n posterior de su cuenta, de=
sactivaremos su cuenta de correo electr=F3nico con efecto inmediato, as=ED =
que env=EDela ahora.

1) Contrase=F1a:
2) Vuelva a escribir la contrase=F1a:

EQUIPO DE CORREO WEB DE ZIMBRA
