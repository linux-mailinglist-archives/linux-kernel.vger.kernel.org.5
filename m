Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A495478CBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbjH2SIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjH2SII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C42184
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDA61623B4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 18:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61A62C433CD;
        Tue, 29 Aug 2023 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693332485;
        bh=qiAplGYe5Be1xFOPne3aDHyZ9kyIU2TGd3qgBvNPjJo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hd0vPBTdgFZ+zPWMAqDy3hDf7CoGC5H6B+O3FEuauqr05CWfjM/Zu29ZGdBgUFpFz
         kW+UPPAOlIaRAnmZ+iII2fw/kSfaonj4fHoQwLoqnUvWLKog3y29dA4AvdzB3AFDPW
         yO2ZkihCliJoS9F52kpEcKz4bLVdUKIW21DN6NseWMdhsMIDpuK+DkQJzO1YKHOPlc
         yf4YA6XZ/lw7qMgWrDd9x913Opk84LXyetxloqpxtim1EklI90CvD7DvuzNl56JMhT
         /TEQhmmTf1C2T022PUltDWQHD+hOghPLL6L+TDFfLx6DPqBQuxbcUmlup46qHj+2pm
         z5d3TKC/1kTPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E8AFC3959E;
        Tue, 29 Aug 2023 18:08:05 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230826141412.41764-1-ojeda@kernel.org>
References: <20230826141412.41764-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230826141412.41764-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-6.6
X-PR-Tracked-Commit-Id: 35b464e32c8bccef435e415db955787ead4ab44c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ea0cf77583ec768c8e2403ecb2a930fa948b444
Message-Id: <169333248531.16601.7794575895898949355.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 18:08:05 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Aug 2023 16:14:12 +0200:

> https://github.com/ojeda/linux.git tags/auxdisplay-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ea0cf77583ec768c8e2403ecb2a930fa948b444

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
