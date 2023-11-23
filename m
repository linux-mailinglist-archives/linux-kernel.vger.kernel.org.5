Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED43F7F5705
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344456AbjKWDXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKWDXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:23:01 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732631B2;
        Wed, 22 Nov 2023 19:23:04 -0800 (PST)
X-UUID: 6a40f5efba1c401fbd0aab9bec66046d-20231123
X-CID-O-RULE: Release_Ham
X-CID-RULE: EDM_GE969F26
X-CID-O-INFO: VERSION:1.1.32,REQID:a5859e6c-ae9e-4364-b37d-6c847646682c,IP:5,U
        RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-25
X-CID-INFO: VERSION:1.1.32,REQID:a5859e6c-ae9e-4364-b37d-6c847646682c,IP:5,URL
        :0,TC:0,Content:0,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:041b6160-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:231123112252H56IET23,BulkQuantity:0,Recheck:0,SF:72|19|44|66|38|24|1
        02,TC:nil,Content:0,EDM:1,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6a40f5efba1c401fbd0aab9bec66046d-20231123
X-User: shitao@kylinos.cn
Received: from kylin-pc.. [(112.64.161.44)] by mailgw
        (envelope-from <shitao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1992039910; Thu, 23 Nov 2023 11:22:49 +0800
From:   shitao <shitao@kylinos.cn>
To:     justin.chen@broadcom.com, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shitao <shitao@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] usb: Correct misspelling comment word dynamic
Date:   Thu, 23 Nov 2023 11:22:45 +0800
Message-Id: <20231123032245.2986309-1-shitao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
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

The word 'dyanmic memory'is misspelled, fixed the word 'dyanmic'
to 'dynamic',avoiding confusing other developers.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: shitao <shitao@kylinos.cn>
---
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

