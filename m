Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D31E77AA39
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjHMRIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMRIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:08:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917B6E6A;
        Sun, 13 Aug 2023 10:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FAD7610A4;
        Sun, 13 Aug 2023 17:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93A89C433C8;
        Sun, 13 Aug 2023 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691946497;
        bh=95DuGE8+AOqKGVJ2gGgqUETsZDERshTs0NtSEEqwCJk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R7qoVziHpxi6ZcoaVHPjjAMEAe+QPbYpPM4XZCb1asRD256h5ckyyATjQKHCi/2+v
         11rg8NRIFaGWDoOApb9iPwButjnJT2WPKpV4oYis/YFPuVzNJYrcQc6b0SOviOt3Eu
         yokd+zBPvLMXcGXZAZ3VmWvvDH4ahVtYdhSuKML8yR17ICUhmf+TqM/YlhsRh+OKTn
         gcBc1w23QMQaknTmMu69DkoRevmKzAA1DEWiU43p5el8yceB+dMFyNCfK29r9qx/xy
         k/1Zw0n9uqplRZ9jOfBoVAT0G9KdlQ3oyHglnu7Uu2TMk1rwpi6UG+JrmzLWKWNKOP
         X4yo/kX99LEKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81031C3274B;
        Sun, 13 Aug 2023 17:08:17 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.5-4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <70d9417a-1b90-58ed-8810-fc617701d689@redhat.com>
References: <70d9417a-1b90-58ed-8810-fc617701d689@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <70d9417a-1b90-58ed-8810-fc617701d689@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.5-4
X-PR-Tracked-Commit-Id: 2b6aa6610dc9690f79d305ca938abfb799a4f766
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3dcf1473c711be5536321fa4d465b9ed9e42a0ce
Message-Id: <169194649751.27578.10639937632066845902.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Aug 2023 17:08:17 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Aug 2023 17:04:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.5-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3dcf1473c711be5536321fa4d465b9ed9e42a0ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
