Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2EA7D1491
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377924AbjJTRGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377917AbjJTRGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:06:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F452D72
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:06:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B88C5C433C8;
        Fri, 20 Oct 2023 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697821563;
        bh=ROpFDlqb+H86fYtgnkBm7h/Hut75+rRwKJfzKjrgUew=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BHZVxtBS9L9Xrhg56PBoeNHrh1P5RbSzdOnamprmvQMNQSc3ONJ9jST7/OCQSAp9m
         KqY7I+E50KYdKup1iXfVlosQj2BuSoXXpRegC0hk14snV3QhDkfLH+1+UNnD3yfQK8
         zN4vRGMwklYK90+k9soJSp2DCnrbJp1Iv11qgj5Wxk8sg2G9XQOXzHWpWT0AT0ivbC
         hHtorTLgqiI/k+KH5hxe334kIsX6PLzbwfvt+ivefINKFNHkhMi+FX60M69obcfdKt
         8FdOIuRyJrtp93mzP40ahXc49fbyVgS9U/5wievKUB2fQyBq6h0WqgEGBRsrBQBNAq
         COPonplcK6ocg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5B05C595CB;
        Fri, 20 Oct 2023 17:06:03 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twE+5tjNxbr1FkiXBqeEzv9k4LZMo4ETmchaNioNT6quQ@mail.gmail.com>
References: <CAPM=9twE+5tjNxbr1FkiXBqeEzv9k4LZMo4ETmchaNioNT6quQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twE+5tjNxbr1FkiXBqeEzv9k4LZMo4ETmchaNioNT6quQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-10-20
X-PR-Tracked-Commit-Id: 8b35ce3f7a9699e7580527fe4510d77f2a35f02d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8045b4a33a511ff1feaeb806e819572b90b6625
Message-Id: <169782156367.26317.10341186241193996664.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Oct 2023 17:06:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Oct 2023 15:01:24 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-10-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8045b4a33a511ff1feaeb806e819572b90b6625

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
