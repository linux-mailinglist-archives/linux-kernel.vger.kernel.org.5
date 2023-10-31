Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61367DC508
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbjJaDwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbjJaDw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:52:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7D8DD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:52:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5B92C433CA;
        Tue, 31 Oct 2023 03:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698724344;
        bh=8OOwWbqn0u242XLPajB028qRQqOaf5WRltHuDLH2D6k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GxboE7bz4MuA379B29SHlt+XcS3+EYt8T4k+ODnGhvQGnP1ED9PbY8kb9HBJlCoV8
         V+1oPOYWAZKt2e27XMSLBRn1tdklGIFPeS+EIizI4DNRr4VdrP5MZkmaoqhvjb3+MD
         x88tOGCffxnV2zNEsRPgBYyvHHdAu9LkPxbkn+bbYTUfGvSlDuN7reTCcgE0PPcjaP
         Dqvxhu8WWw5xklevARwRNcKhp5D3SSx8FnlwDfEEgGczTlIjWEW+e7nPuulSqw31tx
         AwzsNK/yWdLX2/4eTJyCIQ01WOYn4mT8nGqBJbHkbW+rUm3K0nbecrtpaPbrnKhZ4c
         F/v21ye4VV+hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADBE0EAB08C;
        Tue, 31 Oct 2023 03:52:24 +0000 (UTC)
Subject: Re: [GIT pull] smp/core for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169861501025.181063.9297786167357798627.tglx@xen13>
References: <169861500709.181063.7816209662289132093.tglx@xen13> <169861501025.181063.9297786167357798627.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169861501025.181063.9297786167357798627.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2023-10-29-v2
X-PR-Tracked-Commit-Id: 38685e2a0476127db766f81b1c06019ddc4c9ffa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c891e98ab32d55b25d87e380d919c279a8b228e0
Message-Id: <169872434470.24385.11294797935689355491.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 03:52:24 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Oct 2023 22:33:27 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2023-10-29-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c891e98ab32d55b25d87e380d919c279a8b228e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
