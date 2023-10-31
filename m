Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1037DC60C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjJaFnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjJaFnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:43:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EA311C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:43:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ADB8C4E660;
        Tue, 31 Oct 2023 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698730954;
        bh=wiFU5F2e0IX25bhrCFVf4A/bfMDM4EeNvm81bV7ierQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rx/Ala1MBrHtIEzCKQ9iHCJY2x0Gwr2sBmUVFwtDD6OEXxNAFLXg0UQytl8Rz4Klg
         uC1DlW1ayjolwMMUAV/aXwd+J6gLa2lo6u1q9ftYEOI2dzgvJd66GuVUHh16Zr3fB2
         /WNVxNJAwuSEtGXVRn31U0R/1+Arp36Nc/E6GZAv9IfOiaDB5ZZWcWv1d45Vu3k1n8
         fGCguyftVQ4lr+5rlqw83HlRR/wXSQw0ub+fwmb3PPTpgdh0oayuHb6rF23n0cFoLM
         XBVF4hgrbEC5NuE1nAlUVBZELy2zokgrp1eKzWwWvVCcZIcBb12FyWGEnRt0pbuMMF
         tTw2+JsPg8tXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A181E0008B;
        Tue, 31 Oct 2023 05:42:34 +0000 (UTC)
Subject: Re: [GIT PULL] CSD-lock diagnostic changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5a551b5a-7430-4916-9a23-b235b19d6283@paulmck-laptop>
References: <5a551b5a-7430-4916-9a23-b235b19d6283@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5a551b5a-7430-4916-9a23-b235b19d6283@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/csd-lock.2023.10.23a
X-PR-Tracked-Commit-Id: 94b3f0b5af2c7af69e3d6e0cdd9b0ea535f22186
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a0f53e0cfc2ef262c05b8e4ab89e7f2accaf96c
Message-Id: <169873095449.17204.9976433443284021512.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 05:42:34 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, riel@surriel.com, imran.f.khan@oracle.com,
        leobras@redhat.com, peterz@infradead.org, vschneid@redhat.com,
        jgross@suse.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 15:26:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/csd-lock.2023.10.23a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a0f53e0cfc2ef262c05b8e4ab89e7f2accaf96c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
