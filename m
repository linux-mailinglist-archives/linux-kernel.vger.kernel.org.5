Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CC0799F67
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 21:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjIJTF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 15:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjIJTFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 15:05:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD79E40
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:05:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 845E7C433C9;
        Sun, 10 Sep 2023 19:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694372740;
        bh=e2VfS+VM1Yjs30GuO4xzHmKbmrdadnTgCc6OqHEAktM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CRaWgQctHMG7FmWkNVwZDlc5b2vS3nnbxBlx+Tpv1VGX+30c9I1fySEdjMGPd+wYK
         dDrCfFi96lAl78GXvkwv88y4zfb10ltprrGLmEA2ihIsSvBJdo07DRFbefEujLAjNu
         4PutVdsD/j3HvornvPWMUw+d2tiE2bFmIBR2qtt1I7gm+uYAzP0g+Usa5AUmhSpcwT
         fhqMn3SMGIE4pMaKkd4HL7j5xUi4UihdNLB33Lmeh+09dpyQOKGksKy2G0U0eRjJ9X
         mHVZIKmVTH7IrOw0x3Rza7YIjJPKiE2yCDOrV09kNQN/o2Zd9a9a1PUeP0oxiBcm/a
         43Qb1zqeyzaOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71AA2C04E27;
        Sun, 10 Sep 2023 19:05:40 +0000 (UTC)
Subject: Re: [git pull] drm CI integration
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz=gx2_zrQ2XD8JNwW1dg6b+Byr5FgYAAq+2f29rydcgg@mail.gmail.com>
References: <CAPM=9tz=gx2_zrQ2XD8JNwW1dg6b+Byr5FgYAAq+2f29rydcgg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tz=gx2_zrQ2XD8JNwW1dg6b+Byr5FgYAAq+2f29rydcgg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/topic/drm-ci-2023-08-31-1
X-PR-Tracked-Commit-Id: ad6bfe1b66a5c146ec236847eca7af4c8806d666
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1548b060d6f32a00a2f7e2c11328205fb66fc4fa
Message-Id: <169437274045.21112.1273555026847076265.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Sep 2023 19:05:40 +0000
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

The pull request you sent on Thu, 31 Aug 2023 11:00:20 +1000:

> git://anongit.freedesktop.org/drm/drm tags/topic/drm-ci-2023-08-31-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1548b060d6f32a00a2f7e2c11328205fb66fc4fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
