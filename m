Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC08B7E5CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjKHRwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjKHRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:52:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE03F1FC8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:52:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59FE3C433CA;
        Wed,  8 Nov 2023 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699465934;
        bh=Cym+Itqt+a7hfn4WQZx9d8dB7QjJDa0zwSl8+MLQBFI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G5K2zxQKdjAgesc69RG0CSfZpMWRqpABRd7NhDZGFQ2NGlNugJjyTwxON5wpAhrig
         Zu2dnNiN7NyBlF5g8MjC3LRZvAGmZkxYHxAEWS3o+wye1Bkk8/8Y6V0K4yXdQ7tAI6
         DQzHt9kT4vsyStvLjVxhirPvULJRb8R2z24Pqc2WQSN3VltllNdV/2H9sTlKsEXxeV
         GnNVl2Gkr64PMlQLFT6mHYoQFZ/2MOT2dk46PJq2x1A/CX7MXmUAi99v6DLjnYCI4h
         dJi1i4P4Cism4HX+OvjYvJH9293bmbv+xSt2Ow8UREm2AExNfoEwjZGyrh876onr74
         FIphQG1TaY9DA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49690C3274D;
        Wed,  8 Nov 2023 17:52:14 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231106172848.GA27605@aspen.lan>
References: <20231106172848.GA27605@aspen.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231106172848.GA27605@aspen.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.7-rc1
X-PR-Tracked-Commit-Id: 23816724fdbd47c28bc998866fd7bc5ad9f0e535
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1ef4df14ed1feb9b0f08508390a196a1bc530ce
Message-Id: <169946593429.29156.9269217609980616624.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 17:52:14 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Yuran Pereira <yuran.pereira@hotmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Nov 2023 17:28:48 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1ef4df14ed1feb9b0f08508390a196a1bc530ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
