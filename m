Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D637C87F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjJMOiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjJMOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:38:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D684C0;
        Fri, 13 Oct 2023 07:38:16 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qrJIs-00068P-Ls; Fri, 13 Oct 2023 16:38:14 +0200
Message-ID: <2519b67c-58d3-4f87-9513-5321b1722b60@leemhuis.info>
Date:   Fri, 13 Oct 2023 16:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix regression in sed-opal for a saved key.
Content-Language: en-US, de-DE
To:     regressions@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20231003100209.380037-1-gmazyland@gmail.com>
 <5c4fbafb1daa45f2faf60c7d587cd23c53d9393c.camel@linux.vnet.ibm.com>
 <59535b4b-9f07-44c5-a7da-e6b2fc1c67bb@gmail.com>
 <53755a0fbd6318d4783078259f2d2f8ab5f2f0b7.camel@linux.vnet.ibm.com>
 <acf5d5b5-b3d9-403d-ad57-a865774b260f@gmail.com>
 <10b46003-2a75-49a7-8c74-cd8e3d4915c3@kernel.dk>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <10b46003-2a75-49a7-8c74-cd8e3d4915c3@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697207896;d6569067;
X-HE-SMSGID: 1qrJIs-00068P-Ls
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 13.10.23 16:17, Jens Axboe wrote:

> Was waiting on Greg to ack/review it, which it looks like he kind of
> has. But would've been nice with a formal ack on it. I've queued it up
> now.

#regzbot fix: block: Fix regression in sed-opal for a saved key.
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

