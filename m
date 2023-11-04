Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A4C7E0DF0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 06:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377948AbjKDF0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 01:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378513AbjKDF0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 01:26:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FA51BD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 22:26:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DDEFC433CA;
        Sat,  4 Nov 2023 05:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699075587;
        bh=hoGcU6Q5jstRTcMu1nqrFThdNRVuJBWvXEcP8e/xg4k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f0KV+VikMm+ZgQXIYFBX54115xJWLoSRlEGxtq/RxkKZgI8wVjOxFK1QmzOhNF0om
         eEHnO1WFSayOPuCBlD+85fd8bPrFVzpDwa3DhpWM2H//ZYfSBVtQpmtFkVLu9gs6fB
         0sBD+3IGAOd1McrsttDegXSEiTu6Ka39GfQF5iaUJLd2q2eZC4W8Md+YzTCRAkHXx4
         sMu8z/7BL1tdN1RM1qsdebLhwTgUaRVPtElIzEpIMmA0LN4F9vHSCsY0Vp16MdEL0A
         3E/D6pghVu2f7HYCVQJVa9b4p++OrIkRtbRal8z/JG04Dk/udlw0v/pkJaCGqCu4Of
         HzILBIkSjTANg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D3A0C4316B;
        Sat,  4 Nov 2023 05:26:27 +0000 (UTC)
Subject: Re: [GIT PULL]: SoundWire subsystem updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUTq9b8Ik/KpD9F4@matsya>
References: <ZUTq9b8Ik/KpD9F4@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUTq9b8Ik/KpD9F4@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.7-rc1
X-PR-Tracked-Commit-Id: 4ea2b6d3128ea4d502c4015df0dc16b7d1070954
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be47c8e326c2375200473e442f3481c386a955c4
Message-Id: <169907558724.8300.10731198495486605833.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 05:26:27 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 18:13:33 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be47c8e326c2375200473e442f3481c386a955c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
