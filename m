Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815D17BBB8A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjJFPPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjJFPPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:15:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDB4F4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:15:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E6B4C433C8;
        Fri,  6 Oct 2023 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696605328;
        bh=IzVQJZrCJgH70+xhHD7kCJcQBfkWMJtOB72gyYxLlh8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HMsHH9uSh5t2/QpphmCCwBVeoT1sy6GzToxBR4FHcSnrdIodtbD/aUWXFO8R5TQT/
         SnXgiV8CRIREVIPqU+CrI9c+MkMyvt7zBcMgHtFCbkXx98rwalW7nzfH002rMcFhW9
         yXUKZCNNcMFJQKNvOSY8GI8liW//bx0zbdFL5N/4aUjKfhgJJSryeGhrB+S9R5LhqM
         ARM9KBpmqsbNFhzOV5RIbrHsQYgjjH1XPduDxR44G4ZZAOzaeahcoMQ3uBBYX+RYgl
         Oz9oeneqx9Qdbn1EXiG4QUgbruhcV9WL39x+Gh10xnxwaDONVLe34x/8QHEcOevGZj
         DdMyuCBqx+EBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C01DC41671;
        Fri,  6 Oct 2023 15:15:28 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txQG3XyUMBvFf5pj8ng0sKekGMw5A7nhU_eMN5ubkVGcA@mail.gmail.com>
References: <CAPM=9txQG3XyUMBvFf5pj8ng0sKekGMw5A7nhU_eMN5ubkVGcA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txQG3XyUMBvFf5pj8ng0sKekGMw5A7nhU_eMN5ubkVGcA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-10-06
X-PR-Tracked-Commit-Id: 67f35a41d3748b7bab8787d20b50cf33fafa2ae0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4940c1543b4381a4895072489b4de7b6145694f5
Message-Id: <169660532837.6239.2392760731761854818.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Oct 2023 15:15:28 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Oct 2023 14:58:38 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-10-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4940c1543b4381a4895072489b4de7b6145694f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
