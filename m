Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A0D7B3A68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjI2TJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjI2TJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:09:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D8199
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:09:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D513C433C7;
        Fri, 29 Sep 2023 19:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696014554;
        bh=F7BqptkTFZMjxW4sdEcZv+9Y5EEq6q0j8bKg3zmqiEY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HrAFnuuB4jdMfuaTB4/bCeVBAGdUK79UXR4QXm5yzIdOUQTuGqoGUL+gtA7hKD3T4
         aLQ8Op86PYt6cYcwhPgI8R9sf0wSTGhoZqe4gS1pPbcjXiLC6z9Jcg+7tRJa1DcQaF
         XZTqKbDId5s+s3uscQ/LhHEQpYR6fKzXMOoWlGw36618b5bVySSCj9DY3Lt1beXGe9
         8Ry8HKmAjJ+2Pyau+Hl+32nvoaKt+BIKunDRw3cqX2l3bZWaJR6aU0+2EGaoYYs9v2
         5j+hm35OMp4rGrx1EQlu535BcATXTqDq/AUWsFMB+m1m/aP5qVZZcXrFbOP4wncyQR
         LoTNeQTF9WyhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9B1FC395C8;
        Fri, 29 Sep 2023 19:09:13 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twU2jO7zfje1XSmW55VnyKxWenszkLRFi-yLX7hQNG2+A@mail.gmail.com>
References: <CAPM=9twU2jO7zfje1XSmW55VnyKxWenszkLRFi-yLX7hQNG2+A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twU2jO7zfje1XSmW55VnyKxWenszkLRFi-yLX7hQNG2+A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-09-29
X-PR-Tracked-Commit-Id: 06365a04fd32af25f90d8ccb4fecdda1f0e1ab78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6edc84bc3f8aceae74eb63684d53c17553382ec0
Message-Id: <169601455394.20163.8006065333875033341.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Sep 2023 19:09:13 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Sep 2023 11:46:12 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6edc84bc3f8aceae74eb63684d53c17553382ec0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
