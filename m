Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD27781D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjHJTuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjHJTuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:50:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595D92720
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0EBE66850
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51746C433C7;
        Thu, 10 Aug 2023 19:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691697011;
        bh=kLv4vyduu7WJU7euBZ0ODgTv7t48G4KM1MACUJx109o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LlXAD/YSUMPSAa+gCisWFBJSXf4D1DO17BwHHDFxFCpV6TN1FoIjEgO8lvMoDJ562
         8tUDXx1oZbpoiszpl53Jadlda4uChCbQAh4dR6WlMDENrrSScvBcw3FPPOTBrqp7/k
         JXMj12AFI888lnuNVQj05fHSXG4CdGjzMalc2MFpksEB8weD32iVocwEdIJMJ+W/hz
         VQl70/D/AvMwr57rqbLFJwNtRIHdBwE80ItrXPRWO6xlcSbJwX89Te2Pt3634iFDHJ
         hF/SDg4CrmaCTEaG8J+fiovn0vyRGk9JmHHtca65fMLN8Zo6vz4fO2CcLr8gYF4EOZ
         Lnwt9iY6tGSbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3278EC39562;
        Thu, 10 Aug 2023 19:50:11 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZNSVz2T48G7Xe1SJ@matsya>
References: <ZNSVz2T48G7Xe1SJ@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZNSVz2T48G7Xe1SJ@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.5
X-PR-Tracked-Commit-Id: 422dbc66b7702ae797326d5480c3c9b6467053da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30813656c6b827947be024484d6da8b18e50c186
Message-Id: <169169701119.10479.12432326201011163787.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Aug 2023 19:50:11 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Aug 2023 08:46:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30813656c6b827947be024484d6da8b18e50c186

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
