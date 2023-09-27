Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62F47AFB90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjI0G7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0G7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:59:50 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29D0D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:59:47 -0700 (PDT)
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id WFI00036;
        Wed, 27 Sep 2023 14:59:36 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 14:59:39 +0800
Received: from localhost.localdomain.com (10.73.42.143) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.32; Wed, 27 Sep 2023 14:59:39 +0800
From:   Charles Han <hanchunchao@inspur.com>
To:     <linux@armlinux.org.uk>, <arnd@arndb.de>,
        <rmk+kernel@armlinux.org.uk>, <geert+renesas@glider.be>,
        <linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
        <tglx@linutronix.de>, <corbet@lwn.net>,
        <sebastian.reichel@collabora.com>, <rppt@kernel.org>,
        <eric.devolder@oracle.com>, <nathan@kernel.org>, <robh@kernel.org>,
        <christophe.leroy@csgroup.eu>, <kirill.shutemov@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] arch/arm: Remove repeated word "the" in comments
Date:   Wed, 27 Sep 2023 14:59:36 +0800
Message-ID: <20230927065936.153738-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.73.42.143]
tUid:   2023927145936f39ca0dae6a7ebb230170e20e0974c53
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "the" in comments.

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9557808e8937..2321be76a719 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1563,7 +1563,7 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 	bool "Extend with bootloader kernel arguments"
 	help
 	  The command-line arguments provided by the boot loader will be
-	  appended to the the device tree bootargs property.
+	  appended to the device tree bootargs property.
 
 endchoice
 
@@ -1701,7 +1701,7 @@ config DMI
 	  continue to boot on existing non-UEFI platforms.
 
 	  NOTE: This does *NOT* enable or encourage the use of DMI quirks,
-	  i.e., the the practice of identifying the platform via DMI to
+	  i.e., the practice of identifying the platform via DMI to
 	  decide whether certain workarounds for buggy hardware and/or
 	  firmware need to be enabled. This would require the DMI subsystem
 	  to be enabled much earlier than we do on ARM, which is non-trivial.
-- 
2.31.1

