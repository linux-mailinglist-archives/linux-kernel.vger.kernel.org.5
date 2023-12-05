Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A077A804E35
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjLEJnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjLEJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:43:36 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53666AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:43:39 -0800 (PST)
X-UUID: 64f505a4db7141c0a6d465b761461b95-20231205
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:c0112fa9-5964-4834-addf-2aecd59a9892,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-INFO: VERSION:1.1.33,REQID:c0112fa9-5964-4834-addf-2aecd59a9892,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:37412b96-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:231205174325O72Y67N5,BulkQuantity:0,Recheck:0,SF:19|44|66|38|24|72|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 64f505a4db7141c0a6d465b761461b95-20231205
X-User: jiangyunshui@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <jiangyunshui@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2082040622; Tue, 05 Dec 2023 17:43:24 +0800
From:   jiangyunshui <jiangyunshui@kylinos.cn>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        jiangyunshui <jiangyunshui@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] ocxl: fix driver function comment typo
Date:   Tue,  5 Dec 2023 17:43:19 +0800
Message-Id: <20231205094319.32114-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
---
 include/misc/ocxl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
index 3ed736da02c8..ef7d26009a36 100644
--- a/include/misc/ocxl.h
+++ b/include/misc/ocxl.h
@@ -324,7 +324,7 @@ int ocxl_global_mmio_clear32(struct ocxl_afu *afu, size_t offset,
 int ocxl_global_mmio_clear64(struct ocxl_afu *afu, size_t offset,
 			     enum ocxl_endian endian, u64 mask);
 
-// Functions left here are for compatibility with the cxlflash driver
+// Functions left here are for compatibility with the ocxlflash driver
 
 /*
  * Read the configuration space of a function for the AFU specified by
-- 
2.25.1

