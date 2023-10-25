Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1B07D65F7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjJYI7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJYI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:59:10 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA7DB0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:59:05 -0700 (PDT)
X-UUID: cfc91cf648804cd0a5769e53c694496e-20231025
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2fa55461-6189-4a51-950b-3fbfd28f5c8c,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-INFO: VERSION:1.1.32,REQID:2fa55461-6189-4a51-950b-3fbfd28f5c8c,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:17d2e428-cb22-4fa7-8134-287af20ad1fc,B
        ulkID:231025165717V3CMEEAR,BulkQuantity:1,Recheck:0,SF:44|66|38|24|17|19|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: cfc91cf648804cd0a5769e53c694496e-20231025
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1174103866; Wed, 25 Oct 2023 16:58:50 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     laurentiu.palcu@oss.nxp.com, l.stach@pengutronix.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kunwu.chan@hotmail.com, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] drm/imx: Spelling fix in comment
Date:   Wed, 25 Oct 2023 16:58:37 +0800
Message-Id: <20231025085837.35330-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a misspelling of "concurrent".

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/gpu/drm/imx/dcss/dcss-ctxld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-ctxld.c b/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
index 3a84cb3209c4..28727a8cb7e3 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
@@ -82,7 +82,7 @@ struct dcss_ctxld {
 	bool in_use;
 	bool armed;
 
-	spinlock_t lock; /* protects concurent access to private data */
+	spinlock_t lock; /* protects concurrent access to private data */
 };
 
 static irqreturn_t dcss_ctxld_irq_handler(int irq, void *data)
-- 
2.34.1

