Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0FA78BB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjH1XKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjH1XKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:10:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1474311C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B28E64556
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0901AC433CB;
        Mon, 28 Aug 2023 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693264233;
        bh=tR8Rf3HA1coNyNUHkumCjfvy8TTIUnJkJuRALL3Zz4Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lLIjl5QIMmK+NH1jmx7Xr8Bb2jBGvUm9C8tJMge2nI/DCZYMf+vKa/w68u+q8vDuH
         6boL5QYObFOo4tXbINGdnkxpQEpa5NZ55uOTsjzq+m3/r+mNtrxxqtbPnQofgKOEhC
         mZegiEbiN1VerVFdKH+d7DuSf3J4sSMy1pxUsqFZ6nxHUO8cKgC51KvAF3WSFOY/+o
         CdTtyh9xnZJswfHSWZ7dkDE8Uozg0V5SHzXnXMuOg4rNJh4CJd0uoE5i3M/dzwL9sd
         VfWT1R2EVE0ULopx94zpeYoMMFHlLvrdadTzBVOx/atpFiZRrAJfT3aCV59uqbu6b8
         YNWgEjhC5X0mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E25F7C3959E;
        Mon, 28 Aug 2023 23:10:32 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230828054215.GBZOwzt/7NYwNRtP3U@fat_crate.local>
References: <20230828054215.GBZOwzt/7NYwNRtP3U@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230828054215.GBZOwzt/7NYwNRtP3U@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.6_rc1
X-PR-Tracked-Commit-Id: 1393bc8c6a3311bf6496e704c59870e0fc44a2c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e5e832c589b8952653c38bccb85d1489726c5be
Message-Id: <169326423292.4748.7249652828010448740.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 23:10:32 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 07:42:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.6_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e5e832c589b8952653c38bccb85d1489726c5be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
