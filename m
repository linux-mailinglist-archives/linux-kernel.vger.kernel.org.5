Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF807B22B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjI1Qrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjI1Qro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:47:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0482B1B6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695919663; x=1727455663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xRy03ponI/Z4GQaBJ6d8X7rUVRteD5QM92YlUvQ/gqk=;
  b=ABqp2Al6/rIgXq6cRPTrxcj9qUSXxf89z7VoP7fRFWIqywsvBg96qlqY
   v2g7yARz4DgANb3wGl/GcmBbC5MEuBEhh8weNaVZnyY7t8w1sA78SMVkJ
   vzIil2afCczpHfsD2dJtaWJXkxgZc0ZUSCSZUcnMCvXaBCZwdNHPnCzgg
   6Mi3hMy9d00hnrA78RiUSa9d/gOTCwVOgQRcAr7Ghhduj1rzlbgziZwh1
   dmwZNjD3Yym3d56v/cpAfHVR4FPrnjnGdbzG/Nw9ojXc6KzrKKg2so1y3
   TGSJQMb76mDkxGrhdQl5psjNHEtpOVb/3AbR2n0Z+QrCplxIp4O1bQHZf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="721134"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="721134"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 09:47:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="893099307"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="893099307"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.8.12])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 09:46:31 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     yilun.xu@intel.com, trix@redhat.com, lee@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com, peter.colberg@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH 3/3] mfd: intel-m10-bmc: Change contact for ABI docs
Date:   Thu, 28 Sep 2023 09:47:38 -0700
Message-Id: <20230928164738.278635-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change ABI documentation contact information from Russ Weight to
Peter Colberg.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
index a8ab58035c95..c12316dfd973 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
@@ -17,7 +17,7 @@ Description:	Read only. Returns the firmware version of Intel MAX10
 What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_address
 Date:		January 2021
 KernelVersion:  5.12
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Peter Colberg <peter.colberg@intel.com>
 Description:	Read only. Returns the first MAC address in a block
 		of sequential MAC addresses assigned to the board
 		that is managed by the Intel MAX10 BMC. It is stored in
@@ -28,7 +28,7 @@ Description:	Read only. Returns the first MAC address in a block
 What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_count
 Date:		January 2021
 KernelVersion:  5.12
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Peter Colberg <peter.colberg@intel.com>
 Description:	Read only. Returns the number of sequential MAC
 		addresses assigned to the board managed by the Intel
 		MAX10 BMC. This value is stored in FLASH and is mirrored
-- 
2.25.1

