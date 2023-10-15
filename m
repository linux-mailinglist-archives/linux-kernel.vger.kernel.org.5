Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0197C9A08
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjJOQYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjJOQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:24:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBD5DD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:24:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D766AC433C8;
        Sun, 15 Oct 2023 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697387064;
        bh=LCOhbFfTofNyRSXP0wNFsDpCkEpiZLP7B8b09PS7jBs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=st+W1K892G77/a/Ik/Ujm88dWW+NRg8ZdQ9b09OqPfuTidCSyCUQUoL5R/nwu8Jkb
         MX2wApPHOMFAUW2DiGwY5EWfJkYfjJld3ogUyvcw+2V4CbGzV6I5nrMDYwdLQErCy/
         QJX8ptnrxyUyacIs4HKIb4Xj1f4ezf7YHlSLWKfgJt4DgG5zFt69ELqnMAmzeiSH6m
         EZNHlQgYVtpbv0lVa6MG8G+F9Eb7lLT4b5W58JR2XNdaBJgSgHjjJ8QRMCHnO9tuf1
         +chY2CZmY8XzyCwZMGHwZt35Ug+wN3iFgHlJGpHMUWpdUDjff6hQ+3LnlrxY8ug5bO
         WVHm8lmxQ3qnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0B4EC395EC;
        Sun, 15 Oct 2023 16:24:24 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSwEDVXfNxshSzrQ@kroah.com>
References: <ZSwEDVXfNxshSzrQ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSwEDVXfNxshSzrQ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-rc6
X-PR-Tracked-Commit-Id: ffd1f150fffe8a708f6ccd15152791d0e8f812b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a477e3a76be740a1be844635d572c83f4c10002c
Message-Id: <169738706478.6658.2724004565539441053.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Oct 2023 16:24:24 +0000
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

The pull request you sent on Sun, 15 Oct 2023 17:23:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a477e3a76be740a1be844635d572c83f4c10002c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
