Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6394752C52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjGMVlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjGMVle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D812691;
        Thu, 13 Jul 2023 14:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2B4361B7C;
        Thu, 13 Jul 2023 21:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33C5AC433C8;
        Thu, 13 Jul 2023 21:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689284492;
        bh=3JvPqEa1GFkBw4E++eZtthSt3xnfoZDBIXWi5DtceVw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IHhavEOSY2lVw6TLkVP4vX4cA/Xftf+irYY92S8laMAcLbrPljPFly5hwlG7hqRpR
         XXmx+zcMt2TTRLVeDci/cagwNwKxA35dk72ZOBW26oj+mEe+x31am4WnFU9UqhAQ3s
         w8ZoCUZ0VTRX+KeFaGxK6fU18KlurC2xGcxAJk6WVOJWtihVSnzFZaShAe+8WRuLVl
         /pTbuRarC4ZY99hHZhAln8YKsS0nzcAO+N0MigE1bIN0i+nTpKMphd/7P46sEhwwSp
         OpAnpwf5EGoYe5qEOem2M1L0ZUegInC8vDHC5wfld/JLO76s0g6aMhHpiTj38BjDQO
         yY5tlIp+tR7GQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21F19E29F42;
        Thu, 13 Jul 2023 21:41:32 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC fix for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZK8NY+xAAHRTSEPc@antec>
References: <ZK8NY+xAAHRTSEPc@antec>
X-PR-Tracked-List-Id: <linux-openrisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZK8NY+xAAHRTSEPc@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: dceaafd668812115037fc13a1893d068b7b880f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0099852f9d7322890636503146f303b41cd8663e
Message-Id: <168928449213.12038.10658881121373883641.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jul 2023 21:41:32 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jul 2023 21:30:27 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0099852f9d7322890636503146f303b41cd8663e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
