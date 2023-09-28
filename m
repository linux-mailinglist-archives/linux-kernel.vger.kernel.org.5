Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55A87B2897
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjI1WvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjI1WvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:51:09 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A319C180;
        Thu, 28 Sep 2023 15:51:05 -0700 (PDT)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4D0CC3F123;
        Thu, 28 Sep 2023 22:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695941463;
        bh=KbFBLbvkQb3mPeMqC1sWezF5B1ggp+IfRkFO141qfQE=;
        h=From:Subject:Date:Message-ID:To;
        b=C/DXFD7+8Fm1B3zLJGwN0LDOQfsWcetAB0cmLjS2MuOTnjZFKhpZLM9UyStw6rm19
         LfkFFT/ip8Z9boN4n/RYJ2E6M/vWwRdBPi0zm49X+0tA2Ph35+KqcGgzUH6hDp/hqE
         6jf+J9uTd3yvmuZ+Z2jvEIUuSTJGnGx12M3+5XJ5Fohiwtmiqg+srlHgercwioVTbC
         EQJ3I8WV9784WJvlYOiXhjCuR0epWc1gSh3DXVITS/hYs57sWc/JaCPOEy9X0Z0Ykp
         4B4JcOsnHF84fbiK7NOhri/gnzWOw5zU0Up0zl4QVNMIlqk1HUV4SqLhukEfyZhQUc
         FOxBTmbMjEEaw==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.132-rt68
Date:   Thu, 28 Sep 2023 22:45:23 -0000
Message-ID: <169594112324.543186.7459296450667029199@jupiter.home.arpa>
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

I'm pleased to announce the 5.15.132-rt68 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: d535006be892b5b430a9cf866192ef8a407ec6d8

Or to build 5.15.132-rt68 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.132.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.132-rt68.patch.xz


Enjoy!
Joseph Salisbury

Changes from v5.15.129-rt67:
---

Joseph Salisbury (1):
      Linux 5.15.132-rt68
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index 5513b842ced2..df2c52c58e02 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt67
+-rt68
