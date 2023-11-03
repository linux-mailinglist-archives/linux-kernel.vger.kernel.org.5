Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725CB7E0A48
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378360AbjKCUX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378350AbjKCUXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:23:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8E010F4;
        Fri,  3 Nov 2023 13:23:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 137D5C433CD;
        Fri,  3 Nov 2023 20:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699042952;
        bh=GzaYSja1uiN6t2jxvr8EI8D9zTug93Ft2Png/Vob6mw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OIAyNtZTf8rEVY5nnjaZV/8JaiIruyVKh7rGI1RrS9XVqjoeSvXdLFOnHu6024c8j
         avCJA2I00OnqN8cuRl+rzH80tOKjzn2Z3i/OE4LJ7CeYy+/boiAxDbZsZeePbNEp/Q
         /atRkuioIyiKpRaIlB8Y8YgYQ5v0mzWAii0qxgg6bladiBmJhRW9sbWWoMpGdlwy2P
         Z2I4tf6SzVnNLd1taTMew0l4mivySKZXX7BfaJ3Fn3B9ZUz6hXcIXpaG57o3Ov2VRd
         shTPiafPEKE3BGUAPzGNHoE/Mk4RsTf1R30DEY3XEZDqeHNCfVB1KXuz2knhsR45sf
         ehg8vf+ktT2aQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01B17C04DD9;
        Fri,  3 Nov 2023 20:22:32 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 6.7 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01699033818-ext-2437@work.hours>
References: <your-ad-here.call-01699033818-ext-2437@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01699033818-ext-2437@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.7-1
X-PR-Tracked-Commit-Id: 991a211aa99f468cd291a97b8dcb448ebc77f6c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e392ea4d4d00880bf94550151b1ace4f88a4b17a
Message-Id: <169904295199.5035.17247982168288402277.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 20:22:31 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 18:50:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e392ea4d4d00880bf94550151b1ace4f88a4b17a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
