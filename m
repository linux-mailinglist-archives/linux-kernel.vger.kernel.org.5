Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A751776D59
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjHJBF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHJBF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:05:58 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BEB19A1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 18:05:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VpRLFrr_1691629551;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VpRLFrr_1691629551)
          by smtp.aliyun-inc.com;
          Thu, 10 Aug 2023 09:05:52 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tglx@linutronix.de, peterz@infradead.org, jpoimboe@kernel.org,
        dave.hansen@linux.intel.com, mingo@redhat.com,
        pawan.kumar.gupta@linux.intel.com, hpa@zytor.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] x86/srso: Remove unneeded semicolon
Date:   Thu, 10 Aug 2023 09:05:50 +0800
Message-Id: <20230810010550.25733-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./arch/x86/kernel/cpu/bugs.c:713:2-3: Unneeded semicolon

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d02f73c5339d..7b29036130a1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -710,7 +710,7 @@ void update_gds_msr(void)
 	case GDS_MITIGATION_UCODE_NEEDED:
 	case GDS_MITIGATION_HYPERVISOR:
 		return;
-	};
+	}
 
 	wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 
-- 
2.20.1.7.g153144c

