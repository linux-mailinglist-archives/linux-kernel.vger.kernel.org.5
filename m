Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0BC7E635E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjKIFqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjKIFp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:45:56 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5117271D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 21:45:49 -0800 (PST)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SQrSp4L3lz1P83T;
        Thu,  9 Nov 2023 13:42:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000004.china.huawei.com (7.193.23.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 9 Nov 2023 13:45:10 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <krzk@kernel.org>, <sudeep.holla@arm.com>,
        <liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 0/3] soc: hisilicon: kunpeng_hccs: Support the platform with PCC type3 and interrupt ack
Date:   Thu, 9 Nov 2023 13:45:23 +0800
Message-ID: <20231109054526.27270-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000004.china.huawei.com (7.193.23.18)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some incorrect format strings and add failure log for no _CRS method.
Add support for the platform with PCC type3 and interrupt ack.

Huisong Li (3):
  soc: hisilicon: kunpeng_hccs: Fix some incorrect format strings
  soc: hisilicon: kunpeng_hccs: Add failure log for no _CRS method
  soc: hisilicon: kunpeng_hccs: Support the platform with PCC type3 and
    interrupt ack

 drivers/soc/hisilicon/kunpeng_hccs.c | 153 ++++++++++++++++++++-------
 drivers/soc/hisilicon/kunpeng_hccs.h |   2 +
 2 files changed, 119 insertions(+), 36 deletions(-)

-- 
2.33.0

