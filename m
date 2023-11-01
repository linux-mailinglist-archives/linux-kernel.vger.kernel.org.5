Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87757DE843
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346520AbjKAWre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346649AbjKAWrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:47:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC1C119
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:47:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56B95C433CB;
        Wed,  1 Nov 2023 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698878847;
        bh=b2oT5gvPaU3k2pCiHXeYhBxPtUKkjM/j2f5Mfnr5VBs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S9N9X65nTfNB9fr3xA4vDZVIEQ3SbBmu226gYUTsXts100W8Z3cnkvv0ARoG1mc7g
         UbQRwbzNoAq7WQtH/S+W8tlgswUBu4TCky/qLaJQ/VJstIvkb27AZTnM45hVxfQR4F
         1MJp7RTDeRMjFixQaZllZeJ9LpqMYsjZQJBw2y4qHf+/Qt7shwXSjIVWlj+lmBXzCS
         lYxmX3jdyLhvh1ummYQ5R+cc2PP6C6sJFAzTu1PGQNs9e7f5PSTWuICtDHyieEla80
         2tlP4Gz/HtlcWjtLOm2Sb86ilojVbG7WNlKvP7AGDiqlvn0O/x2FoNHC9CV1DJ20VQ
         a49uv+LXM6vTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 412A3C4316B;
        Wed,  1 Nov 2023 22:47:27 +0000 (UTC)
Subject: Re: [GIT PULL] io_uring futex support
From:   pr-tracker-bot@kernel.org
In-Reply-To: <49ec1791-f353-48f2-a39a-378b5463db42@kernel.dk>
References: <49ec1791-f353-48f2-a39a-378b5463db42@kernel.dk>
X-PR-Tracked-List-Id: <io-uring.vger.kernel.org>
X-PR-Tracked-Message-Id: <49ec1791-f353-48f2-a39a-378b5463db42@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/io_uring-futex-2023-10-30
X-PR-Tracked-Commit-Id: 8f350194d5cfd7016d4cd44e433df0faa4d4a703
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4de520f1fcefd4ebb7dddcf28bde1b330c2f6b5d
Message-Id: <169887884726.15957.2097278812294400804.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 22:47:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 19:07:01 -0600:

> git://git.kernel.dk/linux.git tags/io_uring-futex-2023-10-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4de520f1fcefd4ebb7dddcf28bde1b330c2f6b5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
