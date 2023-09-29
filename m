Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF627B32BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjI2MnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjI2MnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:43:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67C6B7;
        Fri, 29 Sep 2023 05:43:20 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qmCpx-0005CV-Fm; Fri, 29 Sep 2023 14:43:17 +0200
Message-ID: <8611e2cf-f529-43cd-ba44-3eccf1b26fd1@leemhuis.info>
Date:   Fri, 29 Sep 2023 14:43:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: iwlwifi: AX210 Timeout waiting for hardware access
 (CSR_GP_CNTRL 0xffffffff)
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Ronan Pigott <ronan@rjp.ie>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>
References: <c64ce498-7c06-3726-47d5-0a74471f027b@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <c64ce498-7c06-3726-47d5-0a74471f027b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695991400;ead0724c;
X-HE-SMSGID: 1qmCpx-0005CV-Fm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.23 02:42, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
>
> [...]
> 
> See Bugzilla for the full thread and attached journal logs.
> 
> On BZ, I have asked the reporter (Cc'ed) to test the mainline.
> 
> Anyway, I'm adding this regression to regzbot:
> 
> #regzbot introduced: 399762de769c4e https://bugzilla.kernel.org/show_bug.cgi?id=217894
> #regzbot title: CSR_GP_CNTRL hardware access timeout due to firmware API bump

According to a bugzilla comment things at some point suddently started
working again for the reporter. Wonder if the system got new a new
linux-firmware package? This smells like there is a bigger problem in
that area, will keep an eye out for it. But for now let's close this:

#regzbot resolve: things suddenly started to work for the reporter

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
