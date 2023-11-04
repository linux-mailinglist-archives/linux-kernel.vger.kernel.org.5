Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CAE7E0D3C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjKDCKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 22:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbjKDCK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 22:10:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03476D53
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 19:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2A9BC433C9;
        Sat,  4 Nov 2023 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699063825;
        bh=vp2LCe1NDtHhc0JKJsro7GZbEPcGdy6yBebF1OT1q1M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aRGwbULddi6d03SpRCJ68pTlVuZs94itvC6j7b9GbIinD1adQ5WbVtWfftfan6/V/
         j/WimBeboDJAFjmwZZXAGEL8JMjL391PXd7XQg2GyrjXB8Nx2CK09vjDkLrECQ9ZBM
         u8I3zJYZ+foFUkgCFjlfZwGy5PQpneeify5VjlPdqYYHX++J88MBVKp9/9h0ePJ7RZ
         Ihvqse36g0/Rl3QYYp0CMTqxHr5ijGTMVeSUg47ZjmJ+MGZVIujmXTEhKgPlCdbrX/
         le5WoK2EiuRBFLlt3aCGeoiMSGWsvOF9Ohgd/1YChaHqsKjXMNFvXp3vwBvLtRzAf0
         +SR9T5gQhwDwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0AC4EAB08A;
        Sat,  4 Nov 2023 02:10:25 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc and other driver subsytems update for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUTh4pl9zi9EosKe@kroah.com>
References: <ZUTh4pl9zi9EosKe@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUTh4pl9zi9EosKe@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.7-rc1
X-PR-Tracked-Commit-Id: fa10f413091a43f801f82b3cf484f15d6fc9266f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d99b91a99be430be45413052bb428107c435918b
Message-Id: <169906382578.26291.12434347764105499590.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 02:10:25 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 13:04:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d99b91a99be430be45413052bb428107c435918b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
