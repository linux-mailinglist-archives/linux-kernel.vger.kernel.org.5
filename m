Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AED7DFA15
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346648AbjKBSiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377212AbjKBSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:38:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678B3186;
        Thu,  2 Nov 2023 11:38:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 078CCC433CD;
        Thu,  2 Nov 2023 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698950286;
        bh=VUkqZI3KtILPkD0G/9bdkjdzwseznHqqXMHce/j0YrM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BQLOIdnR2+RIeEtzl4XCm/M1t2LZNt6yZ981WHYkvgVcFgYcga8zIqBr/2ErXZKiZ
         iGRFIVUdRALC2iHnksGcAJsrv2/A5m9memSm7mu5vtyRXoJNLmyub4ZP/C5BpeXZU6
         R9L8OX1qiSFQcAckyir/fp87XUk4KSrbiWbr9/uvZR3nJ3HEp5z2gHZ3Cjr/X3BYZO
         J1jHPXpFhRvr9WlqzeBGa3MPknFt9Ou2ndja2b8Nj3/4FYSLudCxkV0U/A8TDR+YuI
         a3NVtoqLJYM37f4EozWcrGrdfk8hfjLjPQMu02DXTCokkh3Eqlb0Aw2QPaMPwUD8vb
         1iNufpzL+BJ2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8008C43168;
        Thu,  2 Nov 2023 18:38:05 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muPW=PY1mDGqR-Mpfv95RbR7w6XpumoXpu7cdRv1HS0-A@mail.gmail.com>
References: <CAH2r5muPW=PY1mDGqR-Mpfv95RbR7w6XpumoXpu7cdRv1HS0-A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muPW=PY1mDGqR-Mpfv95RbR7w6XpumoXpu7cdRv1HS0-A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.7-rc-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: 67797da8a4b82446d42c52b6ee1419a3100d78ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4652b8e4f3ffa48c706ec334f048c217a7d9750d
Message-Id: <169895028594.19486.14677384024053235453.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 18:38:05 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Nov 2023 21:46:03 -0500:

> git://git.samba.org/ksmbd.git tags/6.7-rc-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4652b8e4f3ffa48c706ec334f048c217a7d9750d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
