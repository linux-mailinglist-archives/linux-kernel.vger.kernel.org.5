Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B5B8017C2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjLAXaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAX36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:29:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DEDD54
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:30:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2665C433C7;
        Fri,  1 Dec 2023 23:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701473403;
        bh=FEVQqzRQjVDb3BZwYSlTNyijAY1czZPIVLQNFGOOrRc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZA8H9M/ZLbT2u3y5NGR0LIZD++antpE4QyGESY+Lc1sB4dFSzMa+wYb6vrTSHeLmR
         XVbg1NmYUtQqVi5SF+UWBx9X80tnk77n4x2tFITtj8i0vFAsqqChuOydmMVxfe3Uls
         G561Pgy1cH8Ywp+Z6/U4tMabPi3eQvz/jbLljLjDdL77/v7G5xVha8qhDLxDUirgjf
         grBba6qnJ2W9197AobjH7rZ0o139dfbJIsUa+kMDeSV1VXjFq+6yu+QjU/qOtoXb49
         BOSRYldHuVp80hNm+QfU9PZHpepKJpw24tKqawcKr4oCLqFN0meBnqssZngwIgXySK
         RhwtIgvM2TxBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD6D6E1F668;
        Fri,  1 Dec 2023 23:30:03 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txF5xvm3uRK0jiW-Zzg+wA7q0+ee-nx2NexJC1LM_6g4Q@mail.gmail.com>
References: <CAPM=9txF5xvm3uRK0jiW-Zzg+wA7q0+ee-nx2NexJC1LM_6g4Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txF5xvm3uRK0jiW-Zzg+wA7q0+ee-nx2NexJC1LM_6g4Q@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-12-01
X-PR-Tracked-Commit-Id: 908f60642441cb4f9f0e1eb576e63b0011d318b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1e51588aa50287c3d33e14969d47ccdd403ad80
Message-Id: <170147340375.22043.13530253237002470318.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Dec 2023 23:30:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Dec 2023 16:41:39 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-12-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1e51588aa50287c3d33e14969d47ccdd403ad80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
