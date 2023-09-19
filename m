Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5422B7A633D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjISMkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjISMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:40:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140FEF4;
        Tue, 19 Sep 2023 05:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695127203; x=1726663203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yVzvHYLXjCaKsp1UJyMzzJwC/oFDxWy+urkEsBY98YI=;
  b=EP6Rujr86aMDvmkuKX9xsWGXYHkiDI7+raO3qnI6dqXD/JfCXUP/bDQq
   ZXclB7RfgShvG3KMzohH213RlZAFNj5y6cmcsZfzdClsSI2ETsG8EgIK3
   Ps9A8iR1ySkKRalTVvRDkcInHiJBUlztypEoebBcdArWMwFBZPg3IWMuJ
   4rEOAD52Vezvj1lokzBBLprF8q1sB4I8LYqL7ZfGNQpFDcMFJQDcQATCJ
   v7BIAd4ue81KUYvlTVZBSNj+BcFiAU5hI5tJvk661FWWpY2VL3Vaes3q5
   uEenKNZmOT5wya/DzsvzGxCGOxwR26exSa9IaHeG2nNa0/HfTjvDdQ8Gf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="382680561"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="382680561"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="889491115"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="889491115"
Received: from vdesserx-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.32.31])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:39:14 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] MAINTAINERS: Add x86 platform drivers patchwork
Date:   Tue, 19 Sep 2023 15:39:48 +0300
Message-Id: <20230919123948.1583-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add x86 platform drivers patchwork which has been missing from
MAINTAINERS.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b04cbcec521f..dbf1668dcd84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23430,6 +23430,7 @@ M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 M:	Mark Gross <markgross@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
+Q:	https://patchwork.kernel.org/project/platform-driver-x86/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
 F:	drivers/platform/olpc/
 F:	drivers/platform/x86/
-- 
2.30.2

