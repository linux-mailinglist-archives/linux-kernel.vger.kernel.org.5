Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B497F2327
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjKUBee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjKUBe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:34:26 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658E1ED;
        Mon, 20 Nov 2023 17:34:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VwqXEiK_1700530455;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VwqXEiK_1700530455)
          by smtp.aliyun-inc.com;
          Tue, 21 Nov 2023 09:34:16 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com
Cc:     chengyou@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
Subject: [PATCH v11 5/5] MAINTAINERS: add maintainers for DesignWare PCIe PMU driver
Date:   Tue, 21 Nov 2023 09:34:00 +0800
Message-Id: <20231121013400.18367-6-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121013400.18367-1-xueshuai@linux.alibaba.com>
References: <20231121013400.18367-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for Synopsys DesignWare PCIe PMU driver and driver
document.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c4cce45a09d..71f363f836ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20866,6 +20866,13 @@ L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/dw_mmc*
 
+SYNOPSYS DESIGNWARE PCIE PMU DRIVER
+M:	Shuai Xue <xueshuai@linux.alibaba.com>
+M:	Jing Zhang <renyu.zj@linux.alibaba.com>
+S:	Supported
+F:	Documentation/admin-guide/perf/dwc_pcie_pmu.rst
+F:	drivers/perf/dwc_pcie_pmu.c
+
 SYNOPSYS HSDK RESET CONTROLLER DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Supported
-- 
2.39.3

