Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E823754CD3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 01:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGOXvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 19:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGOXvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 19:51:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596501FEE;
        Sat, 15 Jul 2023 16:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XGMqHpO0IlQS1LESo07MXYq+MnOltcI0tcyM9SWJvEI=; b=Am8FYRPKSaiEweeMhkF+bLVIdL
        l652zTjdr/Wm69ZmkQ+DBFqTH65RCw9Otp3c+NTPxPbshFxzp8V7ZXAlO7HA3YtPhSCqYMmasJZH3
        J/zZ61MYRRXemt0bQxZkfiLXQqUWqPOhYFfESDKdY+Sk9rC68IK+xLx3a85pK+Gr7yUSFcSJ/TKpR
        hoQgJuWw65YaHOW/hRAh6IrVwXghPj7v6I9es8vQNuwv7iHgfpb+gqQvIY6vNM1OgDYfI/2fHMFYQ
        xca24EDTeNnBWrXQ8x3jTUopFoP3nYJu3DNb4RysB0qG99H3F2eoUYZfwOn3s8paZIL6yHjbLl8Yw
        F8A4YQzA==;
Received: from 50-198-160-193-static.hfc.comcastbusiness.net ([50.198.160.193] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKp2Y-009h5w-2J;
        Sat, 15 Jul 2023 23:51:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] Docs: kernel-parameters: sort arm64 entries
Date:   Sat, 15 Jul 2023 16:51:05 -0700
Message-ID: <20230715235105.17966-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the arm64 kernel-parameters entries into alphabetical order.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 Documentation/admin-guide/kernel-parameters.txt |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20230714.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20230714/Documentation/admin-guide/kernel-parameters.txt
@@ -418,20 +418,20 @@
 	arm64.nobti	[ARM64] Unconditionally disable Branch Target
 			Identification support
 
-	arm64.nopauth	[ARM64] Unconditionally disable Pointer Authentication
-			support
+	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
+			Set instructions support
 
 	arm64.nomte	[ARM64] Unconditionally disable Memory Tagging Extension
 			support
 
-	arm64.nosve	[ARM64] Unconditionally disable Scalable Vector
-			Extension support
+	arm64.nopauth	[ARM64] Unconditionally disable Pointer Authentication
+			support
 
 	arm64.nosme	[ARM64] Unconditionally disable Scalable Matrix
 			Extension support
 
-	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
-			Set instructions support
+	arm64.nosve	[ARM64] Unconditionally disable Scalable Vector
+			Extension support
 
 	ataflop=	[HW,M68k]
 
