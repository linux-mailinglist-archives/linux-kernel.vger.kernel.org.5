Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42632800230
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377304AbjLADpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377196AbjLADpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:45:32 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A16C10C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:45:39 -0800 (PST)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ShJkk0102zNnv2;
        Fri,  1 Dec 2023 11:41:17 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000004.china.huawei.com (7.193.23.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 11:45:37 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Jonathan.Cameron@Huawei.com>, <arnd@arndb.de>, <krzk@kernel.org>,
        <sudeep.holla@arm.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH v3 4/5] doc: kunpeng_hccs: Fix incorrect email domain name
Date:   Fri, 1 Dec 2023 11:45:33 +0800
Message-ID: <20231201034534.7276-5-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231201034534.7276-1-lihuisong@huawei.com>
References: <20231109054526.27270-1-lihuisong@huawei.com>
 <20231201034534.7276-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000004.china.huawei.com (7.193.23.18)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The email domain name in Contact is wrong. So this patch has to modify it.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 .../ABI/testing/sysfs-devices-platform-kunpeng_hccs         | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs b/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
index fdb4e36310fb..1666340820f7 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
+++ b/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
@@ -3,7 +3,7 @@ What:		/sys/devices/platform/HISI04Bx:00/chipX/linked_full_lane
 What:		/sys/devices/platform/HISI04Bx:00/chipX/crc_err_cnt
 Date:		November 2023
 KernelVersion:	6.6
-Contact:	Huisong Li <lihuisong@huawei.org>
+Contact:	Huisong Li <lihuisong@huawei.com>
 Description:
 		The /sys/devices/platform/HISI04Bx:00/chipX/ directory
 		contains read-only attributes exposing some summarization
@@ -26,7 +26,7 @@ What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/linked_full_lane
 What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/crc_err_cnt
 Date:		November 2023
 KernelVersion:	6.6
-Contact:	Huisong Li <lihuisong@huawei.org>
+Contact:	Huisong Li <lihuisong@huawei.com>
 Description:
 		The /sys/devices/platform/HISI04Bx:00/chipX/dieY/ directory
 		contains read-only attributes exposing some summarization
@@ -54,7 +54,7 @@ What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/lane_mask
 What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/crc_err_cnt
 Date:		November 2023
 KernelVersion:	6.6
-Contact:	Huisong Li <lihuisong@huawei.org>
+Contact:	Huisong Li <lihuisong@huawei.com>
 Description:
 		The /sys/devices/platform/HISI04Bx/chipX/dieX/hccsN/ directory
 		contains read-only attributes exposing information about
-- 
2.33.0

