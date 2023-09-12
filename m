Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF67E79CBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjILJZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjILJY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:24:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A99E79;
        Tue, 12 Sep 2023 02:24:53 -0700 (PDT)
X-UUID: 3891fb14514e11eea33bb35ae8d461a2-20230912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LiDUTfzrawFh1EWKsCkz9kjpZ7OgtmwnDfS5wYzBFpI=;
        b=cQs1XLG8jLaW8Xjc2YhhfbAxieBQHf7LfyiXt6nPjnV7+xDmb76/5QbasGuUW0l5dIxix1xD+byCaQy36PA7snqRJB3jiAV10ppv9zo/36orYlod4uxqUCMMx250f8jgcqJi3ieD6fTdumlcvmREiyzsAhb54YgwnUK9uRNq5J8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:e7501742-c96a-4eb6-aad6-25781a534428,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:be639aef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 3891fb14514e11eea33bb35ae8d461a2-20230912
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1402903918; Tue, 12 Sep 2023 17:24:49 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Sep 2023 17:24:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Sep 2023 17:24:47 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: arm64: dts: mediatek: mt8365-evk: update compatible
Date:   Tue, 12 Sep 2023 17:24:43 +0800
Message-ID: <20230912092444.31635-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.873600-8.000000
X-TMASE-MatchedRID: i01+YSiNUzMcqJwtUHLtOe0yyL51qL/R+KgiyLtJrSBh2fnHe1cilw2K
        u+gP3kxise0eJxE/UVXuev+YFA//bWsV28ESZOe8A9lly13c/gFVbRdL8GjdzZsoi2XrUn/Jn6K
        dMrRsL14qtq5d3cxkNZivyg6Bk2T/JSOWtCLDmch82R3XsjC3oQuz+bKasm9tJFbIY5p5bKPvVa
        y2kO94Fmb4YhaEgKYKAz08CGQC6VFhCo0f/eBiT6Wn1XP+V4+Y82Gj2QC3yG0smXVK/H8eHzG7s
        r7xobSAsPEFD+rZA81DDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.873600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 1275F8D9617010498F2A59E9806A8072146B814A40781A02B725653987DFD2632000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update compatible of 'mediatek,mt8365-evk' from 'enum' to 'const'.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

changes for v2:
 - rebase this patch to follow the v5 patch set of mt8395.
  - depends on https://lore.kernel.org/lkml/20230909132819.21626-2-macpaul.lin@mediatek.com/T/
 - Fix description as a single board.

changes for v3:
 - rebase this patch to follow the v6 patch set of mt8395.
  - depends on https://lore.kernel.org/lkml/20230911115717.26184-1-macpaul.lin@mediatek.com/T/
 - drop "Fixes:" tag in commit message.
 - drop platform description update for mt8365-evk (Genio 350-EVK).

changes for v4:
 - Replace "Fix" in commit message with "Update".
 - Fix 'make dtbs_check W=1' error for 'const: mediatek,mt8365-evk'

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 2e8ad49c3479..9031160ef41b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -245,8 +245,7 @@ properties:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
       - items:
-          - enum:
-              - mediatek,mt8365-evk
+          - const: mediatek,mt8365-evk
           - const: mediatek,mt8365
       - description: MediaTek Genio 1200 Boards (Genio 1200 EVK)
         items:
-- 
2.18.0

