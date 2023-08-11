Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF0D7788B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjHKIBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjHKIBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:01:34 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE902130
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:01:29 -0700 (PDT)
Received: from 46.183.103.8.relaix.net ([46.183.103.8] helo=[172.18.99.178]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qUN5J-000677-KJ; Fri, 11 Aug 2023 10:01:26 +0200
Message-ID: <ea44e743-10a0-6a2d-d1a7-92d411674790@leemhuis.info>
Date:   Fri, 11 Aug 2023 10:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use
 pte_offset_kernel()
Content-Language: en-US, de-DE
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
References: <42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk>
 <901ae88d-ad0c-4e9d-b199-f1566cc62a00@lucifer.local>
 <c2358f37-ebaa-44d1-b443-ff91bdedc00b@sirena.org.uk>
 <977ddee4-35f0-fcd1-2fd-1c3057e7ea2a@google.com>
 <fbb2b76c-bc5c-4d75-b8cd-37479de688d4@sirena.org.uk>
 <b479b946-f052-eb75-295d-6fa7c2d8ce8e@google.com>
 <591b5253-47f0-440c-84b6-7786ff59667d@sirena.org.uk>
 <20230720103227.GB11034@willie-the-truck>
 <df264993-107c-44a1-a8ff-245bce044206@sirena.org.uk>
 <88bb7f30-cbfe-feb4-1101-b7c98843652d@leemhuis.info>
 <59946f0b-2a31-4bb2-a5a5-a051f3978c26@sirena.org.uk>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <59946f0b-2a31-4bb2-a5a5-a051f3978c26@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691740890;6654904d;
X-HE-SMSGID: 1qUN5J-000677-KJ
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.23 13:09, Mark Brown wrote:
> On Tue, Aug 08, 2023 at 07:52:43AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
>> Hi Mark, just wondering did anything come out of this and is this still
>> happening? I'm just wondering, as I still have this on my list of
>> tracked regressions.
> 
> It's fixed.

In that case:

#regzbot resolve: fixed according to reporter
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
