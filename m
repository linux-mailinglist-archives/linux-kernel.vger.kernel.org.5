Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ADD7DA859
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 20:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjJ1SAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 14:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjJ1SAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 14:00:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FEFC1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 11:00:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4770C433C7;
        Sat, 28 Oct 2023 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698516050;
        bh=ovWI/+SGETu6ibvEB/YkyExcNshtIioTElTeYPOZWxk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FMK4j7YRjfjQTKR4YWPMmIpQgQE8AtESMYyj5WtQTGljMShPR670H2JUi2hsQ/s0a
         6zqYwQYyt8Z+FjF+iDtNWfEzfebxZItQgiZZjtipRvX1O8VNbVfDDuBtXHE05lWzF3
         26ucfDt/bzx2ThWwEHrVo3WV4O4Gxfe4pygBUO9T+1PkuCFw1roZdZM31tjujDtd63
         yoi6ztNVDv/8w/7XiyPIHZorjt8dCoWQm0fGAVTwibWLvEPwA4JRZHPfjaFvNn021V
         arhnp/14OLb+5reYnbRCiQYmlDJZBlLUiu1f45VLrmCquk7qidCzQ2eh6SI9i8Fg6k
         J2C+c/TokWH/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B390FC00446;
        Sat, 28 Oct 2023 18:00:50 +0000 (UTC)
Subject: Re: [git pull] misc fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231028002613.GN800259@ZenIV>
References: <20231028002613.GN800259@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231028002613.GN800259@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: dc32464a5fe4946fe1a4d8f8e29961dc411933c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1b0949f23a343d3153d5c681fb1866538534227
Message-Id: <169851605073.21060.1008604392456111377.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Oct 2023 18:00:50 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 01:26:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1b0949f23a343d3153d5c681fb1866538534227

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
