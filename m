Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C0E7A2830
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbjIOUe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbjIOUeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:34:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD2A2726
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:34:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A47B7C433C8;
        Fri, 15 Sep 2023 20:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694810064;
        bh=v2cKYQF57ebTGy3AcWzmBogroLUPUTDEab9RJsVy71Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Fzi9CLEKTCGE6eRBP+0gG86+vs15o4HsXv0hixIlUfNaTmUUVEf0OfAnKNqWy/I4f
         rKcQj2f4CO/4WciJ9skR9hcjMJhB53yjFODxP18FPxNm/Cn3d+ynz7v8+pZr35oIa5
         4ZTKctZDy5C+7WEww3qTPgh7FLLA4mgBGiQP7ZTbI1BxrTGUNrsLxHoxwFh9tgEDkb
         G86Cqkt+5CbhlydEpmGHH3di4tzW/o2B3XcM+8z3zJaguEZj1pAkQ2mLCmzfOSsaeV
         WDN7GDs3gBnerlFxXN6A0eWWyd0V/G4MV9tFqPBqJCSPlsAj2+jamZH19glAU2WZlq
         a364cQjwbsUiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93604E26881;
        Fri, 15 Sep 2023 20:34:24 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx4M13E1G_a2CsE0W_48g-n4=HDpsiWoHnE_raBaLQoxA@mail.gmail.com>
References: <CAPM=9tx4M13E1G_a2CsE0W_48g-n4=HDpsiWoHnE_raBaLQoxA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx4M13E1G_a2CsE0W_48g-n4=HDpsiWoHnE_raBaLQoxA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-09-15
X-PR-Tracked-Commit-Id: c3c9acb8b2466ddf7f00fc11e2efb736b5252172
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9608c7b729e29c177525006711966ae0fd399b11
Message-Id: <169481006459.17233.14873885417378522669.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Sep 2023 20:34:24 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Sep 2023 12:57:50 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-09-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9608c7b729e29c177525006711966ae0fd399b11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
