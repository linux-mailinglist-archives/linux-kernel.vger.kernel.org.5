Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8447BBC84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjJFQOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjJFQO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:14:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1CAD;
        Fri,  6 Oct 2023 09:14:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3EFDC433CC;
        Fri,  6 Oct 2023 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696608865;
        bh=Kta9wxTkyFzWfR3wZJUaDd9Fi3SDudhkhLe3lx2zP/0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RvIzdazoCFlIFKA0pduBNaS6meWF0uy+pmePNXpFH8i8pS/iZsZcMv3dBFdKdVI+7
         k7xwwgCqyYcqCOTONMbFa5un+MTkjQ/KociGGMefdX94tu6DFBGE2fBAysYOV/S79j
         SW8VNZNmqyp4KxhVts2da2mir+qS+6VkUQW6P99kNlp9ZPIOItpUV+qqEiE6r5py/4
         H/VWZ2iVAE0DGSKY5ILupcZTkfFOHb3LYZl++/ZNBc5UC3P5r0YRE4Ke/knx6MdOKZ
         lT2lGEDmYQqKeRzvgxycH1GNsNH++bvaBI/JS7dt93lUTn+Zax05QVhmpspygk+/LL
         oTGlT5FHmDSAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91744E632D2;
        Fri,  6 Oct 2023 16:14:25 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.6-4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <41cdbbf9-f270-d6ba-8c8e-5f06cc264b93@redhat.com>
References: <41cdbbf9-f270-d6ba-8c8e-5f06cc264b93@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <41cdbbf9-f270-d6ba-8c8e-5f06cc264b93@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-4
X-PR-Tracked-Commit-Id: 5b44abbc39ca15df80d0da4756078c98c831090f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5e0a4b11c4adbe6ab2c0aa6c8b1d59d0fccf56a
Message-Id: <169660886559.6012.4360845420804261906.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Oct 2023 16:14:25 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Oct 2023 17:40:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5e0a4b11c4adbe6ab2c0aa6c8b1d59d0fccf56a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
