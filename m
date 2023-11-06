Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD8F7E3143
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjKFXV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjKFXUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:20:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D515242;
        Mon,  6 Nov 2023 15:18:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09981C43391;
        Mon,  6 Nov 2023 23:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312688;
        bh=Wcr6IJuISwnN8HMwRTK1XnLw6z5EJTbKmmRAT9WUjO0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P+wnVcsl3ffQiMVdqttq6+4/LzvEA8dufJrkAAJcS9GUiZXOnInfAafntACoNxrlq
         vuo57U5w6M+sg2iQAXBgNjpoCsbzRICut6NGfj5Iw64/lAvGtm6Bvw0rXva/pxwrQk
         z8OCpZ9ypsF8BARnxjK+9sqKLs7LgIqvdud+kasxFNQDOTIjGrC8voNF+wX2wxJiLL
         L2PdV3pI1WOPMv1xwFivXGeV7qReL+up3Wwc89VXRZffa3W5rNRC9mYa+8eDX7sscR
         Xa6XdpNloAbENyGiYMWbxgnSItTlSiek9u4/OWfpSkU7wL9FHDFe7eNlWAwyQ0wdlu
         X6TFngko7qJBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC3E6C00446;
        Mon,  6 Nov 2023 23:18:07 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7-rc1] media updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231106112531.717e897b@coco.lan>
References: <20231106112531.717e897b@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231106112531.717e897b@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.7-1
X-PR-Tracked-Commit-Id: 3e238417254bfdcc23fe207780b59cbb08656762
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
Message-Id: <169931268795.23627.8903141672860536166.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Nov 2023 23:18:07 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Nov 2023 11:25:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be3ca57cfb777ad820c6659d52e60bbdd36bf5ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
