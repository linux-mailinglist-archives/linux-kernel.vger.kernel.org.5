Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4AD7B366F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjI2PNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjI2PNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:13:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7587DD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696000411; x=1727536411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I53SvhcrH4J2mJFhO6pxzxh9okkc+tFZV5xPDA23PJ4=;
  b=F+4MDXf9bCb8dE3BSydZPyFDNY/FHjKbSRSSqlehWb0C4N/VPTFZ+vjc
   c7qaLiB+cdIaQpmIQC7jaGIy6vDmSlJibQHDL6Oe84lUDwhuF9b/XCiPQ
   zb7C3g77R4Fnz+2tHmHokwEPQzFIEWDBWLUIlccxPkCXpYTx1oyRy2xmp
   FjMgoWOlYiI78Tw529ugEc9hc8cP/8ERdXyT/bShosyTeQZSvSR7jrJkV
   TTPizu3IpI76jsufePL3cpDVn1euhRMNzVqZj8VXo+3lmFJHaGvYhqRS3
   ufWjbQVQNDMTEUM5f60/+feAKZIv1KsT1iOcNPacGrYJ3LUorfs3YXWr5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="385137478"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="385137478"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="852673"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.5.220])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:12:56 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     russ.weight@linux.dev, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 1/1] firmware_loader: Update contact emails for ABI docs
Date:   Fri, 29 Sep 2023 08:13:26 -0700
Message-Id: <20230929151326.311959-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the firmware_loader documentation and corresponding section
in the MAINTAINERs file with a new email address.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2:
  - Removed sign-off from new email account
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

