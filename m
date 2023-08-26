Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DB17895A7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjHZJ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjHZJ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:56:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435B41FC7;
        Sat, 26 Aug 2023 02:56:53 -0700 (PDT)
Received: from kwepemd100002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RXsd12HW7zrS4y;
        Sat, 26 Aug 2023 17:55:17 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Sat, 26 Aug
 2023 17:56:50 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: Fix typo in the comment of CPUFREQ_NEED_UPDATE_LIMITS
Date:   Sat, 26 Aug 2023 09:54:54 +0000
Message-ID: <20230826095455.1137604-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100002.china.huawei.com (7.221.188.184)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'diver' with 'driver'.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 include/linux/cpufreq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 43b363a99215..43c771e502d4 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -407,7 +407,7 @@ struct cpufreq_driver {
 /*
  * Set by drivers that need to update internal upper and lower boundaries along
  * with the target frequency and so the core and governors should also invoke
- * the diver if the target frequency does not change, but the policy min or max
+ * the driver if the target frequency does not change, but the policy min or max
  * may have changed.
  */
 #define CPUFREQ_NEED_UPDATE_LIMITS		BIT(0)
-- 
2.34.1

