Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BED7755627
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjGPUsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 16:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjGPUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 16:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963D9E41
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 13:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B40160EC2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C4ECC433CA;
        Sun, 16 Jul 2023 20:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689540482;
        bh=62MPfyUFHR8NE84twPCitfwcP74rDfb6hhu2Dpx8DM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VALYxgr1D3wEO8GXwmy6EWGmulZglsuwTuiVLe8xD3ihbLXr2kT3rHMUfIGHoMi5H
         iRRkmXlTjpgbDalez3MZPlK54RUhnKn6zpjubPEA7bpUP+MHdIAavHJKpgRkROZZ3q
         wohT45q7Hr2+0zIuFfHBjUorf80CFxryvdwrGclGxdq0ELwEk2vFo2rl+5esrqQmEw
         uJwOrkjWdpyuCHNn4Q9DAjc6hz+U/1FEcQMKdJKFjpDwKYD1yPAt20Q1c/P4mlfXX5
         Tb5Y4SRrqfnxIxxv2vYR+xV6alqkYHXxUtXMW+ME1z66sU4+jHgbVT2lTTpeyB90Gt
         KiTqAEVY9Y6dQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 654BDC6445A;
        Sun, 16 Jul 2023 20:48:02 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for v6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230716184204.GFZLQ5/DJ1+q8vpuuN@fat_crate.local>
References: <20230716184204.GFZLQ5/DJ1+q8vpuuN@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230716184204.GFZLQ5/DJ1+q8vpuuN@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.5_rc2
X-PR-Tracked-Commit-Id: 719a937b7003933de1298ffa4b881dd6a234e244
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a3e4a64849eb9da0e8c7e693978499562581631
Message-Id: <168954048241.28685.16664072685070535382.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jul 2023 20:48:02 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jul 2023 20:42:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.5_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a3e4a64849eb9da0e8c7e693978499562581631

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
