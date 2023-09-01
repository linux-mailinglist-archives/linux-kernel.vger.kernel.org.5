Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AFA790264
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350587AbjIATGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjIATGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:06:10 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A2BE56;
        Fri,  1 Sep 2023 12:06:07 -0700 (PDT)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BEBA43F203;
        Fri,  1 Sep 2023 19:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693595166;
        bh=PCEEHPOH5Byzgh9I0eb01hieWBTp2uIfmm719xA53Fo=;
        h=From:Subject:Date:Message-ID:To;
        b=vIH5JELg028v4JUFJT3BXtNJlDhJrVmt2OlyfgMC/lzwq7gz8D0qygmltzclpHY1o
         M3A9tDv7gLX//6MjWKBajvo+7mtIyjJrrMG12toCUKcEV/xz39/3SzQ+RMDz/H9YiG
         02Yi/RnnJsshm3VnN6ouDAOhtSGPs4Ftu+hNdC1nNhq3Sg9w9otHl0QInGHcV7wfGS
         n6enQRuRXF9lcsQncp5Bz2mAh9qQsU/i+HbaLvSUYTJr12bd2P3frIoDkpOSn9wLQn
         5sM995ba5ucnjjQrdEoJ9TQj6mzkHIXeaiqlZdyRZcvNnkDJefSlf7GFnE9pJ2Lvux
         sTWxLjkn331OQ==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.129-rt67
Date:   Fri, 01 Sep 2023 18:59:44 -0000
Message-ID: <169359478488.962731.2224863377696117508@jupiter.home.arpa>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.129-rt67 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 9157353f3ecf223b612ee734907ccefc4fa50760

Or to build 5.15.129-rt67 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.129.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.129-rt67.patch.xz

This will be the last release prior to moving to the release candidate workflow.


Enjoy!
Joseph Salisbury

Changes from v5.15.125-rt66:
---

Joseph Salisbury (1):
      Linux 5.15.129-rt67
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index d42c0971b041..5513b842ced2 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt66
+-rt67
