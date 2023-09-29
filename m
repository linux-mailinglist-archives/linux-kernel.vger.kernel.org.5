Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B5E7B3B01
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjI2UNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjI2UNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:13:05 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8BBDE;
        Fri, 29 Sep 2023 13:13:02 -0700 (PDT)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 451823F6BB;
        Fri, 29 Sep 2023 20:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696018380;
        bh=LVDBqRgihlYyMvjpKpLQK28/fYkJGJT8AaZTQ7CBI8k=;
        h=From:Subject:Date:Message-ID:To;
        b=cg7LWas/4WCwD/pOQLExP5BBF14G2yhph3SroooNdDkiemXmELjc8tvzobcSA/ipS
         gWX9oH/558C0KW9FarLgfIWrjociJX6wq4Sg4RdFPuX41MY6QCrCA914AK9Xw2RN+R
         joC2pr4cvaLkk5HhMkVZiLN6bGZ86o2HoHydEC7PTpI3/WNveHpwyPsXScXpQYy4b1
         rV5vkdvDkZ7DQbr0ScGvSTR9PA/k7eTfiD3AtSnnnCbFs5l9eHELBwufeJI+t5PzU9
         Vwo/a1KA2Fm9qeqW3GVjjW/pAGLwqo7ZkqzSi1kM2BFJRkHszsGL+Zp7f6xIbVRD++
         6dkveJkNQbrzg==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.133-rt69
Date:   Fri, 29 Sep 2023 20:09:37 -0000
Message-ID: <169601817715.599195.12973533850961346490@jupiter.home.arpa>
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

I'm pleased to announce the 5.15.133-rt69 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 8600e1d4ddea4824920029f0a44be69dae7c451c

Or to build 5.15.133-rt69 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.133.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.133-rt69.patch.xz


Enjoy!
Joseph Salisbury
