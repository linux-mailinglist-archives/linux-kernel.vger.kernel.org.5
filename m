Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232AC7D9D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbjJ0Pqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346240AbjJ0Pqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:46:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349BC1A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:46:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD1B2C433C7;
        Fri, 27 Oct 2023 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698421600;
        bh=sptzVSKg3wUo76WXYKJGyC42u7/vX0Q6wTLQMJz6OBs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q0n6Ix2nAWZfSUflzZFO5LxkR05F95nL/uHYcHEqDLu2R/X3OweGMXLFehCh2UD0X
         NUpC/36CkwjGBrb+8XBdLVQ29I9tmUanc8OlMKFac7DTJ8RuhDVf2a//N2ZkO/nCW6
         PZ/44cO/68d8UyBNAqOW0YHnvTJEq/QNRCFVdk07txtXmYH82+q4HiRjznAdMWQH4e
         6I0ZY0pOmL2Wmjk3k/bJ1dGPQWpQ+TMcwJuwCAY+Ni6aUVSzMzn1Qa28e9UdgcTfAD
         ngGIkG2hO3qY2NCzPlyFqHQUsxXjfdfpfZjFZRZfC6o0sa5zjTcRozqju315qd9T97
         b6X6qC2Q2FZnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6757C4316B;
        Fri, 27 Oct 2023 15:46:40 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.6-6 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87edhgv5gw.fsf@mail.lhotse>
References: <87edhgv5gw.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87edhgv5gw.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-6
X-PR-Tracked-Commit-Id: 47b8def9358c5eb888e78b24b7e5b7f2e2e97b8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09a4a03c073bab5b375b71769f708d6932b370f7
Message-Id: <169842160074.21759.14383943322328308583.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Oct 2023 15:46:40 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 19:23:43 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09a4a03c073bab5b375b71769f708d6932b370f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
