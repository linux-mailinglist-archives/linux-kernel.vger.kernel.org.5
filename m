Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C587E8DE5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 02:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjKLBa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 20:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLBaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 20:30:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237672D59
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 17:30:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD6C4C433C7;
        Sun, 12 Nov 2023 01:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699752622;
        bh=7yXv8lSfiz8Pmtplrl947hP8L2j7U0Ljh1zCJ/+tCo8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZnCzHa28sJnGN2x9v2UxUWD//Jq8tkFt7mTWRCGFHEtovcMIaC25IQiPeg33dvCgB
         sJ0OgGxKidUDP3+CFYQItz34CbhjOfs/VGg73xf1pzPs5vtqcYeu6GJij37vnuGhEG
         erG+M/172VGsAV9zBrOx+rtmGKpCdEKW/kmzFbm57TRIJZZE7or8e9C3m8nUHmF2cT
         RhUJmbOGjj9lRoxMnwZ0kuEmnBvpwsH7UM6k4T9pvdJX9kFLqZarYLHL0UcNlD/jjH
         3UQARomKBSksNHuE8CdY+rGeW0Gbq34WoWdGJON+jbWrM7N2LnI9dVA2tDSSWyvYzU
         p/ee8HVfqpOtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E6EEC3274D;
        Sun, 12 Nov 2023 01:30:22 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muWrqOdEDUhmYHgX2Pr0yWSMrFLPms+4pqwrZaMr4i7Og@mail.gmail.com>
References: <CAH2r5muWrqOdEDUhmYHgX2Pr0yWSMrFLPms+4pqwrZaMr4i7Og@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muWrqOdEDUhmYHgX2Pr0yWSMrFLPms+4pqwrZaMr4i7Og@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc-smb3-client-fixes-part2
X-PR-Tracked-Commit-Id: fd2bd7c0539e28f267a84da8d68f9378511b50a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b907d0507354b74a4f2c286380cd6059af79248
Message-Id: <169975262251.20343.3324446234541471652.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Nov 2023 01:30:22 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Nov 2023 16:21:28 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc-smb3-client-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b907d0507354b74a4f2c286380cd6059af79248

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
