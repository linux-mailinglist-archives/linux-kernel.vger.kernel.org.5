Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C189075C716
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGUMrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjGUMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:47:00 -0400
X-Greylist: delayed 127754 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 05:46:56 PDT
Received: from mailsenadoer.gob.ar (mailsenadoer.gob.ar [190.183.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406A2D56;
        Fri, 21 Jul 2023 05:46:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mailsenadoer.gob.ar (Postfix) with ESMTP id 8607613E70F2;
        Wed, 19 Jul 2023 20:22:23 -0300 (-03)
Received: from mailsenadoer.gob.ar ([127.0.0.1])
        by localhost (mailsenadoer.gob.ar [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yEZnGTSqF8zs; Wed, 19 Jul 2023 20:22:23 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
        by mailsenadoer.gob.ar (Postfix) with ESMTP id 6657D13E71AA;
        Wed, 19 Jul 2023 20:20:22 -0300 (-03)
DKIM-Filter: OpenDKIM Filter v2.10.3 mailsenadoer.gob.ar 6657D13E71AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailsenadoer.gob.ar;
        s=dkimmailsenadoer; t=1689808822;
        bh=Aor/WLwl4h5zbhGzya8ajVmHiT+79UPpoXAPFDddDh4=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=Y+H7bn1uKPFHClAzE6Rt3a9iEGfFIglZ3gKlxUR530Vk+kqkhRCCzKDtTXf9LNwh3
         hvb/0+LNPFxb7aqfN7tODIwuw8KQLnxoelzZtNX36OmHOGk4L4Hbp7yQn+FcicXdC8
         yTnd7Hp6+V3kXSO4X/O9MxU/X/QnVOlpxo83p1NIMul+PvP8kqSDAfJYNSGo0aG2C3
         ooZZNxmODlzrhHp0mNc96bOSQHVGZ2SmtWPx86Kkt6a4/uFo1Ci/cvvOx837ZhklWh
         bE5T2l3Q6b3oxektzZiEXp22W3rxoBL6VaLugIjxbXGB//hhF0jUBmtuXJuulk+OBH
         wX6zoaDDBIiKg==
X-Virus-Scanned: amavisd-new at mailsenadoer.gob.ar
Received: from mailsenadoer.gob.ar ([127.0.0.1])
        by localhost (mailsenadoer.gob.ar [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U_25FNL1zjpd; Wed, 19 Jul 2023 20:20:22 -0300 (-03)
Received: from [192.168.0.37] (unknown [41.216.203.66])
        by mailsenadoer.gob.ar (Postfix) with ESMTPSA id 2FB2113E6E6C;
        Wed, 19 Jul 2023 20:18:13 -0300 (-03)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?RHVsZcW+aXTDoSB6cHLDoXZhOyDigqwgMiwwMDAsMDAwJzAwIEVVUg==?=
To:     Recipients <santacruz@mailsenadoer.gob.ar>
From:   "Pan Richard Wahl" <santacruz@mailsenadoer.gob.ar>
Date:   Wed, 19 Jul 2023 16:18:04 -0700
Reply-To: info@wahlfoundation.org
Message-Id: <20230719231814.2FB2113E6E6C@mailsenadoer.gob.ar>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L5,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drah=C3=BD pr=C3=ADteli,

Jsem pan Richard Wahl, mega v=C3=ADtez 533 milionu $ v jackpotu Mega Millio=
ns. Daruji 5 n=C3=A1hodne vybran=C3=BDm lidem. Pokud obdr=C5=BE=C3=ADte ten=
to e-mail, byl v=C3=A1=C5=A1 e-mail vybr=C3=A1n po roztocen=C3=AD koule. Ve=
t=C5=A1inu sv=C3=A9ho majetku jsem rozdal rade charitativn=C3=ADch organiza=
c=C3=AD a organizac=C3=AD. Dobrovolne jsem se rozhodl venovat v=C3=A1m c=C3=
=A1stku =E2=82=AC 2,000,000'00 EUR jako jednomu z 5 vybran=C3=BDch, abych s=
i overil sv=C3=A9 v=C3=BDhry prostrednictv=C3=ADm n=C3=AD=C5=BEe uveden=C3=
=A9 str=C3=A1nky YouTube.

VID=C3=8DTE ME ZDE https://www.youtube.com/watch?v=3Dtne02ExNDrw

TOTO JE V=C3=81=C5=A0 DAROVAC=C3=8D K=C3=93D: [DFDW43034RW2023]

Odpovezte na tento e-mail a uvedte k=C3=B3d daru: info@wahlfoundation.org

Douf=C3=A1m, =C5=BEe v=C3=A1m a va=C5=A1=C3=AD rodine udel=C3=A1m radost.

Pozdravy,
Pan Richard Wahl
