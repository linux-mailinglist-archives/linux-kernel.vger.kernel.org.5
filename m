Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE457799C60
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbjIJDRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345970AbjIJDRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:17:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7741BF;
        Sat,  9 Sep 2023 20:17:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 494D5C433C7;
        Sun, 10 Sep 2023 03:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694315845;
        bh=DIIJA720swUPUPOrVOxflYe7y+82IXSdJ54elPWyHwo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pOap8KT7iqIa2r9ZnwhcAL8x56TAvjJBkn2LsSkxXbl4RoaeWNIQPZ20Nxr2Gfn0L
         LNqd8MVkKk0zy28M/SPQQjx+1bJ04JTk2RdhlgScBJNgLaXcwsR7cZ29VlKBIIclWp
         4sZuUkf1UtpDywtxL3U4rvnRK7VGSDyXYAN8PU/2c0c3bI9Y4PYHf0ZR655enstFNx
         4vPk+13dujeAyWN/WvBx0rvFbv2IP/GLWcRX4u5XPcUbEJ7gYmEmlf5TZWDVLdQE+V
         bEK0r6cd1fBeX1G0WASCCPwGeXmkhB4O0yXLBNku2GFqQZxQscx+hV6ljTje6qKS72
         JxMmo0Bef0rmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34E5FE53807;
        Sun, 10 Sep 2023 03:17:25 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msQ5+okQ3Sk9HzwW6r7YoWDEBDtSfDio0XOhTpVDjibFw@mail.gmail.com>
References: <CAH2r5msQ5+okQ3Sk9HzwW6r7YoWDEBDtSfDio0XOhTpVDjibFw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msQ5+okQ3Sk9HzwW6r7YoWDEBDtSfDio0XOhTpVDjibFw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc-smb3-client-fixes-part2
X-PR-Tracked-Commit-Id: 5d153cd128251aaedc8e9657f0a949ec94952055
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd3a5940e66d059d375bdb9e2d7d06c56f630d7e
Message-Id: <169431584521.25659.11511207343057338524.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Sep 2023 03:17:25 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Sep 2023 20:36:18 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc-smb3-client-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd3a5940e66d059d375bdb9e2d7d06c56f630d7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
