Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A465A785F02
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbjHWR5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbjHWR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:57:23 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A987810C2;
        Wed, 23 Aug 2023 10:57:20 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.174.176])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0D7A62126CC0;
        Wed, 23 Aug 2023 10:57:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D7A62126CC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692813440;
        bh=r8xGf241KhJ+PAFGmTd54K+9EDRTU0XlLMnU57lO/Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkHVYjkVij1IBFY4uHu6fVZlV20++QeFIyHJeUF5FnGuqzsD7XZXiuA40FMa8zIgl
         mhUfz3fWGug7p7WPzKQs/a/VNqdPIYo8TwxcNZH1NUiooJqIAuxtM0xkfw39gWA7A+
         /C++Xy0MzLcXKnTyA8aLxEm0OTFnIJhGk+4nHrb8=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5.15 2/2] MAINTAINERS: Remove iommu@lists.linux-foundation.org
Date:   Wed, 23 Aug 2023 17:57:06 +0000
Message-Id: <20230823175706.2739729-3-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823175706.2739729-1-eahariha@linux.microsoft.com>
References: <20230823175706.2739729-1-eahariha@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

commit c51b8f85c4157eb91c2f4ab34b0c52fea642e77c upstream

The IOMMU mailing list has moved to iommu@lists.linux.dev
and the old list should bounce by now. Remove it from the
MAINTAINERS file.

Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20220706103331.10215-1-joro@8bytes.org
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 MAINTAINERS | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c3f7ce19a79..5e69ba1220b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -433,7 +433,6 @@ F:	drivers/acpi/acpi_video.c
 ACPI VIOT DRIVER
 M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	linux-acpi@vger.kernel.org
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Maintained
 F:	drivers/acpi/viot.c
@@ -941,7 +940,6 @@ F:	drivers/video/fbdev/geode/
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
@@ -5597,7 +5595,6 @@ DMA MAPPING HELPERS
 M:	Christoph Hellwig <hch@lst.de>
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
 R:	Robin Murphy <robin.murphy@arm.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Supported
 W:	http://git.infradead.org/users/hch/dma-mapping.git
@@ -5610,7 +5607,6 @@ F:	kernel/dma/
 
 DMA MAPPING BENCHMARK
 M:	Xiang Chen <chenxiang66@hisilicon.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 F:	kernel/dma/map_benchmark.c
 F:	tools/testing/selftests/dma/
@@ -7112,7 +7108,6 @@ F:	drivers/gpu/drm/exynos/exynos_dp*
 
 EXYNOS SYSMMU (IOMMU) driver
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Maintained
 F:	drivers/iommu/exynos-iommu.c
@@ -9453,7 +9448,6 @@ F:	drivers/hid/intel-ish-hid/
 INTEL IOMMU (VT-d)
 M:	David Woodhouse <dwmw2@infradead.org>
 M:	Lu Baolu <baolu.lu@linux.intel.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
@@ -9790,7 +9784,6 @@ F:	include/linux/iomap.h
 IOMMU DRIVERS
 M:	Joerg Roedel <joro@8bytes.org>
 M:	Will Deacon <will@kernel.org>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
@@ -11791,7 +11784,6 @@ F:	drivers/i2c/busses/i2c-mt65xx.c
 
 MEDIATEK IOMMU DRIVER
 M:	Yong Wu <yong.wu@mediatek.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
@@ -15551,7 +15543,6 @@ F:	drivers/i2c/busses/i2c-qcom-cci.c
 
 QUALCOMM IOMMU
 M:	Rob Clark <robdclark@gmail.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
@@ -17980,7 +17971,6 @@ F:	arch/x86/boot/video*
 
 SWIOTLB SUBSYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Supported
 W:	http://git.infradead.org/users/hch/dma-mapping.git
@@ -20561,7 +20551,6 @@ XEN SWIOTLB SUBSYSTEM
 M:	Juergen Gross <jgross@suse.com>
 M:	Stefano Stabellini <sstabellini@kernel.org>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Supported
 F:	arch/x86/xen/*swiotlb*
-- 
2.25.1

