Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97A57C92F4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 08:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjJNGcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 02:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjJNGcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 02:32:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA35A83;
        Fri, 13 Oct 2023 23:32:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 713C3C433C8;
        Sat, 14 Oct 2023 06:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697265123;
        bh=Ffi+C81280oTaUbbqC5yjytRaq/0dcSQG4hyd9h3jnY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fWFo+hWncUlJGQ/i4ThyoSRYQ/dX0Xpd24G6XbCzH/P5bNmLe0d5mDzUU0g5l8aAP
         e+kZuc8kfbXzqwIhNDRw2OLT27jn22cqnUb8ZrthH2cRRCBXzSPt4yuuWzlJBmMk+v
         MZK2SgpsCf6S9/kZxPCxCI/+E3YNxqFpiGwsmcxm9I6Oy9r1EjxvLs5pfcZjdeimNK
         uQl1iWwFJIxVRbjPrnnT8zNJIxaIwY3pwWf1Pe8lag+0m+JImF6PcsJACLn7Z3mIqP
         aWOsoigNfAB7nV9RvQqsKfc/E/YRL44kRROHiu+nrMBXK7vqhWSijiZ5OxNnGwSgMN
         0ompTjU8OsxLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D602C73FEA;
        Sat, 14 Oct 2023 06:32:03 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSoV4d4p8RKxEVeG@google.com>
References: <ZSoV4d4p8RKxEVeG@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSoV4d4p8RKxEVeG@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.6-rc5
X-PR-Tracked-Commit-Id: 5c15c60e7be615f05a45cd905093a54b11f461bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 727fb83765049981e342db4c5a8b51aca72201d8
Message-Id: <169726512337.29301.12185191448125444257.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Oct 2023 06:32:03 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Oct 2023 21:15:29 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/727fb83765049981e342db4c5a8b51aca72201d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
