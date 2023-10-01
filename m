Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386C67B48BF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjJARIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 13:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbjJARIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 13:08:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77128C9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 10:08:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11B02C433C9;
        Sun,  1 Oct 2023 17:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696180100;
        bh=x6xHK/oP1lLf66rl/M+l9nzvI0vnGrY4t/34MZxal8s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IBST/yMiHaLldCbeuesX5XTNR/uRKcDIIcqaXN9beQGPBJCeLErhjc1RLnZ10hpu0
         ZDCVIT2lIjlAtztYQa0M78sdJi1Bu+N4jFiXmz60f/6sBHSow+PPiXg2wKOjJyo8it
         iMtc/hHBdxMo4GM2cwmVfrI+AhA3k1qZs8FX5N+KsN/TC4YfQTVlX5/EShJyvvGn2N
         9TGxZO3sHWUzJhtPQLnnvPJnxoQIqLxknl+FkGlUl6Pk28Vz4uXt7xbUDhqJqIOvkh
         kwWP0FZpT5rqr7qTXhqP3EEaLOquZoP70V2wUvLEUyMozxH5YZKxTUmtswQzt5k0kH
         Er4SY155iHhnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8F33C395C5;
        Sun,  1 Oct 2023 17:08:19 +0000 (UTC)
Subject: Re: [GIT PULL] timers fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZRkzAN0rpNWCarZf@gmail.com>
References: <ZRkzAN0rpNWCarZf@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZRkzAN0rpNWCarZf@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2023-10-01
X-PR-Tracked-Commit-Id: 1a6a464774947920dcedcf7409be62495c7cedd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 373ceff28e7883e02ecf18d3e179d09bfcdab663
Message-Id: <169618009994.11241.7274511445875148478.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Oct 2023 17:08:19 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Oct 2023 10:51:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2023-10-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/373ceff28e7883e02ecf18d3e179d09bfcdab663

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
