Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B155C7D2A79
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjJWGcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJWGcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:32:18 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D17DB;
        Sun, 22 Oct 2023 23:32:13 -0700 (PDT)
X-UUID: 21920e6397694984822899e3834b1105-20231023
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:dc5d4585-ad3a-4482-9932-278215af4edb,IP:20,
        URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:25
X-CID-INFO: VERSION:1.1.32,REQID:dc5d4585-ad3a-4482-9932-278215af4edb,IP:20,UR
        L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:25
X-CID-META: VersionHash:5f78ec9,CLOUDID:7de1087d-ccd9-4df5-91ce-9df5fea3ae01,B
        ulkID:231023142837SMUKN4XO,BulkQuantity:1,Recheck:0,SF:17|19|44|66|38|24|1
        02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 21920e6397694984822899e3834b1105-20231023
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.171)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 373002410; Mon, 23 Oct 2023 14:31:58 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, axboe@kernel.dk
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunwu.chan@hotmail.com,
        Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] drbd: Spelling fix in comment
Date:   Mon, 23 Oct 2023 14:31:55 +0800
Message-Id: <20231023063155.719469-1-chentao@kylinos.cn>
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
 drivers/block/drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 380e6584a4ee..60e6e016829e 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1745,7 +1745,7 @@ void request_timer_fn(struct timer_list *t)
 	 * but which is still waiting for an ACK. */
 	req_peer = connection->req_ack_pending;
 
-	/* if we don't have such request (e.g. protocoll A)
+	/* if we don't have such request (e.g. protocol A)
 	 * check the oldest requests which is still waiting on its epoch
 	 * closing barrier ack. */
 	if (!req_peer)
-- 
2.34.1

