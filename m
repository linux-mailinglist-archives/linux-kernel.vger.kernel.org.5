Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD59A7A46F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbjIRK3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbjIRK3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:29:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D101BD1;
        Mon, 18 Sep 2023 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695032957; x=1726568957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=odrcEvZ475lYBEbLkpgVrOMJWDwXpqDcawGK1j73n5Y=;
  b=cqIRefEsOqcZf7zC7oGck1WGwKclGPsu301WbYYo97aF5vxQNq4dVaeP
   91TksY7N4bQdeots9XLmnZmW5fQcvnld5C6lIwsL85NtDRmLIh3dlL73A
   /oBC3b2oYLwDj868sVMyZQ67lF2Ws0XJ0Di0R6G0zyYIc5oV5emuUWEVj
   gHYrf+6tgzOQksd6df1xDGJ9CSZkvg9cmRMxPJzNgCXAnXqmI2pwVI5Tg
   cvW4VYQD5OtMh7U+wqdrp14jLwLfZKRD3v7dplfT/D6eIQtpzigZRAC1I
   LAdoph0hq95WiLd25MDBzZBMixRrMAv3s/JZEvnMYmAbmA3yc8L6uCy93
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="359035890"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="359035890"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 03:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="811305507"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811305507"
Received: from nprotaso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.49.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 03:29:15 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] MAINTAINERS: Add myself into x86 platform driver maintainers
Date:   Mon, 18 Sep 2023 13:29:01 +0300
Message-Id: <20230918102901.17669-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230918102901.17669-1-ilpo.jarvinen@linux.intel.com>
References: <20230918102901.17669-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans has been asking for another person to help as the maintainer of
the x86 platform driver because Mark has not been able to find time to
do that. I got asked for the task and have been reviewing the relevant
patches for a while now but lets make it more official by adding the
MAINTAINERS entries.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..b04cbcec521f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13617,6 +13617,7 @@ F:	drivers/net/ethernet/mellanox/mlxfw/
 
 MELLANOX HARDWARE PLATFORM SUPPORT
 M:	Hans de Goede <hdegoede@redhat.com>
+M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 M:	Mark Gross <markgross@kernel.org>
 M:	Vadim Pasternak <vadimp@nvidia.com>
 L:	platform-driver-x86@vger.kernel.org
@@ -14211,6 +14212,7 @@ F:	drivers/platform/surface/surface_gpe.c
 
 MICROSOFT SURFACE HARDWARE PLATFORM SUPPORT
 M:	Hans de Goede <hdegoede@redhat.com>
+M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 M:	Mark Gross <markgross@kernel.org>
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
@@ -23424,6 +23426,7 @@ F:	drivers/platform/x86/x86-android-tablets/
 
 X86 PLATFORM DRIVERS
 M:	Hans de Goede <hdegoede@redhat.com>
+M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 M:	Mark Gross <markgross@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-- 
2.30.2

