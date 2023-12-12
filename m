Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEE880E7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjLLJf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjLLJff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:35:35 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8794E9;
        Tue, 12 Dec 2023 01:35:30 -0800 (PST)
X-UUID: b8cf7f33c3c545dd8a3ced85c4210217-20231212
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:997280ab-4177-4420-a9b6-268ff8af484b,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-INFO: VERSION:1.1.33,REQID:997280ab-4177-4420-a9b6-268ff8af484b,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:259793fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231212151949FMQZSAO8,BulkQuantity:7,Recheck:0,SF:66|24|17|19|44|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: b8cf7f33c3c545dd8a3ced85c4210217-20231212
X-User: shitao@kylinos.cn
Received: from kylin-pc.. [(112.64.161.44)] by mailgw
        (envelope-from <shitao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1603587090; Tue, 12 Dec 2023 17:35:14 +0800
From:   shitao <shitao@kylinos.cn>
To:     kvalo@kernel.org
Cc:     gregory.greenman@intel.com, kernel-bot@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        shitao@kylinos.cn
Subject: [PATCH v2] wifi: iwlwifi: Fix spelling typo in comment
Date:   Tue, 12 Dec 2023 17:34:24 +0800
Message-Id: <20231212093424.3104329-1-shitao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87wmtjonfw.fsf@kernel.org>
References: <87wmtjonfw.fsf@kernel.org>
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

Fix spelling typo in iwl-context-info.h comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: shitao <shitao@kylinos.cn>
---
 drivers/net/wireless/intel/iwlwifi/iwl-context-info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
index 1a1321db137c..3ab6f127041f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
@@ -6,7 +6,7 @@
 #ifndef __iwl_context_info_file_h__
 #define __iwl_context_info_file_h__
 
-/* maximmum number of DRAM map entries supported by FW */
+/* maximum number of DRAM map entries supported by FW */
 #define IWL_MAX_DRAM_ENTRY	64
 #define CSR_CTXT_INFO_BA	0x40
 
-- 
2.34.1

