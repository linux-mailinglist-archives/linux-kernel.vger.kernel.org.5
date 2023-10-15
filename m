Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ACD7C97BA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 04:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjJOCxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 22:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjJOCw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 22:52:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD9CE0;
        Sat, 14 Oct 2023 19:52:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F59AC433CB;
        Sun, 15 Oct 2023 02:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697338377;
        bh=K5tMCSjp/r8Y4o/XKdP+y3Z17d5UBStn0id+mRZ6Kxs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HtPmJ191fFvYCByfzTRpQ7uVhj/7Lp9ngL/djNAvSYwjaP4Sgm3qTz1OgO4bL9Yi3
         BlHmAkXqf3ULMrLGGalELWTFf1ClrHU6YYkHkaDv4wYBGdn+m781zDE0L8cAMCAgMO
         lcXRV/QQdkCuJH4H6OYzdTS90Xj1Fk8jB3666N5SiHQ9ydn+4YLZDzM3pNNvNBytBz
         Mhwu6X9pkvnLNToCaiirbkjngqWtI7GsG7XSjPxBVTfINLHxjtjC9Q78f/6BXOkQSL
         MtuVMdphgOvlyJ0ag8mTd3HkEntEDWZusQcO3BzprBLQgNmB/HVNTD1xu+s2nl1nnw
         VT87twIUPUFbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C812C1614E;
        Sun, 15 Oct 2023 02:52:57 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtOMhHDNhjf0Lhd2nGLE4asiDex7q61fDj9qh1J6H+eag@mail.gmail.com>
References: <CAH2r5mtOMhHDNhjf0Lhd2nGLE4asiDex7q61fDj9qh1J6H+eag@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtOMhHDNhjf0Lhd2nGLE4asiDex7q61fDj9qh1J6H+eag@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git 6.6-rc5-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: 1903e6d0578118e9aab1ee23f4a9de55737d1d05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a3dad63edbe9a2ab2be1e7361a2133f519f855b
Message-Id: <169733837710.28493.2254609340003410175.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Oct 2023 02:52:57 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Oct 2023 21:46:47 -0500:

> git://git.samba.org/ksmbd.git 6.6-rc5-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a3dad63edbe9a2ab2be1e7361a2133f519f855b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
