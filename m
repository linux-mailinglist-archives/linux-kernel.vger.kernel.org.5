Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC227E1221
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 04:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjKEDCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 23:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjKEDCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 23:02:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637F21BF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 20:02:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FD95C433C8;
        Sun,  5 Nov 2023 03:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699153328;
        bh=TSvU0HlnHN4BZ8JsoKM745jTn0wr3/QtfdZevo17IuQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nIARKTvlLDp/ejiNM2wGmTp3kpCZeivIcn0nLNdcsJjRK8TC5bW5QrJ9mzSuMAmHQ
         ZOkF4bLb44SEQ0DxrgC2oPIhTjSJvsqAB5hkUyPkOJKREHvbw4A+sBfkHJuLRWIv5k
         is+g7Jwm5aW2vtKGIMxaQOvHc4Raa5kcWxPdHsvcw8zk9lSbAg92gPowpOiGUMoUuH
         aE06KXEDBfIa2LCnevpdjXhe4cDO0/JYZEWZpfnQ97aVsgzV5dl46sWIMsuSferZuJ
         BgECv8UZLNnQxzwvl571qSkpca2JBD9gAITAKjYqrIwOBRib+9mckf3PAYr8G3QGox
         t4IiHvqbJJEyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3E6DEAB08A;
        Sun,  5 Nov 2023 03:02:07 +0000 (UTC)
Subject: Re: [git pull] drm nouveau support for GSP firmware - optional
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txa=48madkU8QgcVzmU9EBvThNM_dU-1meEhtrsgF8iPA@mail.gmail.com>
References: <CAPM=9txa=48madkU8QgcVzmU9EBvThNM_dU-1meEhtrsgF8iPA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txa=48madkU8QgcVzmU9EBvThNM_dU-1meEhtrsgF8iPA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/topic/nvidia-gsp-2023-11-03
X-PR-Tracked-Commit-Id: 8d55b0a940bb10592ffaad68d14314823ddf4cdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e70703890b2586bc3567365d391c260d23fb7a94
Message-Id: <169915332799.2133.5360232430115040415.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Nov 2023 03:02:07 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 13:16:45 +1000:

> git://anongit.freedesktop.org/drm/drm tags/topic/nvidia-gsp-2023-11-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e70703890b2586bc3567365d391c260d23fb7a94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
