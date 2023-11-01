Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEB07DDC31
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347644AbjKAEye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347630AbjKAEy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:54:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75D5ED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:54:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66C9BC433C9;
        Wed,  1 Nov 2023 04:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698814466;
        bh=pOb2dPfuHoBseMtOYz1vwAT6FtcTW6En3XzFJnDRmeY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tf76MK4MMBLZLw4VDrNop8t04E78BKcleewl7ffDlX8Li+lreHa/nDRDK33kwHZaC
         /uyex61nXzYUGkuzrmYsLibk1uWUpJ8lr4Ynh0KA3ISosSNBw6opIlyvJJiddeY7Hs
         iSu4xwaAX0P3Z6EyVraeRDeGUd0U3IL50sC95ZNeFbRy/zip2Zxy/gPHQLRuuNLtA8
         N3aYj9dOZdDiIBcfYLBvbNYB0KU5FDo+f5/2LnG1s2vkYtVNMdHlUVtJUHeoPY1cYx
         LQ7/b+JPJVfJcoqznEsSqs10RT68gnSBg4+WmgTVOfUEd2575xstIm9IP3oewGcbwx
         buhStcw4/kpVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 531A0E00090;
        Wed,  1 Nov 2023 04:54:26 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231031214808.GA2178025-robh@kernel.org>
References: <20231031214808.GA2178025-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231031214808.GA2178025-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.7
X-PR-Tracked-Commit-Id: fe612629746cf5cc7040529f780d46929605d0a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bc9e6515183935fa0cccaf67455c439afe4982b
Message-Id: <169881446633.23637.8802111292131125661.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 04:54:26 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Oct 2023 16:48:08 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bc9e6515183935fa0cccaf67455c439afe4982b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
