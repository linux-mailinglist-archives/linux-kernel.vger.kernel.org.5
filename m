Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D3E7840D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbjHVMbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbjHVMbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:31:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C4119A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:31:10 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVTD55d6wzTmKf;
        Tue, 22 Aug 2023 20:28:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 20:31:07 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <will@kernel.org>, <jonathan.cameron@huawei.com>,
        <mark.rutland@arm.com>, <yangyicong@huawei.com>
CC:     <chenhao418@huawei.com>, <shaojijie@huawei.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <hejunhao3@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH drivers/perf: hisi:] drivers/perf: hisi: Update email addresses of HISILICON_PMU driver maintainers.
Date:   Tue, 22 Aug 2023 20:28:12 +0800
Message-ID: <20230822122812.2384393-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Guangbin and Shaokun have left HiSilicon and will no longer
maintain the drivers, update the maintainer information and
thanks for their work.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4171d3a102a9..a3109267a411 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9305,7 +9305,7 @@ F:	drivers/crypto/hisilicon/hpre/hpre_crypto.c
 F:	drivers/crypto/hisilicon/hpre/hpre_main.c
 
 HISILICON HNS3 PMU DRIVER
-M:	Guangbin Huang <huangguangbin2@huawei.com>
+M:	Jijie Shao <shaojijie@huawei.com>
 S:	Supported
 F:	Documentation/admin-guide/perf/hns3-pmu.rst
 F:	drivers/perf/hisilicon/hns3_pmu.c
@@ -9343,7 +9343,7 @@ F:	Documentation/devicetree/bindings/net/hisilicon*.txt
 F:	drivers/net/ethernet/hisilicon/
 
 HISILICON PMU DRIVER
-M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
+M:	Yicong Yang <yangyicong@hisilicon.com>
 M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 S:	Supported
 W:	http://www.hisilicon.com
-- 
2.30.0

