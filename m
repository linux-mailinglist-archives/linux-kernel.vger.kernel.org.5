Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C617DFE1A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjKCCUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjKCCUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:20:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFA81A8;
        Thu,  2 Nov 2023 19:20:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52B73C433CC;
        Fri,  3 Nov 2023 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698978027;
        bh=OWRCj5vZvSriXBr1thMaBXTKtBFPI8Pl44lEtJbJ6xc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZpnsFeFMyQuX+oMS/eAkrRyYawWR+YyWWLWqM0HFQK1XCDCwIu5UmGDc9lVShU0l2
         UdC8z/6L6CgK+kUgFHUJqfpqVJ2Ump+3/WTXlZbKcBjkLsepHet97jEJ0Ity8yNcRW
         ApYW3ATdU+vY9z4V8y3txuGDca3uKZs19c6IBHG4IPb7mVBtsScqJzZtpepTZVjomI
         CEv/cua5+L5AxM6QeoBmvUpFb37rogc1EKJRFR4X3/Yk0jAB1TP7RZT6kBAQ8TYcGu
         HsmcUZJSuDMkfLaSC/4esEGicrWivnKQnGpVECNwwhFZngndpSu0qb4LqTRDyJHjy2
         kHtVgPXjbsEzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 363FCC43168;
        Fri,  3 Nov 2023 02:20:27 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <49bc6b4b-e2c5-4f83-b160-6062205cb2c3@linux-m68k.org>
References: <49bc6b4b-e2c5-4f83-b160-6062205cb2c3@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <49bc6b4b-e2c5-4f83-b160-6062205cb2c3@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.7
X-PR-Tracked-Commit-Id: 2508b608f4028c6fe0d63698f64a9bfc3eb6b780
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c04bddc27d60df8ca5cb5bea40374c3ca1d75fc
Message-Id: <169897802721.29625.11836113430145221183.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 02:20:27 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Nov 2023 14:21:13 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c04bddc27d60df8ca5cb5bea40374c3ca1d75fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
