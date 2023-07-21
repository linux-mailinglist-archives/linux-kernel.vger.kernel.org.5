Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E85B76556D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjG0N5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjG0N5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:57:36 -0400
Received: from mailsenadoer.gob.ar (mailsenadoer.gob.ar [190.183.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE0D30D2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:57:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mailsenadoer.gob.ar (Postfix) with ESMTP id E4D731844DF9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:32:29 -0300 (-03)
Received: from mailsenadoer.gob.ar ([127.0.0.1])
        by localhost (mailsenadoer.gob.ar [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0S4tczNjTfZ2 for <linux-kernel@vger.kernel.org>;
        Wed, 26 Jul 2023 15:32:29 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
        by mailsenadoer.gob.ar (Postfix) with ESMTP id EDDDE13FE1D2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:24:07 -0300 (-03)
DKIM-Filter: OpenDKIM Filter v2.10.3 mailsenadoer.gob.ar EDDDE13FE1D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailsenadoer.gob.ar;
        s=dkimmailsenadoer; t=1690298648;
        bh=Aor/WLwl4h5zbhGzya8ajVmHiT+79UPpoXAPFDddDh4=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=Qmnbt4WIHnHBJ5iIijQcwRAvYLlauKAkKKgv3B5erumRfZUalD5PmzkLoD+5A4BMY
         R8giOXfP9nydpl+AkvBFeVZXj6goEqEb6BWLoDvs9tgUNFoXMRb2FFSwJiCuidBFum
         PI87YOXIzDJBDHxcrMsI8+y9SVvWlYvNEIEjFRE6mUS/mab213VwhW6d61zYlVWwJ+
         Ujtuw3cfTe4WjiuXW2ac9GsJ4ijjeJ3DFerli3qVnr/v6VeWxb4L+KqO/MQe5e63Br
         S3tr+kEgqGXdxaWGzLU2aWgt+JPP3D6dli5reaAHs8DBezLzWpo8lYzaOfq/1p2xVs
         q94co57N4LJIw==
X-Virus-Scanned: amavisd-new at mailsenadoer.gob.ar
Received: from mailsenadoer.gob.ar ([127.0.0.1])
        by localhost (mailsenadoer.gob.ar [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6DaXhGUv7gMG for <linux-kernel@vger.kernel.org>;
        Tue, 25 Jul 2023 12:24:07 -0300 (-03)
Received: from [192.168.0.166] (unknown [105.8.7.246])
        by mailsenadoer.gob.ar (Postfix) with ESMTPSA id 5D5DF1704DFC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:57:07 -0300 (-03)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?RHVsZcW+aXTDoSB6cHLDoXZhOyDigqwgMiwwMDAsMDAwJzAwIEVVUg==?=
To:     linux-kernel@vger.kernel.org
From:   "Pan Richard Wahl" <santacruz@mailsenadoer.gob.ar>
Date:   Fri, 21 Jul 2023 09:57:03 -0700
Reply-To: info@wahlfoundation.org
Message-Id: <20230721165709.5D5DF1704DFC@mailsenadoer.gob.ar>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
