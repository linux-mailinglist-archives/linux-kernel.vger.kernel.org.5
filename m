Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C497DC0FA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjJ3UGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjJ3UFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:05:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37981D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:05:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F032CC43395;
        Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698696341;
        bh=2I3yR0Y3qNE8R4J2WTCcp23m8YYQIdsHI8jSUxokxDk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jKCusVtA8Rho5E+QUsOrN4VVlUByrY0B4ukogY1+QTa1xV4aB7XKkT1lJYxZNt+Dt
         umicJGeZPhKPzPbL68NpOmxWx4TdAMExU9zzV05zOO7Hj60gLzbK2SPQQJr9Si37Mq
         71YjvagvRMm7N83yYvXxUhvRvFNgFyBFFKUMs71kqTiBN7/Sy3Sz+KBX5U3RdGoAAi
         eUGyt1TW7bnzBWsUZ5olD9EQtway9uiq2hGJdUs9x5lizHhDubLuHT0rbFbyBgkVyP
         J7kmXCuVcPS+RtRqyagQac0RuaWvXXCjEQY9nsHXu8zW887wH/wHkhuzkq+UogcuGc
         vcGOJwiOC+zng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9CA8E0008B;
        Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7] vfs super updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027-vfs-super-aa4b9ecfd803@brauner>
References: <20231027-vfs-super-aa4b9ecfd803@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027-vfs-super-aa4b9ecfd803@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.super
X-PR-Tracked-Commit-Id: 5aa9130acb98bacacc8bd9f1489a9269430d0eb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4e175f2c460fd54011117d835aa017d2d4a8c08
Message-Id: <169869634088.3440.14750284416642696918.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sat, 28 Oct 2023 16:02:33 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.super

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4e175f2c460fd54011117d835aa017d2d4a8c08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
