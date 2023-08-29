Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC84C78CC76
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbjH2Suv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjH2SuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8AB193;
        Tue, 29 Aug 2023 11:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6145A61923;
        Tue, 29 Aug 2023 18:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0643C433C8;
        Tue, 29 Aug 2023 18:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693334984;
        bh=We/wZy/H58gMIwDP8kv3EpjUOVXcKT1DaX4avF5EqaA=;
        h=Subject:From:To:Date:From;
        b=nGRQcUgkYfIsGZBy8OdwT6N77394CCIqfcsNrHNaHbG5mHKmkMenjORFC6SnOw2T0
         2HPdanbgGOqnZ3WDVaknnIo3gfaxqGIw2oU/AjXaTbsT4k3MpRA3lDsQdjIxl+4Tch
         OkTxIT/rLz3vdYay0t7WljN65wPsfU9OVT6NpwS7uq7+5Bgt/SBPf99mWexp6cg8WK
         NdhIUOtqeFH6kpQed6dDMml0kEv+TrOKEaNnxty2MEMFgWGwjFY59M/3BRpZgh3fuE
         sLVabbmir5hS6ZEz4XHQTp7kvWvFIB4esAJbVtHlxb/9TC4E/qGYsh/qngqenkRUCs
         0U7enf/gvtGQA==
Message-ID: <1f176cb33783a5efa8fd95259a8ea28bbbe0da52.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.254-rt85
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Tue, 29 Aug 2023 13:51:38 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.254-rt85 stable release.

This release is just an update to the new stable 5.4.254
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 4d521cc77de3ccff2efa3103149846b39caf20dc

Or to build 5.4.254-rt85 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.254.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.254-rt8=
5.patch.xz

Enjoy!

   Tom

