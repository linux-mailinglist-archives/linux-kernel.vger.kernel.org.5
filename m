Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545DE7754E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjHIIOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjHIIOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:14:45 -0400
X-Greylist: delayed 1130 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 01:14:41 PDT
Received: from mail.diputados.gov.py (mail.diputados.gov.py [168.90.176.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A404010FB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 01:14:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.diputados.gov.py (Postfix) with ESMTP id 4021563156;
        Wed,  9 Aug 2023 00:13:42 -0400 (PYT)
Received: from mail.diputados.gov.py ([127.0.0.1])
        by localhost (mail.diputados.gov.py [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TTZfgdRTe0MJ; Wed,  9 Aug 2023 00:13:41 -0400 (PYT)
Received: from localhost (localhost [127.0.0.1])
        by mail.diputados.gov.py (Postfix) with ESMTP id 1D9FA6314A;
        Wed,  9 Aug 2023 00:13:41 -0400 (PYT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.diputados.gov.py 1D9FA6314A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=diputados.gov.py;
        s=41BE65EE-5FC6-11E8-8EC9-1FE644A38A75; t=1691554421;
        bh=6XVwCfoGlKc0QXyi5ZKgtKS8u1FZmT8zuCclg0zeK6s=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=QrZhx2beBpod8Sz6slNTt0YX8rUyaOmB6LdntOiBdzJeB5dUOTkjfN5H/GjsFGs/q
         yoIeSKaK5ZffSM6MqgSLkZE/2A0A615ortIxB4tYAs9M/U2E14IjhP5rNMVmzFXqAm
         CB3VMOXH3FzZTsiNomVLNCmpM7fxFqK4vwEdNVljF7skTgdCkVyTu7aWtOln8Yvf7s
         UZU9rmohyjwOcuC7bsbjVU34uN1auwqMt+Xu+9ux30mgamjPVHAVlfU+kP5z0EJJN1
         b6dOMK22wz/VO/sslucJG0iBpC0ydCpondsuYly5Gum1OQM2Oz2i5QQePThUL6Pahp
         kRXqFx2ULWggQ==
X-Virus-Scanned: amavisd-new at diputados.gov.py
Received: from mail.diputados.gov.py ([127.0.0.1])
        by localhost (mail.diputados.gov.py [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h8nJMWCxKCVk; Wed,  9 Aug 2023 00:13:41 -0400 (PYT)
Received: from [156.96.56.88] (unknown [156.96.56.88])
        by mail.diputados.gov.py (Postfix) with ESMTPSA id 8C77363135;
        Wed,  9 Aug 2023 00:13:36 -0400 (PYT)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: EQUIPO DE CORREO WEB DE ZIMBRA
To:     Recipients <diego_candia@diputados.gov.py>
From:   "@zimbra" <diego_candia@diputados.gov.py>
Date:   Wed, 09 Aug 2023 00:44:20 -0700
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20230809041336.8C77363135@mail.diputados.gov.py>
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_PSBL,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: diputados.gov.py]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [156.96.56.88 listed in zen.spamhaus.org]
        *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [168.90.176.51 listed in psbl.surriel.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [webmasterzimbra1[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATENCI=D3N:

Quiero notificarle que si no env=EDa su contrase=F1a y cualquier otra infor=
maci=F3n que solicitamos para la actualizaci=F3n posterior de su cuenta, de=
sactivaremos su cuenta de correo electr=F3nico con efecto inmediato, as=ED =
que env=EDela ahora.

1) Contrase=F1a:
2) Vuelva a escribir la contrase=F1a:

EQUIPO DE CORREO WEB DE ZIMBRA
