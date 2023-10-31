Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68CC7DC505
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbjJaDwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbjJaDw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:52:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1468FD8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:52:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4E16C433C9;
        Tue, 31 Oct 2023 03:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698724344;
        bh=Na/gkgLCzfErA0VsszzyzY2iOJqx9p57WvpcYOx+X6A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SB8CYX2u3CkC3efwhty82pGyuS37UqSGNDK+YVemXOPm0t0MacoE2TkPvMHiponor
         npXLVAR5KiU7x3gawBQ+NEaBkIvsffNsJa+mqcQ62BC5pKXIgYW0ffd7ZLvMx7T7qP
         cXPYe8DinpcDjle6CznAwxbcPsyNqh7pXDyrZLGNGmOQ+2ux+tCmWEiN/8UNI9B5zE
         KOkAuBVtLcQhgdvDe6c0qbP/yTjoX/jpp/DYeIoS9EuWK1zlS78aeYgCovHjiUpgK3
         6cTJBkg6PAsDtP3TYvqK9fMCo2CYCty8ysY3BI5n6ZRk29Rt8q3453D/Sxb58mOs9q
         QHQazbh8qw27Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A1CDC595D7;
        Tue, 31 Oct 2023 03:52:24 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169861500873.181063.15886241927509430280.tglx@xen13>
References: <169861500709.181063.7816209662289132093.tglx@xen13> <169861500873.181063.15886241927509430280.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169861500873.181063.15886241927509430280.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-10-29-v2
X-PR-Tracked-Commit-Id: f99b926f6543faeadba1b4524d8dc9c102489135
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b08eccef9fa05f8e14fe180d55d603447c76a992
Message-Id: <169872434462.24385.3044429607973496493.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun, 29 Oct 2023 22:33:25 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-10-29-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b08eccef9fa05f8e14fe180d55d603447c76a992

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
