Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837DF7990AE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344327AbjIHUAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbjIHUAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:00:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7BCC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:00:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB817C433C7;
        Fri,  8 Sep 2023 20:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694203247;
        bh=GCWwug5U+WVBuVcQhrZQ27qrZmwWewRk27N9pbY8XEg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lkRoSoVjgnd1zA8Xs8Mya/ov/GMpsmchqgqMaNA+HwqLfAiCUoruLx51Hc7I3vFeg
         wosPpItBM5rNCQLON7ggLDhfToeD58V7lkxFNYPj2czoFtFSEccJQXQD3atNo6EWWh
         eB1gr8XiE6g02Q4ANBukkG/Wjz1KmdzxA/bvpFm51RJBkWyHSE7Nttc3qVYrX2zjUX
         LyM+Y8XFARiDCSnoN63rhFfKWPXXvYiluoh6eLEKvgtdM7W5lFR+wTcB8JUPM91fAU
         oS3XQhhabGUzPSg9et/Jt6+ZF+y8QBrHsN5DBW4P64RgGXDdg6yk3Ug6irI7jyMD6r
         Wmfy/zgO8tKew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D895AE505CF;
        Fri,  8 Sep 2023 20:00:46 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230908153007.GA7281@willie-the-truck>
References: <20230908153007.GA7281@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20230908153007.GA7281@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 8bd795fedb8450ecbef18eeadbd23ed8fc7630f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca9c7abf9502e108fae0e34181e01b1a20bc439f
Message-Id: <169420324687.9132.1107834017079011174.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Sep 2023 20:00:46 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Sep 2023 16:30:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca9c7abf9502e108fae0e34181e01b1a20bc439f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
