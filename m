Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856F87B497F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 21:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjJATxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 15:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjJATxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 15:53:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322C1C4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 12:53:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC05FC433C7;
        Sun,  1 Oct 2023 19:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696190001;
        bh=/zre9Ne5Y2kTgyPjhPOMios+QY8vbkRgPgfDc8aYJrQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tVz1IhEpeTGezAv4pQgphnQd6VjxFJnXTPy+qe6TzwnnwBJHkMw+T8rr1Zp24K3yb
         /C/6xs9MW573kuHfZXGuf+QDQ6fyDD34PlexKKkX3hDjAgY90ZddITKRWTm4SbRsUo
         zvSPK3xxKgK4Gn0iSl0PHw1Pk4XfxKoPVhzffcl6UxGiqp14MspiAcXVPNmItWv1Rd
         PF88XcYCbk/hl8HCnqlDQ+4e0acF57A+EsEAuHnyVVnK3HN4F8N6dKKSPxZRwqM366
         eeYFzYiXtcIsoDCo1RTpuR8Dh+Tccy9nJAladlWMncKNu8KZN5u/UJp7gsu1DiwL26
         45DxolbarzKcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9555C43170;
        Sun,  1 Oct 2023 19:53:21 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fix for 6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZRllP2-4Lxm3t49d@kroah.com>
References: <ZRllP2-4Lxm3t49d@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZRllP2-4Lxm3t49d@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-rc4
X-PR-Tracked-Commit-Id: 0e4cac557531a4c93de108d9ff11329fcad482ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f633369413f189d81069a5048c7d67c815f59a7
Message-Id: <169619000175.19173.11212756245224638581.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Oct 2023 19:53:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Oct 2023 14:25:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f633369413f189d81069a5048c7d67c815f59a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
