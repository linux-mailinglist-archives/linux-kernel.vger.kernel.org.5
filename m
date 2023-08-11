Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3967793E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjHKQJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKQJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:09:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5CC100;
        Fri, 11 Aug 2023 09:09:36 -0700 (PDT)
Date:   Fri, 11 Aug 2023 16:09:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691770173;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cXYfpMzUYguskcqo9HziCt6lFBVLknD46HoylNqVPXA=;
        b=wNAlz9Gh7CQTvgwz+Bt2CSR58X4rMC5AeY9WYFahTFbkQC7QEomj0G8Rg7OPNzWr8yGaYx
        rUkIDUn7gder6SPbFHO48WnAGnH0scaJuicXKkRhieJgBQy+Csl/V2ITUK1QvT4M+gxzJd
        NNjOI73RljpNKsbuZ/uhqUcRkNsCRI4IuMlL7hTEtjPAF9ncVFfqnFwyracnQo6lQBhhdJ
        0Fn6DKWc66ZzJfQHjdq+F7DdQ+vDvwn+Kptpoid/5e61kzgHvzsuhkfFlylse+IA1Cxtiz
        STtNJES8wf8+R/Ztsw3wEwq3FptygKruapbGJlmSLEjRDJN5OulC+m0T2Pnk6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691770173;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cXYfpMzUYguskcqo9HziCt6lFBVLknD46HoylNqVPXA=;
        b=TJAd44epnJ8BFcqS/IcJzkpPyOPpr9fd9v7H33cmI0EsESze7na+YpfY53bfP3uLfgPc4x
        ndjOmDzjdX+X/rAA==
From:   "tip-bot2 for Justin Ernst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/uv: Update HPE Superdome Flex Maintainers
Cc:     Justin Ernst <justin.ernst@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joel Granados <j.granados@samsung.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169177017294.27769.10099440426367314269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     1393bc8c6a3311bf6496e704c59870e0fc44a2c3
Gitweb:        https://git.kernel.org/tip/1393bc8c6a3311bf6496e704c59870e0fc44a2c3
Author:        Justin Ernst <justin.ernst@hpe.com>
AuthorDate:    Tue, 01 Aug 2023 10:57:56 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Aug 2023 09:02:39 -07:00

x86/uv: Update HPE Superdome Flex Maintainers

Mike Travis has retired. His expertise will be sorely missed.
Remove Mike's entry under SGI XP/XPC/XPNET DRIVER.
Replace Mike's entry under UV HPE SUPERDOME FLEX.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Joel Granados <j.granados@samsung.com>
Link: https://lore.kernel.org/all/20230801155756.22308-1-justin.ernst%40hpe.com
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f966f0..7998c1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19283,7 +19283,6 @@ F:	drivers/misc/sgi-gru/
 SGI XP/XPC/XPNET DRIVER
 M:	Robin Holt <robinmholt@gmail.com>
 M:	Steve Wahl <steve.wahl@hpe.com>
-R:	Mike Travis <mike.travis@hpe.com>
 S:	Maintained
 F:	drivers/misc/sgi-xp/
 
@@ -23142,7 +23141,8 @@ F:	arch/x86/platform
 
 X86 PLATFORM UV HPE SUPERDOME FLEX
 M:	Steve Wahl <steve.wahl@hpe.com>
-R:	Mike Travis <mike.travis@hpe.com>
+R:	Justin Ernst <justin.ernst@hpe.com>
+R:	Kyle Meyer <kyle.meyer@hpe.com>
 R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
 R:	Russ Anderson <russ.anderson@hpe.com>
 S:	Supported
