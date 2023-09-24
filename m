Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AEA7AC72A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjIXIwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjIXIwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 04:52:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810A1AF;
        Sun, 24 Sep 2023 01:52:13 -0700 (PDT)
Date:   Sun, 24 Sep 2023 08:52:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695545532;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZsEeDyS5paTJzH9zwSzLEM6Y6cidQ6FsJpf5qHHvIs=;
        b=IlJYRhPYkotvHOqfs+VSfBatX9bB4x74jt32R/5jyE8UbrlCrcflI4cxUovlTLV7SILIJW
        EuZ40jrvtEnMu/5+KDYZy9/6SBtbqHBs7ZfcweVb989NRxuNXCIaozqYbhw96OkNc78BMu
        Gkz7610lerlJvZGkBsmV0yufESAIPNExUjYsCzEQxyEtWTpJrrEu7s/BM/XaNQoEXF3mBU
        o2hB7NACCk4i0D0rYdCgQCqM4bJw+aY/XL058qFScyCnyg38O2KxLgaJlMerXTzgkah6HC
        pzmVhYPUC/gCKpzwADJlkQFfDgJRfemWflsajtZhpszTHvNdeBbda+seEI22yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695545532;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZsEeDyS5paTJzH9zwSzLEM6Y6cidQ6FsJpf5qHHvIs=;
        b=y60dddfBAGBA8Z/R8HorS6YUTGCXYlTiy46Da6LwNt6YpLEGV6MydcBv/yQxlWjzdMEo4n
        D9gmWe9pDX9fHgAg==
From:   "tip-bot2 for Jianlin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/iommu/docs: Update AMD IOMMU specification document URL
Cc:     Jianlin Li <ljianlin99@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230923071344.540894-1-ljianlin99@gmail.com>
References: <20230923071344.540894-1-ljianlin99@gmail.com>
MIME-Version: 1.0
Message-ID: <169554553146.27769.5661192900721180756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     c53cbc54ccffcd1f436f29456d8a8c9addb29c2b
Gitweb:        https://git.kernel.org/tip/c53cbc54ccffcd1f436f29456d8a8c9addb29c2b
Author:        Jianlin Li <ljianlin99@gmail.com>
AuthorDate:    Sat, 23 Sep 2023 15:13:45 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Sep 2023 10:47:35 +02:00

x86/iommu/docs: Update AMD IOMMU specification document URL

The previous link to the AMD IOMMU specification is no longer available,
replace it with the latest one.

Signed-off-by: Jianlin Li <ljianlin99@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230923071344.540894-1-ljianlin99@gmail.com
---
 Documentation/arch/x86/iommu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/iommu.rst b/Documentation/arch/x86/iommu.rst
index 42c7a6f..41fbadf 100644
--- a/Documentation/arch/x86/iommu.rst
+++ b/Documentation/arch/x86/iommu.rst
@@ -5,7 +5,7 @@ x86 IOMMU Support
 The architecture specs can be obtained from the below locations.
 
 - Intel: http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
-- AMD: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
+- AMD: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_3_07_PUB.pdf
 
 This guide gives a quick cheat sheet for some basic understanding.
 
