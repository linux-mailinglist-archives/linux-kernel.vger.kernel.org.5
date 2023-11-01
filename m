Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2AF7DDC30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347647AbjKAEyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347633AbjKAEy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:54:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0272BF4;
        Tue, 31 Oct 2023 21:54:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4940C433D9;
        Wed,  1 Nov 2023 04:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698814466;
        bh=eMurPonXoityWhVevpHSB0X0xLMZVeSyVtub91CFVkE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gj8My40h8Td/1dTes+1/DlIYN2U6Ogm0l9bldH5eDilv5P4Id0rOXfpKoTApNWLzx
         9qWz37WJXxutTmw+1jRTq9ZNUMD4rdy1EWza7UfMM8MtCtJg0L7QBx90I3TVYZwUyE
         i7U2GEVNUJywyHhz2VKt1kiy/WUyH1gk14yM/IsRqYgg0ddLtNF4RSU/YSpnEYpNO8
         sgmFQFwNDsD/Bevz3NVRhMEBO7ga9yem5PYggJeqvTw6jxr23WnGccNsrHEwT6+T/A
         yQWg+QDb//OG8J+kp7/v4pKkMSfvegrGieluthkt/uj012tPtze6KoQAK8mbZsoJ5B
         EKQyPbInHGQxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F532C4166F;
        Wed,  1 Nov 2023 04:54:26 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231101000916.tu3prtolpiwumnxu@mercury.elektranox.org>
References: <20231101000916.tu3prtolpiwumnxu@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231101000916.tu3prtolpiwumnxu@mercury.elektranox.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.7
X-PR-Tracked-Commit-Id: 469d31745b9fb3a87424b311abb7cb530611404f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9ae180416e04bcee4d3cd216a6264a50f9299e6
Message-Id: <169881446658.23637.11690698226579469925.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 04:54:26 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Nov 2023 01:09:16 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9ae180416e04bcee4d3cd216a6264a50f9299e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
