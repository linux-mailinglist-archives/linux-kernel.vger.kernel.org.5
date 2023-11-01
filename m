Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EB47DE679
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345754AbjKAThb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 15:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347912AbjKATha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 15:37:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E4123
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 12:37:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A52CC433CD;
        Wed,  1 Nov 2023 19:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698867438;
        bh=Nj68XnXkW61dweRYG7A5fVa3Ibn7gLCpfGnDxMsUDn4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nMxwv7VMw6o4b9/qJspcYo7Kc4Eb3MnWt9fooO5SqyWdWgToQn+yak2iBBkSXwQ0E
         lXfdXQjNc4UW91fuWpGx3UCxazqF+OW4XYTrTOv0NY7nMXFCg6IJz9o6OOwjtgxwTL
         W7z0ImVMhqfkBzdw1D61DKQFDGfsnY7eScoO8RJ4hguhpmBmD2AHBH6YDTDIsZoS04
         jJvwtjl4r1QAzjgnLueHCPgBFk+8vfX9RXZrEOIim4maujEfWrE1UXw8UQCo9+8t3D
         7eyPq2SdZu5/pxjYOPUHjLMH2qKJHLa/jo0TSIZtRgGRJzWjxhMUpomFBqsWI+el8H
         LTUv6FWDA06wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17CC5C43168;
        Wed,  1 Nov 2023 19:37:18 +0000 (UTC)
Subject: Re: [git pull] drm for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txd+1FtqU-R_8Zr_UePUzu7QUWsDBV1syKBo16v_gx2XQ@mail.gmail.com>
References: <CAPM=9txd+1FtqU-R_8Zr_UePUzu7QUWsDBV1syKBo16v_gx2XQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txd+1FtqU-R_8Zr_UePUzu7QUWsDBV1syKBo16v_gx2XQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-10-31-1
X-PR-Tracked-Commit-Id: 631808095a82e6b6f8410a95f8b12b8d0d38b161
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d461b291e65938f15f56fe58da2303b07578a76
Message-Id: <169886743808.2396.17544791408117731525.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 19:37:18 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Oct 2023 15:07:23 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-10-31-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d461b291e65938f15f56fe58da2303b07578a76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
