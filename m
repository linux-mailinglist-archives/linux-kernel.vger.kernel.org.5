Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF73D7BCE33
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344711AbjJHLci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjJHLch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:32:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A2A8F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:32:35 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qpS1R-0005VW-2h; Sun, 08 Oct 2023 13:32:33 +0200
Message-ID: <019424f6-b39b-41d9-bb4a-40bfc8953d98@leemhuis.info>
Date:   Sun, 8 Oct 2023 13:32:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.6-rc3 (DEBUG_VIRTUAL is unhappy on x86)
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <CAHk-=wjrZgxjHZuXwrGeFnng_whUmtToCWE5GQ+HORhGSeiX8g@mail.gmail.com>
 <ZRhKq6e5nF/4ZIV1@fedora>
 <ccfe98b1-7179-45bb-bc6e-8d921c042eec@leemhuis.info>
In-Reply-To: <ccfe98b1-7179-45bb-bc6e-8d921c042eec@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696764755;19fcee3f;
X-HE-SMSGID: 1qpS1R-0005VW-2h
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.23 14:24, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> 
> On 30.09.23 18:26, Hyeonggon Yoo wrote:
>>
>> [...]
>>
>>> Peter Zijlstra (1):
>>>       x86,static_call: Fix static-call vs return-thunk
>>
>> Hello, the commit above caused a crash on x86 kernel with
>> CONFIG_DEBUG_VIRTUAL=y.
> 
> #regzbot ^introduced aee9d30b9744d6775
> #regzbot title x86,static_call: crash on x86 kernel with
> CONFIG_DEBUG_VIRTUAL=y.
> #regzbot ignore-activity

#regzbot monitor:
https://lore.kernel.org/lkml/20231006051801.423973-1-sumit.garg@linaro.org/
#regzbot fix: KEYS: trusted: Remove redundant static calls usage
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
