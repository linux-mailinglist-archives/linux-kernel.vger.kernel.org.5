Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C417B3EE4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjI3Hz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 03:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3HzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 03:55:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580DEDD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 00:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1696060500; x=1696665300; i=frank-w@public-files.de;
 bh=QzUTGFm+fyQlDNRotteAOBG/4ebGcwE5l/KdrOTlHGc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:References;
 b=R/s+fzvfQDb4tPOoWn/f0yZz3fsstVxeoSPAsiwiLDIYK9ifVbUA7KzrtkHFlbWtLNc0CEB5007
 +d1eP8Mz3Ys3uFa7f5sfnZiJnu1zEDDpst7MoHjtIVuLDLR18+ddop3MoIq14RcDaoEccBCl+0nSQ
 PCY152SPf+1FJwYFSH50W7MEihpEZ6EDLKiePX4vVAlLDxPiKHrQDzC06SveR7xrVrhk+txFwnt+8
 i0YcRS6jjAsJaud8Mo+KEMHGRT8hPW93F0NhPaqkRLcBqN2mYUHWYStfTdH1nvzP4y0XVv9Uti/Od
 NbxxeUtt9rTuNR9QnhcPXc2I05UEIypFLZQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.152.33]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiU3-1rDgqn1Bkb-00U0nP; Sat, 30
 Sep 2023 09:55:00 +0200
Date:   Sat, 30 Sep 2023 09:55:00 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org
CC:     nfraprado@collabora.com, wenst@chromium.org,
        matthias.bgg@gmail.com, robh@kernel.org, amergnat@baylibre.com,
        arnd@arndb.de
Subject: Re: [PATCH] MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
References: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
Message-ID: <52BBF3AC-ED0B-4B5B-8773-E7C3E0DBED73@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o1G3x05zu0TFCCHbeK2KUw2yl4D8cXVN/J+/B7vxO/P/6N6GEb5
 U//iwjR4kxM0qCnorj0L2dp/gOxfPAUhV5lJlOMeY1dnbqcQpDrIHcUTPU71td+NIta+4f3
 vY1cgCa5Kfgtk/90nJBpLPmh6JC7wXBrUmpKPliPMUjPCneWLd1YBDCBiHzEstVBVnC+YTu
 ggoDZM3WQThhQAvmD0vAw==
UI-OutboundReport: notjunk:1;M01:P0:lGucr4hleHI=;9wQfcWL9wonTfudhTxZlEUX55B1
 PGRwYMwhY13kB5wLTlpgSDHIIGTc8OPlba1e2u4TrgsGwDaIrO9Tag0f4aLLtvEGXc9Z+67l1
 KehNm6OQWdrOZvhn13GgqLh485hchpyT9eJszpHZMhBJB/e7AlnzfXOzzii6TKMSyOnJYFQdY
 KT0wZUQIfpKJv2OO5gal2+5lh3oBGVZznryyrRA3lEywBHz7j+s7sM21nQJysWlsuZ8oOIaTY
 4aSPvxrdMg4qRUsNV91Wumd41bapmrDDstfuFz0z+j4sO5KXPDd/bGOBcRCnKXpYLMmwnvf6r
 38jNHMyImUzrpfkhVPHVPKAA4bgLJH6LK4w7cldKy2zMyxmzBScaXmXgGToI0azU+ZuHsV64f
 TbswwBR4KMrNu7fErTMdHjf5koLZrPxtJlo14m4wvz5TgkeG76hbdzKlo4C7Scfp1fIH+7Ljp
 wNBb1VGr9wxuK+vU9OlFR4ApSTVCskZ3k1KNj8fevnziTZzpy8ShCbo8i80W+yyTXOKUa+Kdp
 gQZVQZ7BhdEt+DCPoFmE8sziXKt2iAvBS7t4IeIqi2cKzWVubLk1cBmO+o6e0pZmV794QgwfK
 TBzx9YPqEteJrmEeuwBYzt9ZzMVEbq7utw8wPa2f+ZyBYXvp7D6sCtt4e7vupt7bAsrckekke
 WSxD2+kQEn942byDmirbUOldqc7YXf+xLIw7zYzbr8HIrRmHP3scr27CIqkQN9QMvDhpEmejM
 QqwSyALk6SzxqPz7OkGcj5ac+uHXSsxzVHFPUzGc15MzlTPxXiT6kSOSZhp5brX57derSkr9R
 eYb8PwlWcEHIZcv0HMYKz0XmOq3kJNKhEEhwgEgWIbxyTziabP9usBoL3xDq9zFw+O0vj0WW1
 pixvwkArc4WfKqqEjKx7ufYWZ5Z17QW1R/kEOE7MCXSF9X5xjO415ljC2iVBi8rmt894GaoS6
 /kjVAju6/XZNqBodXDqOAfMHw+8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 29=2E September 2023 10:20:09 MESZ schrieb AngeloGioacchino Del Regno <a=
ngelogioacchino=2Edelregno@collabora=2Ecom>:
>I am a top reviewer mainly for MediaTek SoC related patches in most
>subsystems and I've also been upstreaming both improvements, fixes
>and new drivers and devicetrees when required=2E
>
>The MediaTek scene saw a generous increase in number of patches that
>are sent to the lists every week, increasing the amount of required
>efforts to maintain the MTK bits overall, and we will possibly see
>even more of that=2E
>
>For this reason, and also because of suggestions and encouragement
>coming from the community, I'm stepping up to be a co-maintainer of
>MediaTek SoCs support=2E
>
>Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino=2Edelregno@co=
llabora=2Ecom>
>---
>
>P=2ES=2E: I tried to reach to Matthias for almost two months, but I could=
n't
>find any way to talk to him and he has been unresponsive on the mailing
>lists as well=2E
>
>P=2EP=2ES=2E: This also comes after Rob Herring's suggestion to have myse=
lf as
>a MediaTek SoC co-maintainer [1] and support from other people=2E
>
>[1]: https://lore=2Ekernel=2Eorg/all/20230804225813=2E12493-1-robh@kernel=
=2Eorg/
>

Hi,

Thank you Angelo for supporting Matthias here=2E I also have no informatio=
n why his tree is stale for more than 2 months and also got no response on =
direct contact=2E I hope he is still ok and do only need some free time=2E

I waiting for these to be merged:
 https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/list/?series=3D76=
1293 =C2=A0 https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/list/?s=
eries=3D777712

Do you have created an own tree from matthias' one or can you directly wor=
k on it? If working on own tree please send me the link,so that i can track=
 when changes (also from others) are merged=2E
regards Frank
