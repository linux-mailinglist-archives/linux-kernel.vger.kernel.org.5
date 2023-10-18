Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28D87CE781
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjJRTOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJRTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:14:19 -0400
Received: from mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF40114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1697656440; bh=KGqlSDYBgWttHIyKz56cezEh4s6DnMn/uHHqAtaHZ2Q=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=l1gXdYSyRuJwtImnarUvdmkO1qFyaKI3DhuvRM1XwaJ3D60Q5CiE+Fpjieji0wWqz
         maPAA0QuWZl7fOhCq+G68H4kphX2IQZbZuAk0L5HigHfFO48t8Dpfnh1FMAKkX5MBH
         wKl0N0AM3G/dlw8n4p7j/qZMGi6f2hmnQm+qiPLs=
Received: by b221-4.in.mailobj.net [192.168.90.24] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Wed, 18 Oct 2023 21:14:00 +0200 (CEST)
X-EA-Auth: PNQy6XQwm0gdVvIHuOoPi65nI93ancTUU5UJb9uuFsXaKNI5l1yFOTyrmjbf5nkDWZG4QnGtqv6NOJZneH8bR4WWtBB5XN68
Date:   Thu, 19 Oct 2023 00:43:54 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Deepak R Varma <drv@mailo.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] accel/ivpu: Delete the TODO file
Message-ID: <ZTAucrOT69/tQK2o@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The work items listed in the TODO file of this driver file are either
completed or dropped. The file is no more significant according
to the maintainers. Hence removing it from the sources.

Suggested-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/accel/ivpu/TODO | 11 -----------
 1 file changed, 11 deletions(-)
 delete mode 100644 drivers/accel/ivpu/TODO

diff --git a/drivers/accel/ivpu/TODO b/drivers/accel/ivpu/TODO
deleted file mode 100644
index 9077217ae10f..000000000000
--- a/drivers/accel/ivpu/TODO
+++ /dev/null
@@ -1,11 +0,0 @@
-- Move to threaded_irqs to mitigate potential infinite loop in ivpu_ipc_irq_handler()
-- Implement support for BLOB IDs
-- Add debugfs support to improve debugging and testing
-- Add tracing events for performance debugging
-- Implement HW based scheduling support
-- Use syncobjs for submit/sync
-- Refactor IPC protocol to improve message latency
-- Implement BO cache and MADVISE IOCTL
-- Add support for user allocated buffers using prime import and dma-buf heaps
-- Refactor struct ivpu_bo to use struct drm_gem_shmem_object
-- Add driver/device documentation
--
2.39.2



