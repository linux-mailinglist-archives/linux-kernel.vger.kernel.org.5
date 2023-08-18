Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9204D7806D7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358337AbjHRIFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358442AbjHRIF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:05:28 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A712C;
        Fri, 18 Aug 2023 01:05:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1ED81E1B24;
        Fri, 18 Aug 2023 10:05:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1692345921; h=from:subject:date:message-id:to:mime-version:content-type;
        bh=EeRbKnQpjntMIO/ryGf5Q5SKBddhBJN9JW1H6H6kaUQ=;
        b=NlY7auIGVyySyEM23L+usdikgEwXwEKCSeKrofaZFm2PdjihxhpdtyzypZQaqQZa/yN5dM
        GHjCyjC0hLoIRoEDZmvP07QXc13UQuWudjZe5yL7x4/ZCknDZstuGPEfm3NChMibx/CR85
        /FPZ/cTrNOd9xT6ql4gmcxhldcVvkscYD98oWcO8lPHChcLmQiJ/nR3WAYVAA4Rkp/OFfR
        PyRnEf9DQVUxiGOBnF2LNP6oJ4q3qiq9k7q3jAIXaN0f/itghRMnkREczgQeNi1fbfGnAN
        hmV3wfu5OhgQf28DhxCQPodL4wDeVAZ5mY129qRQP2lb9Zr6HZYm50y3rDu+7w==
Date:   Fri, 18 Aug 2023 10:05:16 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.291-rt127
Message-ID: <169234577719.11200.16378739204651396727@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.291-rt127 stable release. This
is just an update to the 4.19.291 stable release. No RT specific
changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 1659a7a5976b7d127243f6a7e8807dd2f81ad6ca

Or to build 4.19.291-rt127 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.291.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.291-rt127.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel
