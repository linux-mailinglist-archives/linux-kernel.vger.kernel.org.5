Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7CE785F01
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbjHWR5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbjHWR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:57:21 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E973610C3;
        Wed, 23 Aug 2023 10:57:19 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.174.176])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6F2592126CCC;
        Wed, 23 Aug 2023 10:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F2592126CCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692813439;
        bh=V7ECB07wTxjvga0Bv6bi6zgk08APt8aJh0IJ0uapMEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+3GvafNjrnMJHNxYiYfqkjc1RgII+DLaog+IRGXN1RGkEK4S6xt2Ex1/uB68bnJo
         qszJ0FDqw2JAsCQ407Mls0yKDPaZW4j3ofRAMDeTEPMcyGxfKSvYLrY9kqHS75gte2
         AMCvt0RqriWXuFPf0kE1h1ZnCpoZAmrJA+1Fqf+Y=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     Xiang Chen <chenxiang66@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5.15 1/2] MAINTAINERS: update maintainer list of DMA MAPPING BENCHMARK
Date:   Wed, 23 Aug 2023 17:57:05 +0000
Message-Id: <20230823175706.2739729-2-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823175706.2739729-1-eahariha@linux.microsoft.com>
References: <20230823175706.2739729-1-eahariha@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

commit e62c17f0455a74b182ce6373e2777817256afaa1 upstream

Barry Song will not focus on this area, and Xiang Chen will continue his
work to maintain this module.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Acked-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6b53e76651b..6c3f7ce19a79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5609,7 +5609,7 @@ F:	include/linux/dma-map-ops.h
 F:	kernel/dma/
 
 DMA MAPPING BENCHMARK
-M:	Barry Song <song.bao.hua@hisilicon.com>
+M:	Xiang Chen <chenxiang66@hisilicon.com>
 L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 F:	kernel/dma/map_benchmark.c
-- 
2.25.1

