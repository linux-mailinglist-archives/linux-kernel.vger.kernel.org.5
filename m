Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DC07E8252
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbjKJTPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbjKJTPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:15:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD465EB01
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:48:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B37A9C433C7;
        Fri, 10 Nov 2023 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699642079;
        bh=abRVdJbrQHoxpPW40qat4I6wx9/AKw0jaC4RFIiOfdI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IjOIb1Z0dxMHSTVqA9E4W+HQBd03hczU8YUVgOjBlSLY9hm55aw7U2AG0NuWoxt+7
         93bu3ucm/xCIyCUm9jwKx4IcnFijwmvc50RmDPzAl5yGxZbnlFJO9tKcwF+dvzlLFu
         38iVbGPOQxllcBqArAbyHk+CknzBg4DWTP/co9cxO0Mt1vFuDFXyE03xfn2diEDMUY
         xB0RvJJfLqZcH2DAisE8L1g2oYK18kAIt/OVI45HQYkmp906Hj3Y2zWd/ofqtqQvrz
         5s4mjwW5NfaPN/skExwStBBmtPH7Kdi1HvDGav7XBXaR8FagvVVd1evZOBPUifIObw
         2itnGgV90WfFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A355BEAB08C;
        Fri, 10 Nov 2023 18:47:59 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph updates for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231109174044.269054-1-idryomov@gmail.com>
References: <20231109174044.269054-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231109174044.269054-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.7-rc1
X-PR-Tracked-Commit-Id: 56d2e2cfa21315c12945c22e141c7e7ec8b0a630
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e21165bfbc6c5d259466a7b2eccb66630e807bfb
Message-Id: <169964207966.13214.15645286579277461920.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Nov 2023 18:47:59 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  9 Nov 2023 18:40:42 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e21165bfbc6c5d259466a7b2eccb66630e807bfb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
