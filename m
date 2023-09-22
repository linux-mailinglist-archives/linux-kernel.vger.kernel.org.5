Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB67AB641
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjIVQn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjIVQnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:43:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702B8196
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:43:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D063C433C7;
        Fri, 22 Sep 2023 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695400989;
        bh=gP4jHA6fma1xECP4iWL9xD5eKJ/7U+K9IACgxCV1sw4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n1ntaBpeJaCU5ukCgF9oqFCxwrfX+OqdpjuQ0i17miYqa+Tp1WPVlK/pbN9Hk1Gf4
         1wYNleY0Ir7VLADXS4VOaOWB6ASfdM9SLpVxUR6hWV6T2T5uRLAXkAJcQ7wZmO4qzV
         JypTEZ8mp0EAAqytzEWUTuVHmRlmAGvg2us7OUSQY8aRGZ5tgs0Bd2lgTmR1xezC4U
         7H3888hbrlUuy3DQkjTQXGnds16C5muqgbW+tqhWdan2PWMkVEWvfJGEva97bV7eLE
         3XzzcqwyAKXR+NXwQRzgNyfObz34n1BCBSC8AUcKzqKSUZR/0sU6HhRZVkssmzl2Tw
         jTROpjvVPw/Kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B676C561EE;
        Fri, 22 Sep 2023 16:43:09 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txiBx_jsniqp-F5jGaLafEd1i=ike6kZ7G=ti7e2y-saw@mail.gmail.com>
References: <CAPM=9txiBx_jsniqp-F5jGaLafEd1i=ike6kZ7G=ti7e2y-saw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txiBx_jsniqp-F5jGaLafEd1i=ike6kZ7G=ti7e2y-saw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-09-22
X-PR-Tracked-Commit-Id: 54928f2f8458160e6c7217de78b48064b301e255
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b41b28366d3b176c8297961de4f095f2e392402d
Message-Id: <169540098903.17578.2312216446450585203.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Sep 2023 16:43:09 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Sep 2023 16:14:46 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-09-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b41b28366d3b176c8297961de4f095f2e392402d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
