Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889AC7FFF67
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377284AbjK3XYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377267AbjK3XY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:24:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488D10F8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:24:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B384C433C8;
        Thu, 30 Nov 2023 23:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701386674;
        bh=nvvbPETKardh7d1tAn3mdJvk/G0HxoiSnunSAWYJf+g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bdHemeiDxPzrEMdUT8RZQjE4FrwbB67z0PH+3YNIWDMiped4u8ZEvJ9vg88IkQgdG
         WpUn5RdaTNGKGfoK1kAGab/LTFOTyorpMTasy/GXYSrCYdhulDxLeGedcJoLc+BlGm
         B4H57X5vIG74NxbM3g0x5D4qDikVWcRmXqYL2tUvOoTpqqVP8TZYfXEP0lKTs6+9Co
         3gxsGofo2XxZhRMyfeMnYVjtgacgU3KXt5dA2u8wFIzih6aDB+QPU7bsCRi8HfXN4Q
         phuqe1lOZxQXlPiR8swNbv9Z23qCMF+qtIUSrVJVdTkGf1/GVeZbuGSgR5OOPi261g
         f7CBNtj+Gf/Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5909ADFAA82;
        Thu, 30 Nov 2023 23:24:34 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231130112928.64992-1-ulf.hansson@linaro.org>
References: <20231130112928.64992-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231130112928.64992-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.7-rc2
X-PR-Tracked-Commit-Id: 0cb19e50a911aaadf49eed120392e429d6e1fa0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8f60209d6cf652a9cfda64371acea69f62770aa
Message-Id: <170138667435.16887.9779453877181969899.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Nov 2023 23:24:34 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Nov 2023 12:29:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8f60209d6cf652a9cfda64371acea69f62770aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
