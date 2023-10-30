Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01327DC0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjJ3UGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjJ3UFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:05:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72550FD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:05:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF7ABC433D9;
        Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698696340;
        bh=1P62kfcP7S7n9/IVYnvnbjaTSf1XpA8/x0aok6sFJ3k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rxAOYzIkTvOwd3gnbMIjOHq3z9ARi6FMfsSvtBVyMUSPb69Dc8qtEMLPjQlMGm1Qt
         QMJvQLie+gguigLteehBhIs+QD5XWaIX6zOX8rRX+pUa4oAY+rkjCX7Y7DRxU6uG2q
         owUcCUPjpsAhweM8BzKWGFW5GRGUnSU9nPt/6H0AJtRwPKKHcv7vkpqzLZ148mx5vg
         zz7DPh7h4kJWRdH6FdOKTDT4fWIiPobBZLCBIuhF699PnJrJYATseFn5UScs318aA1
         4Y6Xm+9UHuZQbICTKKUZWQPzIK3SAueyNGPtC3V37gxjZRFwZL9ie0xeqvhwnicwHr
         Ikm62OgVXvRtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBC50C4316B;
        Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7] vfs time updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027-vfs-ctime-6271b23ced64@brauner>
References: <20231027-vfs-ctime-6271b23ced64@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027-vfs-ctime-6271b23ced64@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.ctime
X-PR-Tracked-Commit-Id: 12cd44023651666bd44baa36a5c999698890debb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14ab6d425e80674b6a0145f05719b11e82e64824
Message-Id: <169869634083.3440.2926215966082490773.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 20:05:40 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 16:51:07 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.ctime

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14ab6d425e80674b6a0145f05719b11e82e64824

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
