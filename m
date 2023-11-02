Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202A17DE927
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjKBAB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjKBABX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:01:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A633E119
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:01:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BFE6C433C8;
        Thu,  2 Nov 2023 00:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698883280;
        bh=ntQko+8dkscPDZRJ3pZ8fhtqtiQ5uxRbqAcj1V/+OPw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VDEFXhnTqKO2+JVjxw0Ip6tt4JRxCjc7Qza8nUB0VcFahonXpZYioIdqLF5szkWfI
         +ro4V39oK9Dnt1xI/9iCGBbm2x314qRlv96Hj7ylyMhkjR7LneIMqmP0zwov+Lmt2+
         EBkHXk9Tm4Ja/3aom4JVAXrqdzS/vVuekZmPtx8IFd+3lzh3xY1sIkGoc3awaNzM/h
         BNs+bAHS/XMTy028IdlvhiqSM/vjEtsemzk45TL4xvfx4Cc8A78uob6VCpJhDqAYiK
         1S8W9ikceQo/0T2gdCuFz7WPTDI+9etSj8eVpu1GBzZI1MOW9g+O15Kg/U/DmYekJC
         EWHy/LuwCSbIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BF1DC4316B;
        Thu,  2 Nov 2023 00:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] VFIO updates for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231031115400.570e00d1.alex.williamson@redhat.com>
References: <20231031115400.570e00d1.alex.williamson@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231031115400.570e00d1.alex.williamson@redhat.com>
X-PR-Tracked-Remote: https://github.com/awilliam/linux-vfio.git tags/vfio-v6.7-rc1
X-PR-Tracked-Commit-Id: 2b88119e35b00d8cb418d86abbace3b90a993bd7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: deefd5024f0772cf56052ace9a8c347dc70bcaf3
Message-Id: <169888328023.31464.13235227422474558237.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 00:01:20 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Oct 2023 11:54:00 -0600:

> https://github.com/awilliam/linux-vfio.git tags/vfio-v6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/deefd5024f0772cf56052ace9a8c347dc70bcaf3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
