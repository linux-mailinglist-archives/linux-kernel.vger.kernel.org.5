Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3F7B4FD6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbjJBKDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjJBKDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:03:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AEE9F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:03:40 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qnFm7-0004i7-7f; Mon, 02 Oct 2023 12:03:39 +0200
Message-ID: <6fe2e258-0d37-43a4-be8d-0c0cc8d50f1d@leemhuis.info>
Date:   Mon, 2 Oct 2023 12:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Fwd: radeon.ko/i586: BUG: kernel NULL pointer dereference,
 address: 00000004
Content-Language: en-US, de-DE
To:     Linux Regressions <regressions@lists.linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>
References: <5f8d4aa5-3b23-8965-57e3-a28bd9aa8e87@gmail.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <5f8d4aa5-3b23-8965-57e3-a28bd9aa8e87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696241021;4a8dbbe2;
X-HE-SMSGID: 1qnFm7-0004i7-7f
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 14.07.23 04:50, Bagas Sanjaya wrote:

> Anyway, I'm adding it to regzbot to ensure it doesn't fall through cracks
> unnoticed:
> 
> #regzbot introduced: b39181f7c6907d https://bugzilla.kernel.org/show_bug.cgi?id=217669
> #regzbot title: FTRACE_MCOUNT_MAX_OFFSET causes kernel NULL pointer dereference and virtual console (tty1) freeze
> #regzbot link: https://gitlab.freedesktop.org/drm/amd/-/issues/2615

#regzbot resolve: root cause likely not solved, but doesn't happen
anymore either
#regzbot ignore-activity

For details see
https://gitlab.freedesktop.org/drm/amd/-/issues/2615#note_2108322

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
