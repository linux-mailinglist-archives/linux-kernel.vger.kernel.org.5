Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0DB77A0F5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjHLQI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 12:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHLQIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 12:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F6410FA
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 09:08:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1554261B0A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 16:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B9A2C433C7;
        Sat, 12 Aug 2023 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691856500;
        bh=06kR6HWbxRrQBbQzs5M3C5HxLWvfmod4UorBD2rx19E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d7HFfRj0TMnjdtWN0XtsnuopBdfgk8h/P+YY6zv5uu8fjGq89pkz9RrKRlQCO3MUn
         yMUm/s4ypnsal4lGEeGTkKucFeq2Xdc1jNGA3/1LFa6vsLGO0Z6zspPiTKxNi2LZdj
         xJXZOsfHBrgP2LmRbxqj8cdICv+f/pTtvAWr5i6AyDoPbLafkTSW/UW+PfkTwBsfhS
         M0+D2DHiCyj7TRCEUgZ0ohCHYdbRQslXIxvr5xxW0vCYJNt4Bg+rsBr50zXb77qDoQ
         grbMOLMihwlM/eud2Sx8rgWW1Oj0FHVsERDMdOTFrhrJ0bQBuMtlhGztd4udvtdIkr
         Wa26YCxpMUZiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 525C2C64459;
        Sat, 12 Aug 2023 16:08:20 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230812095017.GBZNdV2ZstbkUO+a13@fat_crate.local>
References: <20230812095017.GBZNdV2ZstbkUO+a13@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230812095017.GBZNdV2ZstbkUO+a13@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.5_rc6
X-PR-Tracked-Commit-Id: 6dbef74aeb090d6bee7d64ef3fa82ae6fa53f271
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43972cf2deb2f54a97530c82b88c555fd682428e
Message-Id: <169185650033.27778.7138760789758947482.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Aug 2023 16:08:20 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Aug 2023 11:50:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.5_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43972cf2deb2f54a97530c82b88c555fd682428e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
