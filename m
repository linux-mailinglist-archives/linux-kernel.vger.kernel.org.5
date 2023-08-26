Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089D678979C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjHZPDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjHZPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:03:15 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA080E5;
        Sat, 26 Aug 2023 08:03:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B843DE1A7D;
        Sat, 26 Aug 2023 17:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1693062190; h=from:subject:date:message-id:to:mime-version:content-type;
        bh=PQY8pRZTlh1hNxRAMGxNP3xcvWUOFTxpD/BFKidKmgo=;
        b=EggrK5hzzfMDebPHdBDiOftGPcoxMw363oWH3GIm77ypEWxd/hoS+ON1nboeofwotHLj+e
        gIGOjXGkusnyrFr2tJjefP3ynV4aT+SZFCJKzxSvCBp3i/fTSFR0FQVV/NhUADSl5e9LJL
        XDAD2TZjqKOfNE7IewHRRNTBxT28KXw6YOiIuEhFjxwAAW6nXdp/wwpRd+uVNYmg04uRTg
        aeyPK+4kMNfcwh9WKdcSpZoi8uP7zWSSBdweaKjA/hPFiTk8TXNrVLkGT0rAyF0ps3qUme
        Jmtgj040xN3oR1u5sg2PRHuvGR3z1mFJOwLs2FHFI0+Aksyok/G3PCGC/rEhBQ==
Date:   Sat, 26 Aug 2023 17:03:04 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.292-rt128
Message-ID: <169306206792.7820.15513710483397536765@beryllium.lan>
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

I'm pleased to announce the 4.19.292-rt128 stable release.

This is just an update to stable release 4.19.292. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 6b3de4d487c20b013ab91bf85259c2b9a17b139b

Or to build 4.19.292-rt128 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.292.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.292-rt128.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel
