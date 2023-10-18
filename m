Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257077CD1AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344264AbjJRBLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJRBLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:11:45 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4CBB0;
        Tue, 17 Oct 2023 18:11:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VuOlUEq_1697591499;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VuOlUEq_1697591499)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 09:11:40 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     dave.hansen@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] perf/x86/amd/uncore: Remove unneeded semicolon
Date:   Wed, 18 Oct 2023 09:11:38 +0800
Message-Id: <20231018011138.782-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./arch/x86/events/amd/uncore.c:1038:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6899
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/x86/events/amd/uncore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 5bf03c575812..5546b9c08b73 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -1035,7 +1035,7 @@ static int __init amd_uncore_init(void)
 			ret = -ENOMEM;
 			goto fail;
 		}
-	};
+	}
 
 	/*
 	 * Install callbacks. Core will call them for each online cpu.
-- 
2.20.1.7.g153144c

