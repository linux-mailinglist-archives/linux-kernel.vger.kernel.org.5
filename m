Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA6A781252
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379263AbjHRRtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379241AbjHRRsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:48:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9893C3A99
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:48:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36EC360A72
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 17:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E2F8C433C7;
        Fri, 18 Aug 2023 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692380917;
        bh=pad4GBDqA243dE6LvLTYbftOopFzodX5JXZWRbucixQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U9yB6KvfgvfOaGwKv0aLKsz8tX8xRouMYh1arbOKHUbnX+LrD+d6FcjnNXWYc1Ugn
         WujEKrxLGQ+3PRowiR/4kHYA0OZudelYMVCiIpjYd4SFCR2CB1BY6qybZe3UVZuIqA
         KQnwfsaItT2w2hXDgRyyX1SneW4faq1IFaFzV5KpzewVwMyshpBn0btumW3fcCaChv
         +hM0K7eUdpVhIUzzKpNol+abcWGggh+j1C7ROvkaO0MyrgtNPHoAjFNFxzkzupusrf
         ZaQwZwzKN1f34EwJuiKOZmZuy2zwiqAg+EUiK4QCA6C5m8gSVG2OvniRRqova6cRZm
         PQo7dCmiP7n5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BA10E93B34;
        Fri, 18 Aug 2023 17:48:37 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-e50f03c7-2a36-48e9-bda4-8f04ff461826@palmer-ri-x1c9>
References: <mhng-e50f03c7-2a36-48e9-bda4-8f04ff461826@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-e50f03c7-2a36-48e9-bda4-8f04ff461826@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc7
X-PR-Tracked-Commit-Id: ca09f772cccaeec4cd05a21528c37a260aa2dd2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd479d9c72681606cbfaf1b77629187fe904cbee
Message-Id: <169238091756.10816.6116178516700260433.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Aug 2023 17:48:37 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Aug 2023 06:18:46 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd479d9c72681606cbfaf1b77629187fe904cbee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
