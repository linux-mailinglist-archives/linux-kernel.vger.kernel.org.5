Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0867B22B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjI1QrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1QrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:47:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAB8BF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695919628; x=1727455628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZxG2rJQEKXbCOztnmBl7esNBXHe2Ob2LhOOkPTr6L0Y=;
  b=CA3OTQJsh3XtczRKDndp2nDZSVaga2O7424R4+rLYrwoyQfviTNrXaob
   2pGNA2boxrnXu9fVyrm62TZ86AJj3+ZFt4NihGZ1Y/ufy/xEwXch2ce9U
   KmJ7uWJk2RG95iPZ+ezvrZYCrcBTToh8cgMPqGqeJBYIullGm5YitTnqQ
   PYULk4Xxmk+7N0V5NZaFJQkWbPryglnEDkeHuSv0Z5fXEFuhIwKKaxFEs
   f114c6jnijSgB9zCdUo3MCeTrJmwCAuDCrYPZQeY7j4RjLfOumYcDgm7w
   cGTZ+VNks6ZJ0FsiPTG805ll0NTlD2y6u7vFAicwkJTaO7/jk1gTuT8LK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="379387364"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="379387364"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 09:47:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="778970454"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="778970454"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.8.12])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 09:47:06 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Russ Weight <russ.weight@linux.dev>
Subject: [PATCH 1/3] firmware_loader: Update contact emails for ABI docs
Date:   Thu, 28 Sep 2023 09:46:23 -0700
Message-Id: <20230928164623.278570-1-russell.h.weight@intel.com>
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

Update the firmware_loader documentation and corresponding section
in the MAINTAINERs file with a new email address.

Signed-off-by: Russ Weight <russ.weight@linux.dev>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 Documentation/ABI/testing/sysfs-class-firmware | 14 +++++++-------
 MAINTAINERS                                    |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware b/Documentation/ABI/testing/sysfs-class-firmware
index 978d3d500400..fba87a55f3ca 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware
+++ b/Documentation/ABI/testing/sysfs-class-firmware
@@ -1,7 +1,7 @@
 What: 		/sys/class/firmware/.../data
 Date:		July 2022
 KernelVersion:	5.19
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Russ Weight <russ.weight@linux.dev>
 Description:	The data sysfs file is used for firmware-fallback and for
 		firmware uploads. Cat a firmware image to this sysfs file
 		after you echo 1 to the loading sysfs file. When the firmware
@@ -13,7 +13,7 @@ Description:	The data sysfs file is used for firmware-fallback and for
 What: 		/sys/class/firmware/.../cancel
 Date:		July 2022
 KernelVersion:	5.19
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Russ Weight <russ.weight@linux.dev>
 Description:	Write-only. For firmware uploads, write a "1" to this file to
 		request that the transfer of firmware data to the lower-level
 		device be canceled. This request will be rejected (EBUSY) if
@@ -23,7 +23,7 @@ Description:	Write-only. For firmware uploads, write a "1" to this file to
 What: 		/sys/class/firmware/.../error
 Date:		July 2022
 KernelVersion:	5.19
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Russ Weight <russ.weight@linux.dev>
 Description:	Read-only. Returns a string describing a failed firmware
 		upload. This string will be in the form of <STATUS>:<ERROR>,
 		where <STATUS> will be one of the status strings described
@@ -37,7 +37,7 @@ Description:	Read-only. Returns a string describing a failed firmware
 What: 		/sys/class/firmware/.../loading
 Date:		July 2022
 KernelVersion:	5.19
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Russ Weight <russ.weight@linux.dev>
 Description:	The loading sysfs file is used for both firmware-fallback and
 		for firmware uploads. Echo 1 onto the loading file to indicate
 		you are writing a firmware file to the data sysfs node. Echo
@@ -49,7 +49,7 @@ Description:	The loading sysfs file is used for both firmware-fallback and
 What: 		/sys/class/firmware/.../remaining_size
 Date:		July 2022
 KernelVersion:	5.19
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Russ Weight <russ.weight@linux.dev>
 Description:	Read-only. For firmware upload, this file contains the size
 		of the firmware data that remains to be transferred to the
 		lower-level device driver. The size value is initialized to
@@ -62,7 +62,7 @@ Description:	Read-only. For firmware upload, this file contains the size
 What: 		/sys/class/firmware/.../status
 Date:		July 2022
 KernelVersion:	5.19
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Russ Weight <russ.weight@linux.dev>
 Description:	Read-only. Returns a string describing the current status of
 		a firmware upload. The string will be one of the following:
 		idle, "receiving", "preparing", "transferring", "programming".
@@ -70,7 +70,7 @@ Description:	Read-only. Returns a string describing the current status of
 What: 		/sys/class/firmware/.../timeout
 Date:		July 2022
 KernelVersion:	5.19
-Contact:	Russ Weight <russell.h.weight@intel.com>
+Contact:	Russ Weight <russ.weight@linux.dev>
 Description:	This file supports the timeout mechanism for firmware
 		fallback.  This file has no affect on firmware uploads. For
 		more information on timeouts please see the documentation
diff --git a/MAINTAINERS b/MAINTAINERS
index 6010aca09a7f..b97ee6f50679 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8147,7 +8147,7 @@ F:	include/linux/arm_ffa.h
 
 FIRMWARE LOADER (request_firmware)
 M:	Luis Chamberlain <mcgrof@kernel.org>
-M:	Russ Weight <russell.h.weight@intel.com>
+M:	Russ Weight <russ.weight@linux.dev>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/firmware_class/
-- 
2.25.1

