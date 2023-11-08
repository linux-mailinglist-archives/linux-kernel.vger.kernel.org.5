Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA077E4E94
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbjKHB2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjKHB2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:28:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC6195
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:28:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42F6CC433C7;
        Wed,  8 Nov 2023 01:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699406908;
        bh=uqSDgApUYNMEl1+GhHw3mliJvThrroTYJx+WAibua6A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jQaBUEJzR50gabyuV5HBOdvXOIpsRM9UaJeXS0030i7GVTL/HsiCXzpUCHrjz0bVq
         hOuzJs58mKd07h8FpNto+rnMGtqGE/bebUeHKObYyAoY7hOJTYfy+c6rTlDDZ1AG5k
         ZmgdNVZzCfavMifGBXtOdRXNZYAslLiiu0rCeqBsgj4ct5X5wgxcEAilN4eCRqeObM
         pYFo/OGT7Y8p9X3lWLZ2vsB4UIz3c+qdlGjZU5/8+hxbzbXpPfCrhFKEBvAF9PbNcY
         axkEWvlvnUhtfdIX5pyP7wsNM2QqpWfjaGEfDLCJEZWUWZjsgoPQ4c1PJWnVp00NYy
         kFZqdZIOQXClw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30DF8C395FC;
        Wed,  8 Nov 2023 01:28:28 +0000 (UTC)
Subject: Re: [git pull] drm next + fixes for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twtAbAqnZKRTk9tKLXpJeU6azx+TM4Ep3yJHQJtCFvK7Q@mail.gmail.com>
References: <CAPM=9twtAbAqnZKRTk9tKLXpJeU6azx+TM4Ep3yJHQJtCFvK7Q@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twtAbAqnZKRTk9tKLXpJeU6azx+TM4Ep3yJHQJtCFvK7Q@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-11-07
X-PR-Tracked-Commit-Id: 9ccde17d46554dbb2757c427f2cdf67688701f96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25b6377007ebe1c3ede773fd6979f613386db000
Message-Id: <169940690819.31371.12586938536152172995.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 01:28:28 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Nov 2023 12:03:00 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-11-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25b6377007ebe1c3ede773fd6979f613386db000

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
