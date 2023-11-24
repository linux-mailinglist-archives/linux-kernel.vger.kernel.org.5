Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451907F7DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjKXS0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjKXS0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:26:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E1B1FDD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:26:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CE95C433C9;
        Fri, 24 Nov 2023 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700850381;
        bh=+a17ORrYB958IpB4yDfi5dd5LZPIqWUCcXi520YmShw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aGyY7j3DqFh0SGT5m+nLArDi9DPFMAdvwoWiYzS0DRIIwwwNT/r+6vSWPUk4pehm5
         LuH/S1hWfxk4hv0WPB37dXJwaCJqHzutY5vQoBLlgvwKPxu9tHXhtdSRhpTDjqrY4m
         pqQjaCVuS9DXtx4y/B9dRLfIcqj7twCc7hFNT72hC8tYcYmmYfaae2C7D10BoqBvhD
         Gbt2mz1Y61gellOJDazwH+NS7mYHC5Tj1JenECcNIwAcmgjTe2t7zZ77gNk90Eqtgu
         JdbP+QJaLvp3BC6el8wo+5k4Q1DZu5A3gk3RhqhSE9Ny+sbA1HW0eO899QoP1CLAd5
         XffETUWguXurw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19576EAA95E;
        Fri, 24 Nov 2023 18:26:21 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.7-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txezDxgPxV4UJ-RPVxuAqO4k2kdDj-oUAyFdP+CztJPzg@mail.gmail.com>
References: <CAPM=9txezDxgPxV4UJ-RPVxuAqO4k2kdDj-oUAyFdP+CztJPzg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txezDxgPxV4UJ-RPVxuAqO4k2kdDj-oUAyFdP+CztJPzg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-11-24
X-PR-Tracked-Commit-Id: b3ca8a08d8ed0dc8a9e236d9294efd58554a7b05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afa0f6ee000abd220a8160f0375b5b8d3e4284f2
Message-Id: <170085038109.12986.1037268827572530527.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Nov 2023 18:26:21 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Nov 2023 11:38:52 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-11-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afa0f6ee000abd220a8160f0375b5b8d3e4284f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
