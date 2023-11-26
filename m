Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD17F947F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjKZRQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjKZRQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:16:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D782101
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:16:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB4CCC433C7;
        Sun, 26 Nov 2023 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701018979;
        bh=eMTj2o24vhfA0o7hw7dFsbbp37Se5iQMV8bj1nnpBMY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H0e3CpUjAGY0C3zArS05dLCrsXQHEu2Ij6myQWe8Qxkb01AHYjgncod2nWL+zm3I4
         NewLuFn1Axvip3AsT/+CsFnZStrcw2v6Na/cy2ndFPWuOAh1kl9IvCjjzRBttJ3hUQ
         GK58QaRyc9DbzpmyXqaCXSIcRIACG76hmlo4V1mYNN0354jrAbF/PMJCgX3Dqu9ujL
         xYG6MYmRLJ9lnODvJl+FgNdAaQ/pnDvsewa6CfyATW9dARnUyzFTM6De4ZMmtk+rrE
         4HNkRrWitGqGS4dLs5rmI26+xkO2C+gc6A5LoUDSUdbaCt68J6VVNsMpLGCZwJNjsT
         GlvaUeXPgo96A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97252C395DC;
        Sun, 26 Nov 2023 17:16:19 +0000 (UTC)
Subject: Re: [GIT PULL] locking fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZWMSTLo6kZ6qd6BU@gmail.com>
References: <ZWMSTLo6kZ6qd6BU@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZWMSTLo6kZ6qd6BU@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2023-11-26
X-PR-Tracked-Commit-Id: bca4104b00fec60be330cd32818dd5c70db3d469
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d0dbc3d16e8215838d9898d0191e8c0d2cc77af
Message-Id: <170101897961.23229.13673568662186939115.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Nov 2023 17:16:19 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Nov 2023 10:39:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2023-11-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d0dbc3d16e8215838d9898d0191e8c0d2cc77af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
