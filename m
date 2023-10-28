Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB60E7DA878
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjJ1SRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 14:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1SRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 14:17:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2A4F1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 11:17:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6DB3C433CD;
        Sat, 28 Oct 2023 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698517064;
        bh=zt5DBCHyIs7M/GyGhp45dmKtI/S4U4JzAuw9C/fv/ak=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g6Ar5jqra/u1W/RyySDarl5kytupdacagCx3zHv0eLEaaFCToDNseW18LU4j2XaJL
         m74LDz7kNjPdRFyZud3qHbQow1287PQbE+Kwd/gTZqg5hRyubhHi2RqvpLkCXFc5eJ
         jmwSHBc2Vg9mZFF0iKv/nrLYJQl15W/j7gE1yhgoe7k0G+CbbwEIpdjZBLNNALsaYx
         310++ym95+cGA+rMMAD/vYAzsbHG13tlRR2f2HzMPUOZOrOVs46Wa1e8NAU0Mq3TWh
         j2lVy43ZEAK9Yf6ESE9gvrZvdXgp7BWK42+OtI4N+Lx3g9vb4J59Xle1yX4kYV/h3R
         zX0jE9qan4qoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE57AC691EF;
        Sat, 28 Oct 2023 18:17:44 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZT0KBBagVt7tf6nN@gmail.com>
References: <ZT0KBBagVt7tf6nN@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZT0KBBagVt7tf6nN@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-10-28
X-PR-Tracked-Commit-Id: f199bf5bf84c19a4f488a39d7d694ab10787de35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e663ab6bb56fa8f048cf8725aba577e56f7b2644
Message-Id: <169851706477.30729.14789890254916186157.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Oct 2023 18:17:44 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 15:17:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e663ab6bb56fa8f048cf8725aba577e56f7b2644

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
