Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355C67B2DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjI2IUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjI2IUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:20:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DBD1A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:20:39 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 602886607345;
        Fri, 29 Sep 2023 09:20:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695975637;
        bh=UPagtv10FBWXOAdGt2RUXPK7syXYCD3V+4gbtZr1J6w=;
        h=From:To:Cc:Subject:Date:From;
        b=Cx3M3BIYBV4kZumxVhOxMU5stV4ZCCkTulVNM8D7DXZVdOzxgGUFgRJ8qou3HCBZ6
         hgmK64kjt/Ygc/HM1719abKJaRt2wSbodsHvuYvgcEe/bwXEchKvZ/HbuliOP5NuG3
         ghnyyq/GcoC3sbOUfs0a9Z5ezyJlweolWqsHFuG+wYyLyvV2LOURnJlcGQ41HH+nD+
         6IGSgjCZ8UNVhqz5ja4Vajxfjm29IdHYfa8vmMtByMnpndWNm+O8BQwbKxeGzM1020
         ll2pEMtJHAPuAP7qM8FID0ODXGnkPkEzQaNHKvnCUpmui2k1v9SFQKXdU1uCrys96d
         zE7vHg31fTSAQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     nfraprado@collabora.com, wenst@chromium.org,
        matthias.bgg@gmail.com, robh@kernel.org, amergnat@baylibre.com,
        arnd@arndb.de,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
Date:   Fri, 29 Sep 2023 10:20:09 +0200
Message-ID: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am a top reviewer mainly for MediaTek SoC related patches in most
subsystems and I've also been upstreaming both improvements, fixes
and new drivers and devicetrees when required.

The MediaTek scene saw a generous increase in number of patches that
are sent to the lists every week, increasing the amount of required
efforts to maintain the MTK bits overall, and we will possibly see
even more of that.

For this reason, and also because of suggestions and encouragement
coming from the community, I'm stepping up to be a co-maintainer of
MediaTek SoCs support.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

P.S.: I tried to reach to Matthias for almost two months, but I couldn't
find any way to talk to him and he has been unresponsive on the mailing
lists as well.

P.P.S.: This also comes after Rob Herring's suggestion to have myself as
a MediaTek SoC co-maintainer [1] and support from other people.

[1]: https://lore.kernel.org/all/20230804225813.12493-1-robh@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 208cfcc1aee3..211a8322c801 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2330,7 +2330,7 @@ F:	drivers/rtc/rtc-mt7622.c
 
 ARM/Mediatek SoC support
 M:	Matthias Brugger <matthias.bgg@gmail.com>
-R:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+M:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
-- 
2.42.0

