Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7297E10C6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjKDTjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjKDTjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:39:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAF31BC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 12:39:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83D88C433CB;
        Sat,  4 Nov 2023 19:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699126756;
        bh=6npM8jiNedjVjYxnDVV6oGnIIsmn8/OnctvkCFveI8o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Up8wWSIxy8iBogY1IkuQcDkoZ+9JNrMy/+JCjkwAdxklswhfKjiGtWHOgAgcPi6QX
         SFgGfCJy6/5vdZUjAfFpeJgkcz6Qz+1sLPCEZnpBbzrUunoYYui2ABCZ8c8apG79Wp
         703wWK5nacDLfbtaHvjDPEuyio1FCCmVhTqQ1AOAJY41JiHsLqGJsln4pLFAFhpZZi
         0KNEr/xleV4Xr7NVrUg1w4UIpdDHgwJ3tLMgQYDUpcYyutFwaiKUP377ZpTSBfZRxa
         axBa1VboJNWc41BEeMB6qrx84hkDTrcgarL1VNsS7vAFuk+m75SMHORkRUrrerjASs
         x4UuCN1TyBxhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BE68EAB08A;
        Sat,  4 Nov 2023 19:39:16 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs update for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUaVqCoMnLi7bV6P@google.com>
References: <ZUaVqCoMnLi7bV6P@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUaVqCoMnLi7bV6P@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.7-rc1
X-PR-Tracked-Commit-Id: 1e7bef5f90ed69d903768d78369f251b77e5d2f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aea6bf908d730b01bd264a8821159db9463c111c
Message-Id: <169912675643.21555.2499024044009023704.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 19:39:16 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Nov 2023 12:04:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aea6bf908d730b01bd264a8821159db9463c111c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
