Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097AA7DFB1E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377283AbjKBT4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBT4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:56:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113A2DC;
        Thu,  2 Nov 2023 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698954987; x=1730490987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FTY8ezB7env8X5diZ4Ygl4jXcg2DMQYtnvOr7ER/FP0=;
  b=AVNCC3cKGUxl/hJy1odHcP1VdYODQ2lymzcEjaYcUPS8Io7KHshUmguE
   K1JOUVbR9aq4AeHDUoQil0zHYoTCKfkGQq3PuifXSZjCByxQaH4nneary
   ptMpwBZ9qgJth85gpja9lKNc7HKTWKT8ueauiECdSTWyZHcv1doDX1y9S
   5jNdCQ7vFUQrAklDKTZ/NgjpKk6UCmG96ClGCDiMeX4MFfNWloo1WXgIN
   1OSSuNwrHPDtp4exR8SNunkZ+6xbSqcrzEuJZM4VP+ZAVXGYHuyinElXp
   19GCxsD5DghCe0pvoUWwLDrndn/DRywUcJT7pmu7ufO0vuQtwkeE+qkbl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="10333148"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="10333148"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 12:56:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="796372475"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="796372475"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 12:56:25 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jithu.joseph@intel.com
Subject: [PATCH 1/1] MAINTAINERS: Remove stale entry for SBL platform driver
Date:   Thu,  2 Nov 2023 12:52:18 -0700
Message-Id: <20231102195218.143440-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maurice is no longer with Intel and his e-mail address is no longer
active. Remove the stale entry from Slim boot loader section.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5de540ec0b..747ab2913ed6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10869,7 +10869,6 @@ F:	drivers/net/wireless/intel/iwlwifi/
 
 INTEL WMI SLIM BOOTLOADER (SBL) FIRMWARE UPDATE DRIVER
 M:	Jithu Joseph <jithu.joseph@intel.com>
-R:	Maurice Ma <maurice.ma@intel.com>
 S:	Maintained
 W:	https://slimbootloader.github.io/security/firmware-update.html
 F:	drivers/platform/x86/intel/wmi/sbl-fw-update.c

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.25.1

