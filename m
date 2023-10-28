Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF997DA877
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjJ1SRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 14:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjJ1SRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 14:17:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333AED
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 11:17:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C33BC433C8;
        Sat, 28 Oct 2023 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698517064;
        bh=dTvlh6cdqkB5NiPhQLx4frL2C2VnNrFy/jhuQkThw1o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lC/kYO7BnPyJzZIlpO2zENTs9Yc1mTF1jbNrcsyoGXPZvhGjFuubFJb/egZch7xp/
         DJGlTzuidPNm36JjGn+qKEUpnTvo2eP7K9D5A18jhrOoKLG9KoXVHpfv/TpOFq0Y41
         T3UkO5U6J53bQCB7fkSgdVFRk1JK0zVQhz8KJSc9SmMVxFeZavvE0MHyiG0yr4wEQi
         RSREE8vMjieU+COrE/g+d1yb3Ue8SLmWVMZ28pqK6MECCOjYIXiDs9DlIjUB4+FwfB
         fZeNVX8MQ59uW4uXmTBJU4ZllnaFB0hSFIcQvfkyjcTHCyzFEtNur4qnqR9uwf4n8D
         01URRXe8BnUCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 875D1C4316B;
        Sat, 28 Oct 2023 18:17:44 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTzlUz5PMxr36K1S@gmail.com>
References: <ZTzlUz5PMxr36K1S@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTzlUz5PMxr36K1S@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-28
X-PR-Tracked-Commit-Id: a71ef31485bb51b846e8db8b3a35e432cc15afb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4714de03329810b9ac57762b6bfdb73b123fedd5
Message-Id: <169851706454.30729.12166886772743119077.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Oct 2023 18:17:44 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 12:41:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4714de03329810b9ac57762b6bfdb73b123fedd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
