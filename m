Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF18C78C71A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbjH2OP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbjH2OPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:15:10 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAD5198;
        Tue, 29 Aug 2023 07:15:04 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qayy9-0007ZN-KV; Tue, 29 Aug 2023 15:41:21 +0200
Message-ID: <76267453-de42-ebc5-7283-6a20af5af3b9@leemhuis.info>
Date:   Tue, 29 Aug 2023 15:41:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tools/perf: Fix to get declared file name from
 clang DWARF5
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <166731050151.2100653.8202870942871353491.stgit@devnote3>
 <166731052936.2100653.13380621874859467731.stgit@devnote3>
 <5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net>
 <8f21a1ca-3bbb-f37d-47f6-35648d3d7763@leemhuis.info>
In-Reply-To: <8f21a1ca-3bbb-f37d-47f6-35648d3d7763@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693318504;e0f3f480;
X-HE-SMSGID: 1qayy9-0007ZN-KV
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

On 15.06.23 13:42, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:

> On 09.06.23 14:21, Georg Müller wrote:
>>
>> Am 01.11.22 um 14:48 schrieb Masami Hiramatsu (Google):
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Fix to get the declared file name even if it uses file index 0
>>> in DWARF5, using custom die_get_decl_file() function.
>>
>> this patch breaks perf probe on fedora 38.

#regzbot fix: c66e1c68c13b87250
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


