Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191FC7A333D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 00:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjIPW35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 18:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjIPW31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 18:29:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF2D1BF;
        Sat, 16 Sep 2023 15:29:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 040ADC433C8;
        Sat, 16 Sep 2023 22:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694903360;
        bh=q/06MsLSqytnIGIhMNkVlqdzrbo6WiKx1MJGVv+Kq90=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QIu1ejUQrSBi239/J667/xAcUGGEaO6+rMy46F7+VdK33NvN++GgUu6evsKhD6Jlz
         8NeUSuolyXZxMKlaWmRzc7b/KEp2UkrOltwgboMGjfY4Z6OJ14Fo5v1mh1m2SJtplw
         NzCxilBbpkKzqFg009yNmDSQMmxw/fI+wDLHJ4m/FGyz76I5jfCbpQ2N+6Yz7PMOn7
         PtwXMT855uQS6Wn69N3DT3TzBTLj+gq3YBPC5xc42yqVShrOy/S0ViOfF4GjId86WN
         g7VMGUKHwrFfQdpqb0rwLWgbj0wfED6iQs3NWNlcjsOfscE7TVqgsoN8IvaOKTKGFm
         NvpYDpAJ9kO5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA57EE26881;
        Sat, 16 Sep 2023 22:29:19 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATCV9WGKeDyR+ymZsq5QBbNVU3bqS_0U230BTpRLFcnBw@mail.gmail.com>
References: <CAK7LNATCV9WGKeDyR+ymZsq5QBbNVU3bqS_0U230BTpRLFcnBw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATCV9WGKeDyR+ymZsq5QBbNVU3bqS_0U230BTpRLFcnBw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.6
X-PR-Tracked-Commit-Id: 552c5013f2bc648611395ea80df6250aa4fe28f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0b0d403eabbe135d8dbb40ad5e41018947d336c
Message-Id: <169490335988.1784.3743668000657008913.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Sep 2023 22:29:19 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Sep 2023 01:04:57 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0b0d403eabbe135d8dbb40ad5e41018947d336c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
