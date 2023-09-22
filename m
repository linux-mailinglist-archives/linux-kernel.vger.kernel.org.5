Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE81B7AB63D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjIVQnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjIVQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:43:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210E122;
        Fri, 22 Sep 2023 09:43:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38AA9C433C9;
        Fri, 22 Sep 2023 16:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695400987;
        bh=fooMorcn9z1K3m7OoyLvK5ppO77hGJdYG0LZsqgMIaI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RSIEAhxVCoeS2j9Rzqw9jp2tHCS6UxVRNjYuRe48tjjybfyLAVUIPPKNU79SBJdPd
         +cBfo0+TIAL3m/tSXDushBCUtSAESYaN2+s7dVa29eyxZudDGidIu+stbbYfcRv+q3
         E+zZpviVvHtOhOL2LtoAcCHyXyhMy5ZFqAV9Er7fWUVbtwgWe1/rq4XWArnT9UZgW9
         Jl71mv9EZ9WhfPYDt3rbwE7n+YzgyeX9rCBPXM6SF4B1zF8MGtHG5nUS1DdUtN+YUe
         BhXMZpFtHe3MPEUD+ralyphFw69YC1TfQ5S8kcgWuTXEO4spJJmcD5Ch8g2b7EKNgi
         cw3m/9YNWI+XA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28BD2C04DD9;
        Fri, 22 Sep 2023 16:43:07 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.6-3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5ffaf4a2-4359-065a-240a-fcfde68c6180@redhat.com>
References: <5ffaf4a2-4359-065a-240a-fcfde68c6180@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <5ffaf4a2-4359-065a-240a-fcfde68c6180@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-3
X-PR-Tracked-Commit-Id: bc3b6f59463ba9f4367a80331213db491766b5a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a457d2804d4c7e76cb4492c6787fdfb7203fc7d
Message-Id: <169540098715.17578.8270823936737311817.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Sep 2023 16:43:07 +0000
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

The pull request you sent on Thu, 21 Sep 2023 18:26:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a457d2804d4c7e76cb4492c6787fdfb7203fc7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
