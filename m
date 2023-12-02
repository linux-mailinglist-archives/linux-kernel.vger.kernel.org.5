Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B566A801FCE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjLBXwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 18:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjLBXwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:52:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E89C8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 15:52:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B19AC433CA;
        Sat,  2 Dec 2023 23:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701561164;
        bh=8pI1kBZE2n42eBSeESHipDtfuEYuFGMc4j17vAkRywE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aDCBgnXDl7rW1hCaanbXplMN5betDxiBuk/llN62tMnHO2UDrmXJBDEunpPI6yg/h
         vXYU+Qi0oLXw/RRBNWrU4KhqngUkky2WNulvnCkxZ49Uc3ONmIIkp6tQJ83xB+ftDx
         D4XDVJkbeHq7LTRtYsysh/ulMm2eazxQLJd3aF5R5/3JZugr9fKW2YsoyKBnSf/VCA
         V3sXVBqWkmTFjVOJAI8kRDtSxKaVmiYmggCzgfDY+D/q11/acei5WX1DVd07s5VTQA
         YxwL53gGzYELvHzbvRWPXhsP4KioSH87xVI9ktRPKicNTehAZiCmaq30/VRfB+SDYF
         T/v6c/z2ySgPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A3C8DFAA84;
        Sat,  2 Dec 2023 23:52:44 +0000 (UTC)
Subject: Re: [GIT PULL] VFIO fix for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231201162209.1298a086.alex.williamson@redhat.com>
References: <20231201162209.1298a086.alex.williamson@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231201162209.1298a086.alex.williamson@redhat.com>
X-PR-Tracked-Remote: https://github.com/awilliam/linux-vfio.git tags/vfio-v6.7-rc4
X-PR-Tracked-Commit-Id: 4ea95c04fa6b9043a1a301240996aeebe3cb28ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17b17be28d42f59f579ef9da2557b92a97291777
Message-Id: <170156116423.30388.7214139415340277781.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Dec 2023 23:52:44 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Dec 2023 16:22:09 -0700:

> https://github.com/awilliam/linux-vfio.git tags/vfio-v6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17b17be28d42f59f579ef9da2557b92a97291777

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
