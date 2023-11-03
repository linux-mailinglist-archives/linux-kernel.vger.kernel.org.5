Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBE37DFDA7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377216AbjKCBAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344962AbjKCBAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:00:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A3A1A5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:00:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EE95C433D9;
        Fri,  3 Nov 2023 01:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698973227;
        bh=TSH/9LqI4toJQPZg0HF1TKnGgucPFOIoMwxlPc5gXO8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AV1tWfn+KD5HvL/nhGz1Can7zyfzQayPD59+Pe7eETxgtresb1twtLNs1BfjvVbNP
         SGdQ2gUNiP9YGXURFJBOWFsCQD/oDjJhASoWFV7b2m2/4ceMqG6DeLdh+oZ2k4+UDq
         2lxyd1nKprdj+1htui9SXqerwxk9cGASn3eFtGdejNe3M/bGpFteIznMzFHPCcLQph
         jDCkgmgsvjn1SyYpHcS8i2/2R5pULSteqVKbxQ7O6PKfenu9vir+NwhjJ3+AwYpImp
         wRR0eOW/gqshtHK6eCZQ24V9GtUyQtJtW8umv7K3gqhlauf3Csaxv1JnNe2lAnPbi1
         bEWiJZnHpIDWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CB39EAB08B;
        Fri,  3 Nov 2023 01:00:27 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231102143041.GY8909@google.com>
References: <20231102143041.GY8909@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231102143041.GY8909@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.7
X-PR-Tracked-Commit-Id: d5272d39995f4150062a67e6f2cef556edece740
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38984d78721811c45c4a194784133254903697eb
Message-Id: <169897322717.13409.6076258390747204752.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 01:00:27 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Nov 2023 14:30:41 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38984d78721811c45c4a194784133254903697eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
