Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67E17EBCB0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 05:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjKOEwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 23:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKOEwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 23:52:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C52D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 20:52:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5705C433C7;
        Wed, 15 Nov 2023 04:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700023957;
        bh=TOROuUKbGVkHbqlD7MOJvSa09ZuXX1ZO3Dc3MLy4wXg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EkanIWO1xNGbYLSyBRxsdEFy1OTXQ1MqIcjIulwd2b06DoLIvJ+G9sPYBCw4JZMPf
         LQ7TgreU7NUvSExvM1df1lPD/qP9h+jAsmswYvDQb8tS2ISE7tMuok8/TTvSpofCQ1
         OF0lyxqfR2jDavvUNkBVy6v0AxX5v+XTMvBZh4p0WN53GCaHLwKxMdaqwNlKvJNUpe
         MV9+H75jpz6I9GS5uc/l+Xqna0Bv/eGZyp/NNXUXaz1qsrWDWfWxFR0Ah5fn87keej
         tkgutuM+tk5ICX+oorgouQRsKua16cSwlRyvCcRPDNipkbvMH7A1ztTFXKkxvlrFzg
         S66tarN/tsx4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0B79E1F670;
        Wed, 15 Nov 2023 04:52:37 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202311140940.5D358293F0@keescook>
References: <202311140940.5D358293F0@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202311140940.5D358293F0@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.7-rc2
X-PR-Tracked-Commit-Id: 782ce431613cf08c3a00dca42ad925c3b1108d09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
Message-Id: <170002395764.9863.2294945632318566793.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Nov 2023 04:52:37 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bill Wendling <morbo@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Konstantin Runov <runebone1@gmail.com>,
        KP Singh <kpsingh@kernel.org>, linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 Nov 2023 09:41:28 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
