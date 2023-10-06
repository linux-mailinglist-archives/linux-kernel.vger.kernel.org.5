Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6FC7BB09B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjJFDuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjJFDuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:50:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783F2F0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:50:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46477C433CA;
        Fri,  6 Oct 2023 03:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696564207;
        bh=f/8a4cC4NCWswVWtS7qHd7MQdEwfhxD030udLKp0ROc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R7/UWQhz0mdOdG1sbCaBNhFS+FD+XKqB7pdn41djlTo1XDGN337YqlY53gORzR7pt
         emMhKlAcjOOJdZo4iPhgfjJU/OBwr9Oyz027UJLLcOeHInohk37aPMEkq6GrjLVd0l
         HmSThHjNQhDtz7IbVvvpWuYD+wit5EGXeDxSCoEEmgy52JebSxvctNydcdBRTaUfaA
         /IQDe5qJWu/dbvxBIV6Rd0TS6qPq0sJPC9wkYPsEFqKAPIpGrnLKDaVMy+qld1QV73
         /Jrxc2tvg+UbrxSrzx+selnUkRzlipOIBmK+c8ujtr7M3YbO3eGgFsmYfz8T9uxwLA
         4dKc1A7odKu1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21D2FE11F54;
        Fri,  6 Oct 2023 03:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZR8Fyu+gi7yw6HMh@debian>
References: <ZR8Fyu+gi7yw6HMh@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZR8Fyu+gi7yw6HMh@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.6-rc5-fixes
X-PR-Tracked-Commit-Id: 3048102d9d68008e948decbd730f0748dd7bdc31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b78b18fb8ee19f7a05f20c3abc865b3bfe182884
Message-Id: <169656420711.12601.12535394337239272246.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Oct 2023 03:50:07 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>,
        linux-erofs@lists.ozlabs.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Oct 2023 02:51:54 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.6-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b78b18fb8ee19f7a05f20c3abc865b3bfe182884

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
