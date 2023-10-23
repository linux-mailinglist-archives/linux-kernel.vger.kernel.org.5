Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFB57D2A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjJWGi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjJWGi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:38:27 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9B8D68;
        Sun, 22 Oct 2023 23:38:24 -0700 (PDT)
X-UUID: 3ce18d765a4d4f1ba8999da3adbde13b-20231023
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e6e40306-f6ec-43f9-b451-b5bb02d8a100,IP:20,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-INFO: VERSION:1.1.32,REQID:e6e40306-f6ec-43f9-b451-b5bb02d8a100,IP:20,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:5
X-CID-META: VersionHash:5f78ec9,CLOUDID:75b3a6fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231023143821WP6X8U6D,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 3ce18d765a4d4f1ba8999da3adbde13b-20231023
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.171)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1072203218; Mon, 23 Oct 2023 14:38:21 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     isdn@linux-pingi.de, kuba@kernel.org, yangyingliang@huawei.com,
        alexanderduyck@fb.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kunwu.chan@hotmail.com, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] isdn: mISDN: hfcsusb: Spelling fix in comment
Date:   Mon, 23 Oct 2023 14:37:58 +0800
Message-Id: <20231023063758.719718-1-chentao@kylinos.cn>
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

protocoll -> protocol

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/isdn/hardware/mISDN/hfcsusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index 1efd17979f24..b82b89888a5e 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -678,7 +678,7 @@ ph_state(struct dchannel *dch)
 }
 
 /*
- * disable/enable BChannel for desired protocoll
+ * disable/enable BChannel for desired protocol
  */
 static int
 hfcsusb_setup_bch(struct bchannel *bch, int protocol)
-- 
2.34.1

