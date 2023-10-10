Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6977C03D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbjJJSyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343738AbjJJSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:54:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20B9AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:54:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 544D9C433C9;
        Tue, 10 Oct 2023 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696964077;
        bh=RIB9C6XPMPNdJ/5cL/ns1jkMiQK8VjwsjnsF5D+pvPU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hiozb8dPISeFDu/6zUqy8mNnrjgVkVx2uSOR+U0LytE4N9BHacxamSO34ypjQa7Qa
         4rQR9yuR7m+UjYIg65nVKrxex6+a+y8bZAubjiku448D/2lVnPjBBBer4FkSsHxad7
         eVsN9Bkrqe6xyyHkK0StziPpJV9PJttXC4vokpg23xDD9E1EgYWtUwFcxflH7PBuuC
         GHuJReZcU0MymUpfG8jKsrluvKYo9u+krcNP0RIj2jSTv3ZUwn/yjZkLIagr6es3+e
         09vXYmy9M3jJaU74J4vWjNRMUoPKs7fxDiRYI/KR0xI6Gbmvpm9O/ARjZp6KbiiWUe
         aB/0M8nkOxc+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4252DC39563;
        Tue, 10 Oct 2023 18:54:37 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169694008423.592696.537997109199439608.tglx@xen13.lab.linutronix.de>
References: <169694008423.592696.537997109199439608.tglx@xen13.lab.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169694008423.592696.537997109199439608.tglx@xen13.lab.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-10-10-v2
X-PR-Tracked-Commit-Id: 4dc5af1fee55e38b5016e45b66bec1e1312973f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87813e13df5ca4d899e2da0bc37d40f9a95788ee
Message-Id: <169696407726.29903.12444578057920098944.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Oct 2023 18:54:37 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org, maz@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Oct 2023 14:16:29 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-10-10-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87813e13df5ca4d899e2da0bc37d40f9a95788ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
