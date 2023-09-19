Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6918C7A69C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjISRmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjISRmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:42:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DE47CD1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3E501042;
        Tue, 19 Sep 2023 10:42:17 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78C5E3F5A1;
        Tue, 19 Sep 2023 10:41:39 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:41:06 +0100
Subject: [PATCH RFT v2 18/18] firmware: arm_ffa: Upgrade the driver version
 to v1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-18-6f3a3ca3923c@arm.com>
References: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
In-Reply-To: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=687; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=Pb+LVcZOIfL1PSSQwEckUhDsMu3bfFsfEmBra9hf4+U=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd08IF2qhQuyqxuijENkrrjtStkrVgvoaWusI
 WOHSwYDYEOJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndPAAKCRAAQbq8MX7i
 mL4FEADNcrAnBGdL6hdOb80LALhE7fZxdyukmr6zfD+nx5GhhI0201WI1L33C6r/eKIiuC6SrO7
 eKaBV8Emmo5x75JZPcua5XS4el8plsHMvKjd6BzjzTZ2sS6yI5lqQYiIoSb1zykPO49kIPs7mIF
 yBWUgE4b714eusfZIbi+PtLN9af2KAObbGYXjnqcbAYl5k85DvbKAfyb08HMWel/9Lo6n9Y8nlA
 j0LVvv9u7IBoSQN5sRvkrNsoiAzgxXVKJrFEKzmgiNXGoo7oRdWzAk5nT6bO8z4jhYlDKk+sMdz
 7WMIMzEAT56w3jXgRdZoHkvUxRpGKOUPdKaarMMQwuBS3pGuQyixDdK7z5NOtfoEVPhBllic84n
 g7y+eBusk4GWD78gcFVwrGmDnIpmKo7lxb8ZYXjJgfGmRWCE5UJOeR8grhcLt1SxaBtCaeazqSr
 4pBugsB4+X18T5GVflIvgflju6vCC78P/ZNvuYlU3jX7BwJVFEz3ikqeqZFKEyq0dBVbUFDPZW0
 /0DyTtTxch7LVj4zw2RB44EDI35VHNXLnX7QwxjP6dcRsVsY9Q8jx2eNUWps/sk2ljNbJwkJJIv
 lFsdPyIoBLpOwdqLmWqd+7jeyE0qR1wGdXEuyrqo+iPdkrOqnr1PaVdDboRJwc0IY3DGCRe7/HV
 unFwpBZ8VK3Virw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With quite a few v1.1 features supported, we can bump the driver version
to v1.1 now.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index e18f0b125d46..dfc694773ae2 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -43,7 +43,7 @@
 
 #include "common.h"
 
-#define FFA_DRIVER_VERSION	FFA_VERSION_1_0
+#define FFA_DRIVER_VERSION	FFA_VERSION_1_1
 #define FFA_MIN_VERSION		FFA_VERSION_1_0
 
 #define SENDER_ID_MASK		GENMASK(31, 16)

-- 
2.42.0

