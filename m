Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3E80EA36
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346325AbjLLLSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbjLLLSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:18:02 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815A210FC;
        Tue, 12 Dec 2023 03:18:06 -0800 (PST)
X-UUID: a3416e3825d04d11ab433e5be57319f2-20231212
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:d7be38fc-fbff-4d83-8e6b-f3bcdc06f1f6,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.33,REQID:d7be38fc-fbff-4d83-8e6b-f3bcdc06f1f6,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:364b77b,CLOUDID:a31616bd-2ac7-4da2-9f94-677a477649d9,B
        ulkID:2312121820440JAM3HPF,BulkQuantity:6,Recheck:0,SF:24|17|19|44|66|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: a3416e3825d04d11ab433e5be57319f2-20231212
X-User: shitao@kylinos.cn
Received: from kylin-pc.. [(112.64.161.44)] by mailgw
        (envelope-from <shitao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 586504534; Tue, 12 Dec 2023 19:17:58 +0800
From:   shitao <shitao@kylinos.cn>
To:     gregkh@linuxfoundation.org
Cc:     alcooperx@gmail.com, chunfeng.yun@mediatek.com,
        justin.chen@broadcom.com, kernel-bot@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-usb@vger.kernel.org, shitao@kylinos.cn
Subject: [PATCH] usb: gadget: udc: bdc: fix comment typo
Date:   Tue, 12 Dec 2023 19:17:54 +0800
Message-Id: <20231212111754.3115465-1-shitao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023121251-attest-shout-cbaa@gregkh>
References: <2023121251-attest-shout-cbaa@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comment typo in bdc_core.c file.
"dynamic" is misspelled as "dyanmic".

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: shitao <shitao@kylinos.cn>
---
Hi, 
according to your suggestion, I have split it into two patches and added some simple instructions. 
This is a change that fixes the misspelling of "dynamic" in bdc_core.c file. 
thanks.
 drivers/usb/gadget/udc/bdc/bdc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 35a652807fca..874122f8baa3 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -361,7 +361,7 @@ int bdc_reinit(struct bdc *bdc)
 	return ret;
 }
 
-/* Allocate all the dyanmic memory */
+/* Allocate all the dynamic memory */
 static int bdc_mem_alloc(struct bdc *bdc)
 {
 	u32 page_size;
-- 
2.34.1

