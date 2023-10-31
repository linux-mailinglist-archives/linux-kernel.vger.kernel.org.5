Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB597DC506
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbjJaDwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbjJaDw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:52:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E500BB3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:52:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BE6EC433C7;
        Tue, 31 Oct 2023 03:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698724344;
        bh=nm83Qpgy3r8SL0zu2xVQRrNZFYY/mrM4g1aglcYKPhY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e4nIrZEKfJ3KwfHa5Ap6Rr1b0WgFTihG4J4pJGV3WwypcdGjKeiGJa+g2cvp0/vKR
         ZmTtlEiBJSD5tzPYL5hc+eYu/GsaRpd6CsbIHE0GbXcZ90IdLDfyMC+ZboynXiubIA
         iR7cuEQXEjlQRFYZOZht+/UL5HPHBKBGKOUWP2AT+37xFFxwiLFjHgu5nTfIIGGadc
         6p79/z7ioN3USFT97FokSa0bTVnWWLgWf+fO3nkLnslz9EEvwEbWL0iTY5ySi/yEAS
         xlYPVO4DLDfgoAfjCZKSU+E//BKay5LMc+7s1Lo/0gTH9ydlF+kgQLS+sIGGQuJ6DS
         rzm5ZSPCBn67Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7328EEAB08C;
        Tue, 31 Oct 2023 03:52:24 +0000 (UTC)
Subject: Re: [GIT pull] core/core for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169861500709.181063.7816209662289132093.tglx@xen13>
References: <169861500709.181063.7816209662289132093.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169861500709.181063.7816209662289132093.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2023-10-29-v2
X-PR-Tracked-Commit-Id: 1aabbc532413ced293952f8e149ad0a607d6e470
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cc6fea175e41580000419a90fa744ba46aa4722
Message-Id: <169872434446.24385.7573624795059521347.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun, 29 Oct 2023 22:33:24 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2023-10-29-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cc6fea175e41580000419a90fa744ba46aa4722

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
