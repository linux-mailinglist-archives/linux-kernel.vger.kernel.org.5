Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F17975FC58
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjGXQjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjGXQjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12ED18E;
        Mon, 24 Jul 2023 09:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F5EB6126E;
        Mon, 24 Jul 2023 16:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3BC6C433C9;
        Mon, 24 Jul 2023 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690216767;
        bh=37s4TxYwzRRPRfHRgS8f9yeg9LcCDjhWrxKYuAsrmT0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uGHcN02axiexiW/uqwYz33z+hqLrgR0vAtlZi3VqUjxFZGe3KO8wRMCkYWaDe7SmN
         2OfC0mroXBiFEUAMfNIUV6f79006q9ENJrP3Ukkd1hBwnmQrhQ9ooWrDSaGTZWUdje
         w7t0Srf/ChaiRxPNv2H32O6EdFyKzth62SeRqz4b3tqPJK9hYS/2e4ttFqYJoBdc79
         E0Rr7BUR/PKMffRYB56w2JqaTgUnFn6Pgq0qlD79kg9fDMu1oEh0peCUvTtmrPIjXJ
         CngbNAHCniKUxTrzTm1+XyiepTmi5aQrPaXhP+EgoxlmgGWOYrnsIIJ1EtCjLSxA6n
         gNhuKTA3t2E0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6192E1F65A;
        Mon, 24 Jul 2023 16:39:27 +0000 (UTC)
Subject: Re: [GIT PULL for v6.5-rc4] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230724121150.1d55ce6b@coco.lan>
References: <20230724121150.1d55ce6b@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230724121150.1d55ce6b@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-2
X-PR-Tracked-Commit-Id: 0cb1d9c845110ce638a43a1417c7df5968d1daa3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e0ee0c7545c7ec012a53878e7687e05b87abc75
Message-Id: <169021676780.29251.11317321803832138971.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Jul 2023 16:39:27 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Jul 2023 12:11:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e0ee0c7545c7ec012a53878e7687e05b87abc75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
