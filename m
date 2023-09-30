Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49BD7B3FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjI3KOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjI3KOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:14:45 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3AD193;
        Sat, 30 Sep 2023 03:14:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCC4EE1A35;
        Sat, 30 Sep 2023 12:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1696068880; h=from:subject:date:message-id:to:mime-version:content-type;
        bh=UzIsXYxD9P3Gza5w3hSEkk1WbUWtORPdo3SRq6tAE4M=;
        b=vTeQb9p8Ieqgw9yX6jxPFejPEOksfbdUMHrpyrRsQLVIRnyprAqKAa5swsVDe5MV5nP/8O
        muo3SDNi8J1/KBrXLWdKbpEpMGcLNouhV4xWHlYxhMN9XlA4fta0RMv9bJaXoalFTTeslV
        dY+KPuyjyBEQT6IBGubZDRVovDMVpHUtZTLLZNbk5EXqMBx5rYnpDQIWmwzEF+AfC0uUFJ
        FOr2I/uCfUMQuh2+KYbAodgBzR78g3LZQLyU3OG4RVPZuK6N1n6o6eGj8JMlzf64UiGIoO
        S2wB/4QCZlVu4Y5FLoBB8zI+pWbGfm2dL02kZnpizknlvsy9U6MLym/26CKdnA==
Date:   Sat, 30 Sep 2023 12:14:35 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.295-rt129
Message-ID: <169606876208.5638.944952312238125046@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.295-rt129 stable release.

This is just an update to the v4.19.295 stable release. No RT
specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: b285af6da7f3b111dd0c285492defb01a4dc91ad

Or to build 4.19.295-rt129 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.295.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.295-rt129.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel
