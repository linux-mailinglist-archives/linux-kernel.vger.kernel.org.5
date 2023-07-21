Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2975BDFC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGUFuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGUFtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:49:36 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DC730F5;
        Thu, 20 Jul 2023 22:48:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8A1BDE5C6;
        Fri, 21 Jul 2023 07:48:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1689918521; h=from:subject:date:message-id:to:mime-version:content-type;
        bh=OEeJPBxACSKbYtUUjSqpUZyKYshaRkx5xyrD/F/5Pbo=;
        b=OQ+F7ODRUOTL2eVrDi3COKsQTq+kaeKy8nR+QKOjFqBz06Vqv57u9prJQSJd28LO15801Y
        /P9eWWi5MB1EkvbVBMCE6w60AR9m7eZt8gYxayXjBPG5nLyITk4n2kMfGDmTVx+a+qPH3a
        xN1b8vGgcZBVEVq3gjUp7iduU/j4VyAhcW7blXvtDGZH4vd9Fef+vmXeyEy23wRcNcbj+y
        76c6aMi7VnYcm5HLg/A1dcQzEwR2H35mSmo2Lz16OEfNfttS7RmdVNiDNfo7XSJHLXJ93G
        7AVX4JVdEOtJfeZuVzGv61VZPYFdzeEBe7GDEWFJCbWl1Hvj3miuxHb0ZgE7tw==
Date:   Fri, 21 Jul 2023 07:48:33 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.288-rt126
Message-ID: <168991842493.5654.5683918391499697984@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.288-rt126 stable release. This
is just an updated to the latest stable release. No RT specific
changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 83db5d9eb0eda7bd0c990b1e5bc7885791c7017e

Or to build 4.19.288-rt126 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.288.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.288-rt126.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.284-rt125:
---

Daniel Wagner (1):
      Linux 4.19.288-rt126
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
