Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC37B343D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjI2OGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjI2OGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:06:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643E1B8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:06:38 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qmE8a-0003Oq-N4; Fri, 29 Sep 2023 16:06:36 +0200
Message-ID: <89cb7e1c-8b87-4072-af90-e920a9d69b88@leemhuis.info>
Date:   Fri, 29 Sep 2023 16:06:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Read from RTC broken upon resume from suspend on HP Pro x360
 435 G9 w/ AMD Ryzen 7 5825U
Content-Language: en-US, de-DE
To:     Linux Regressions <regressions@lists.linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
References: <591e089a-6ccd-c5f3-4cd4-a332e2eae724@gmail.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <591e089a-6ccd-c5f3-4cd4-a332e2eae724@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695996398;4af6d0f4;
X-HE-SMSGID: 1qmE8a-0003Oq-N4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.23 15:25, Bagas Sanjaya wrote:
> Anyway, I'm adding it to regzbot:
> 
> #regzbot introduced: d2a632a8a11756 https://bugzilla.kernel.org/show_bug.cgi?id=217626
> #regzbot title: reducing RTC_UIP polling period causes broken RTC on resume from suspend

#regzbot resolve: apparently resolved by a BIOS update
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
