Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F997820BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 01:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjHTXkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 19:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjHTXko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 19:40:44 -0400
X-Greylist: delayed 21420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Aug 2023 16:40:42 PDT
Received: from smart3-pmg.ufmg.br (smart3-01-pmg.ufmg.br [150.164.64.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65494A4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 16:40:42 -0700 (PDT)
Received: from smart3-pmg.ufmg.br (localhost.localdomain [127.0.0.1])
        by smart3-pmg.ufmg.br (Proxmox) with ESMTP id E7CFE5E7633
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:23:54 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ufmg.br; h=cc
        :content-transfer-encoding:content-type:content-type:date:from
        :from:message-id:mime-version:reply-to:reply-to:subject:subject
        :to:to; s=mail; bh=aB6phz2CCV0fOdUx+FEpXbqcMS5qcYYIVmsV4Zzs0ug=; b=
        VpMuWbQhh2cEwOG8laxY3c3nTXa/SaTCz8SkTlDyJeQoKb4w6/F3nC4QI5IIlm9I
        18be5kvmXiqMPXyv1k5Kw3yEQtxQPxrnfm5IbyypyThFwfUbTiQef+VVze59Im61
        0TeFQrBx2CSZu3CIc4QFuHgLjp7oWVee/rCIGj8R+ddiheASiYJrtQVfbEYAWpdG
        LzpDq4C0Z0b5dK+IEA+8GOcVzhUnZVCir3xa2r4tea3uWLf2L+I2aHcbrjErcdXk
        Kg+7xOGshx2iYIn1U5VrqIY4qJkeihRvWncApuZaq6uEzzpHV2LnSrE8ZPSTBngv
        J58Shd5NC7KMsdbip46Ffw==
Received: from bambu.grude.ufmg.br (bambu.grude.ufmg.br [150.164.64.35])
        by smart3-pmg.ufmg.br (Proxmox) with ESMTP id 472045E296E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:10:26 -0300 (-03)
Received: from ufmg.br ([98.159.234.166])
          by bambu.grude.ufmg.br (IBM Domino Release 10.0.1FP3)
          with ESMTP id 2023082014020201-1068438 ;
          Sun, 20 Aug 2023 14:02:02 -0300 
Reply-To: "Kristine Wellenstein" <inform@calfd.org>
From:   "Kristine Wellenstein" <luanacsg@ufmg.br>
To:     linux-kernel@vger.kernel.org
Subject: [RE]: RE:
Date:   20 Aug 2023 13:01:58 -0400
Message-ID: <20230820130158.2860577B6C0AA326@ufmg.br>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on bambu/UFMG(Release 10.0.1FP3|August 09, 2019) at
 20-08-2023 14:02:02,
        Serialize by Router on bambu/UFMG(Release 10.0.1FP3|August 09, 2019) at 20-08-2023
 14:10:26,
        Serialize complete at 20-08-2023 14:10:26
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
        charset="utf-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sehr geehrter Beg=C3=BCnstigter,

Die EmilyWells Foundation ermutigt Menschen, sich ehrenamtlich f=C3=BCr soz=
iale oder wohlt=C3=A4tige Zwecke zu engagieren und den weniger Gl=C3=BCckli=
chen zu helfen. Lasst uns alle die wichtige Botschaft dieses gro=C3=9Fartig=
en Tages verbreiten und uns f=C3=BCr das bedanken, was wir haben.

Ich bin Kristine Wellenstein, die Gewinnerin des Mega Millions-Jackpots in =
H=C3=B6he von 426 Millionen US-Dollar am 28. Januar. Ich gebe offiziell bek=
annt, dass Sie als einer von f=C3=BCnf Empf=C3=A4ngern einer Spende in H=C3=
=B6he von 2.300.000 ausgew=C3=A4hlt wurden. Dollar von der Emily Wells Foun=
dation.

Diese Spende ist im Gedenken an meinen verstorbenen Enkel, der gerade einen=
 Tag gelebt hat.
F=C3=BCr weitere Informationen antworten Sie bitte auf diese E-Mail.

Beste gr=C3=BC=C3=9Fe:

Kristine Wellenstein
Gr=C3=BCnderin/Vorsitzende: EmilyWells. Stiftung, Schenkung


