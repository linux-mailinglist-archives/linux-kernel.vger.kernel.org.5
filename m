Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780427DD903
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbjJaXAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbjJaXAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:00:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513F7A2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:00:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1754EC433C7;
        Tue, 31 Oct 2023 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698793206;
        bh=csBqL7JQp0a0gst2GPRCTL916vz5zXH62YxjMMW+rkg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TP9SqeED9myKFJ20Cv8WXE3nSWv1uUtULGS9KkzUyRxgwkSq5SyAHgPT/SP+FM9gA
         ZenREY8z49nX9iFVLwF7VnOVA5rbzQ/gmAXczn/zJGY/W6wVObiG+7WpzeXt/RtPQE
         pjKuKBHRq44ZNoUga4a4I2OxHQfCRVRuCA/Qb5edDmckscWrPSYgEOuWbiasLrBZDD
         EEGMWOxqNr/XOmgVyRs/ZGlxZsFhzT+NbQYQdT+PvaOAq/ql1AJ5/PZkBr3Ln8+fgm
         KrckVM7bMiMh7Qi3AX8HWvZ2Sg/LGw4Fu1vyb5zf0U556lW5quT3M/S9l/kruj9Ror
         yxU/ggtDCynYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECFD6E00094;
        Tue, 31 Oct 2023 23:00:05 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231028011741.2400327-1-kuba@kernel.org>
References: <20231028011741.2400327-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231028011741.2400327-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.7
X-PR-Tracked-Commit-Id: f1c73396133cb3d913e2075298005644ee8dfade
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89ed67ef126c4160349c1b96fdb775ea6170ac90
Message-Id: <169879320594.20683.11021135438546525382.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 23:00:05 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 18:17:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89ed67ef126c4160349c1b96fdb775ea6170ac90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
