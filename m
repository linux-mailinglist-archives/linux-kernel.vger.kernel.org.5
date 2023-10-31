Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2087DC507
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjJaDwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbjJaDw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:52:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F257E6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:52:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15276C43391;
        Tue, 31 Oct 2023 03:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698724345;
        bh=C8ElcAvCQEN65n0R3rRdGrg4JyBIF1eDsFIwyO1+8iM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QO9lOPY4XowYEmh05iMfBl6x6GqHoqi7n0mmimUNcbnh+3GB6Kid5Qg96l/xMXVr9
         qoscxQ6NwVSIAGGp2GH+9ove30DDfNU29qP3y9rQJRUPlY4FojlyvoTpc2sITxNG6n
         M1nEWZDsIJ/IoGAl5uf+VVeHdYj9ye+NuCKzLihUpJeJr2LEMdgrqBGCTv3m1T+4dv
         Av4HHyTt0vVmvYCfxO7dM3h/Ke6qU7WxllroGkOOmyYwSaHXsec5XxFT1l+p7sMr4d
         ifvSCoxfO/UR65MKmLH7u947NYfOwPEPaKh+KbIDAPA8NxTxFQAAFsdvslMkFC0tzl
         sfdZkURgPOgsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04624EAB08C;
        Tue, 31 Oct 2023 03:52:25 +0000 (UTC)
Subject: Re: [GIT pull] x86/core for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169861501491.181063.16482926252873802124.tglx@xen13>
References: <169861500709.181063.7816209662289132093.tglx@xen13> <169861501491.181063.16482926252873802124.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169861501491.181063.16482926252873802124.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-10-29-v2
X-PR-Tracked-Commit-Id: 92fe9bb77b0c9fade150350fdb0629a662f0923f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb55307e6716b1a02f7db05e27d60e8ca2289c03
Message-Id: <169872434501.24385.1120217769435096506.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 03:52:25 +0000
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

The pull request you sent on Sun, 29 Oct 2023 22:33:33 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-10-29-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb55307e6716b1a02f7db05e27d60e8ca2289c03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
