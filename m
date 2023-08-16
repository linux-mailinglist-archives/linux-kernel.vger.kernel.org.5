Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEAE77D730
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbjHPAuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbjHPAtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:49:51 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4847B2112;
        Tue, 15 Aug 2023 17:49:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VptT2LQ_1692146985;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VptT2LQ_1692146985)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 08:49:46 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
        netdev@vger.kernel.org, linux-net-drivers@amd.com,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH net-next] sfc: Remove unneeded semicolon
Date:   Wed, 16 Aug 2023 08:49:44 +0800
Message-Id: <20230816004944.10841-1-yang.lee@linux.alibaba.com>
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

./drivers/net/ethernet/sfc/tc_conntrack.c:464:2-3: Unneeded semicolon

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/ethernet/sfc/tc_conntrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/tc_conntrack.c b/drivers/net/ethernet/sfc/tc_conntrack.c
index 54ed288543d0..8e06bfbcbea1 100644
--- a/drivers/net/ethernet/sfc/tc_conntrack.c
+++ b/drivers/net/ethernet/sfc/tc_conntrack.c
@@ -461,7 +461,7 @@ static int efx_tc_flow_block(enum tc_setup_type type, void *type_data,
 		return efx_tc_ct_stats(ct_zone, tcb);
 	default:
 		break;
-	};
+	}
 
 	return -EOPNOTSUPP;
 }
-- 
2.20.1.7.g153144c

